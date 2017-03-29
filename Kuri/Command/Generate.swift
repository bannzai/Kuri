//
//  Generate.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/22.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation

struct Generate: CommandProtocol {
    let args: [String]
    let yamlReader: YamlReader
    
    fileprivate var prefix: String? {
        return args.first
    }
    fileprivate var options: [String] {
        return Array(args.dropFirst())
    }
    fileprivate var hasOption: Bool {
        return !options.isEmpty
    }
    
    fileprivate var templateDirectoryName: String? = nil
    fileprivate var generateComponents: [String] = []
    
    init(
        args: [String],
        yamlReader: YamlReader
        ) {
        self.args = args
        self.yamlReader = yamlReader
    }
    
    mutating func execute() throws {
        guard let entityName = prefix else {
            throw KuriErrorType.missingArgument("Should input generate entity name")
        }
        
        let offsetAndOption = try options.enumerated()
            .filter { $1.contains("-") }
            .map { (offset: $0, option: try OptionType(shortCut: $1)) }
            .sorted { $0.0.option.hashValue > $0.1.option.hashValue }
        
        try offsetAndOption.forEach { offset, option in
            try setupForExec(with: option)
        }
        
        if templateDirectoryName == nil {
            templateDirectoryName = "KuriTemplate"
        }
        
        guard let templateDirectoryName = templateDirectoryName else {
            throw KuriErrorType.readYamlError("Unexpected read template name")
        }
        
        generateComponents = main.run(bash: "find \(templateDirectoryName) -maxdepth 2 -type d")
            .components(separatedBy: "\n")
            .flatMap {
                $0.components(separatedBy: "/").last
            }
            .filter {
                $0 != "KuriTemplate" && $0 != "Implement" && $0 != "Interface" 
            }
            .filter {
                !$0.isEmpty
        }
        
        guard hasOption else {
            try generateOnce(with: entityName, for: generateComponents)
            return
        }
        
        try generateOnce(with: entityName, for: generateComponents, templateDirectoryName: templateDirectoryName)
    }
}

extension Generate {
    enum OptionType: String, ArgumentOptionProtocol {
        case templateSpecify
        case specify
        case interactive
        
        init(shortCut: String) throws {
            switch shortCut {
            case OptionType.templateSpecify.shortCut:
                self = .templateSpecify
            case OptionType.specify.shortCut:
                self = .specify
            case OptionType.interactive.shortCut:
                self = .interactive
            default:
                throw KuriErrorType.missingArgument(assertionMessage(description: "Unknown option for \(shortCut)"))
            }
        }
        
        fileprivate var shortCut: String {
            switch self {
            case .templateSpecify:
                return "-t"
            case .specify:
                return "-s"
            case .interactive:
                return "-i"
            }
        }
    }

    fileprivate mutating func setupForExec(with option: Generate.OptionType) throws {
        switch option {
        case .templateSpecify:
            templateDirectoryName = try executeForTemplateSpecify()
        case .specify:
            generateComponents = try executeForSpecity()
            templateDirectoryName = Setup.templateDirectoryName
        case .interactive:
            generateComponents = try executeForInteractive()
            templateDirectoryName = Setup.templateDirectoryName
        }
    }
    
    fileprivate func executeForInteractive() throws -> [String] {
        let answeredComponents = try generateComponents.filter {
            let message = "Do you want to \($0) [y/N]"
            let answer = try CommandInput.waitStandardInputWhileInvalid(
                with: message,
                validation: { (input) -> Bool in
                    return input == "y" || input == "Y" || input == "n" || input == "N"
            })
            return answer == "y" || answer == "Y"
        }
        
        return answeredComponents
    }
    
    fileprivate func executeForSpecity() throws -> [String] {
        let optionArguments = try optionArgument(for: OptionType.specify)
        if optionArguments.isEmpty {
            // generate specify XXXX
            throw KuriErrorType.missingArgument("Should write for componentType. e.g kuri -s View")
        }
        
        let components = optionArguments.filter {
            return generateComponents.contains($0)
        }
        return components
    }
    
    fileprivate func executeForTemplateSpecify() throws -> String {
        let templateSpecity = OptionType.templateSpecify
        
        guard let templateDirectoryName = try optionArgument(for: templateSpecity).first else {
            throw KuriErrorType.missingArgument("Not enough argument for kuri \(templateSpecity.shortCut)")
        }
        
        return templateDirectoryName
    }
    
    fileprivate func optionArgument(for option: OptionType) throws -> [String] {
        let isMatchOption: ((String) -> Bool) = { string in
            return option.shortCut == string || option.rawValue == string
        }
        
        let optionAndArgument = options.reduce([String]()) { result, optionString in
            let isMatch = isMatchOption(optionString)
            if isMatch {
                return result + [optionString]
            }
            
            if optionString.contains("-"), !isMatch {
                return result
            }
            
            if result.count > 0 {
                return result + [optionString]
            }
            
            return result
        }
        
        guard optionAndArgument.count > 1 else {
            throw KuriErrorType.missingArgument("Not enough argument for kuri \(option.shortCut)")
        }
        
        return Array(optionAndArgument.dropFirst())
    }
}

fileprivate extension Generate {
    fileprivate func convert(for content: String, to structure: String) -> String {
        let userName = run(bash: "echo $USER")
        let date = { _ -> String in
            let component = Calendar(identifier: .gregorian).dateComponents([.year, .month, .day], from: Date())
            guard
                let year = component.year,
                let month = component.month,
                let day = component.day
                else {
                    return "unknown date"
            }
            return "\(year)/\(month)/\(day)"
        }()
        
        let replacedContent = generateComponents
            .reduce(content) { content, componentType in
                let suffix = yamlReader.customSuffix(for: componentType) ?? componentType
                return content
                    .replacingOccurrences(of: componentType, with: structure + suffix) // TODO: convert from template
                    .replacingOccurrences(of: "__USERNAME__", with: userName)
                    .replacingOccurrences(of: "__DATE__", with: date)
        }
        return replacedContent
    }
    
    fileprivate func generateOnce(with prefix: String, for components: [String], templateDirectoryName: String? = nil) throws {
        try generate(with: prefix, for: components, templateDirectoryName: templateDirectoryName)
    }
    
    private func generate(with prefix: String, for components: [String], templateDirectoryName: String? = nil) throws {
        print("Begin generate")
        defer {
            print("End generate")
        }
        var pathAndXcodeProject: [String: XCProject] = [:]
        try components.forEach { componentType in
                let typeFor = componentType
                
                let kuriTemplatePath = templateDirectoryName != nil ?
                    yamlReader.templateRootPath(from: typeFor) + "./" + templateDirectoryName! + "/" :
                    yamlReader.kuriTemplatePath(from: typeFor)
                let templatePath = kuriTemplatePath + componentType + "/" + componentType
                let generateRootPath = yamlReader.generateRootPath(from: typeFor)
                let projectRootPath = yamlReader.projectRootPath(from: typeFor)
                let projectFileName = yamlReader.projectFileName(from: typeFor)
                
                let projectFilePath = projectRootPath + projectFileName + "/"
                let directoryPath = generateRootPath + prefix + "/" + componentType + "/"
                let suffix = yamlReader.customSuffix(for: componentType) ?? componentType
                let filePath = directoryPath + prefix + suffix + ".swift"
                
                let project: XCProject
                if let alreadyExistsProject = pathAndXcodeProject[projectFilePath] {
                    project = alreadyExistsProject
                } else {
                    let xcodeprojectFileUrl = URL(fileURLWithPath: projectFilePath + "project.pbxproj")
                    project = try XCProject(for: xcodeprojectFileUrl)
                    pathAndXcodeProject[projectFilePath] = project
                }
                
                let fileOperator = FileOperator(fileManager: Files)
                guard let templateContent = try? fileOperator.read(for: templatePath) else {
                    print("can't find: \(componentType)")
                    return
                }
                let writeCotent = convert(for: templateContent, to: prefix)
                try fileOperator.createDirectory(for: directoryPath)
                fileOperator.createFile(for: filePath)
                
                let targetName = yamlReader.targetName(from: typeFor)
                project.appendFilePath(
                    with: projectRootPath,
                    filePath: filePath,
                    targetName: targetName
                )
                
                try fileOperator.write(to: filePath, this: writeCotent)
                
                print("created: \(filePath)")
        }
        
        try pathAndXcodeProject.values.forEach {
            try $0.write()
            
            print("write in project: \($0.projectName).xcodeproj")
        }
    }
}

