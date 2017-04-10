//
//  Generator.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/22.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation

struct Generator {
    let argument: GenerateArgument
    let yamlReader: YamlReader
    
    fileprivate var templateDirectoryName: String
    fileprivate var generateComponents: [GenerateComponent]
    
    init(
        argument: GenerateArgument,
        yamlReader: YamlReader
        ) {
        self.argument = argument
        self.yamlReader = yamlReader
        
        templateDirectoryName = yamlReader.templateRootPath()
        generateComponents = main.run(bash: "find \(templateDirectoryName) -name '*.swift'")
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }
            .map( GenerateComponent.init )
    }
    
    mutating func execute() throws {
        guard let entityName = argument.prefix else {
            throw KuriErrorType.missingArgument("Should input generate entity name")
        }
        
        let offsetAndOption = try argument.options.enumerated()
            .filter { $1.contains("-") }
            .map { (offset: $0, option: try OptionType(shortCut: $1)) }
            // order by priority for execute option
            .sorted { $0.0.option.hashValue > $0.1.option.hashValue }
        
        try offsetAndOption.forEach { offset, option in
            switch option {
            case .templateSpecify:
                overwriteTemplateDirectory(for: option)
            case .specify, .interactive:
                overwriteGenerateComponents(for: option)
            }
        }
        
        guard argument.hasOption else {
            try generate(with: entityName, for: generateComponents)
            return
        }
        
        try generate(with: entityName, for: generateComponents)
    }
    
    mutating func overwriteTemplateDirectory(for option: OptionType) {
        switch option {
        case .templateSpecify:
            break
        default:
            fatalError("Unexpected option for \(option.rawValue)")
        }
        
        guard let templateDirectoryName = argument.options.first else {
            fatalError("Unexpected option for \(option.rawValue) and argument value: \(argument.options)")
        }
        
        self.templateDirectoryName = templateDirectoryName
    }
    
    mutating func overwriteGenerateComponents(for option: OptionType) {
        switch option {
        case .templateSpecify:
            break
        case .specify, .interactive:
            overwriteGenerateComponents(for: option)
        }
    }
}

extension Generator {
    enum OptionType: String {
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
        
        var shortCut: String {
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

    fileprivate func generateComponentsForInteractive() throws -> [GenerateComponent] {
        let answeredComponents = try generateComponents.filter {
            let message = "Do you want to \($0.componentType) [y/N]"
            let answer = try CommandInput.waitStandardInputWhileInvalid(
                with: message,
                validation: { (input) -> Bool in
                    return input == "y" || input == "Y" || input == "n" || input == "N"
            })
            return answer == "y" || answer == "Y"
        }
        
        return answeredComponents
    }
    
    fileprivate func generateComponentsForSpecity() throws -> [GenerateComponent] {
        let optionArguments = try argument.optionArgument(for: OptionType.specify)
        if optionArguments.isEmpty {
            throw KuriErrorType.missingArgument("Should write for componentType. e.g kuri -s View")
        }
        
        let components = generateComponents.filter { component in
            return optionArguments.contains { option in
                return component.componentType == option
            }
        }
        return components
    }
    
    fileprivate func executeForTemplateSpecify() throws -> String {
        let templateSpecity = OptionType.templateSpecify
        
        guard let templateDirectoryName = try argument.optionArgument(for: templateSpecity).first else {
            throw KuriErrorType.missingArgument("Not enough argument for kuri \(templateSpecity.shortCut)")
        }
        
        return templateDirectoryName
    }
    
}

fileprivate extension Generator {
    struct DateComponent {
        let year: Int
        let month: Int
        let day: Int
        
        var date: String {
            return "\(year)/\(month)/\(day)"
        }
    }
    fileprivate func convert(for content: String, to prefix: String) -> String {
        let userName = run(bash: "echo $USER")
        let date: DateComponent = { _ -> DateComponent in
            let component = Calendar(identifier: .gregorian).dateComponents([.year, .month, .day], from: Date())
            guard
                let year = component.year,
                let month = component.month,
                let day = component.day
                else {
                    fatalError("Can't get system date")
            }
            return DateComponent(year: year, month: month, day: day)
        }()
        
        let replacedContent = content
            .replacingOccurrences(of: "__PREFIX__", with: prefix)
            .replacingOccurrences(of: "__USERNAME__", with: userName)
            .replacingOccurrences(of: "__DATE__", with: date.date)
            .replacingOccurrences(of: "__YEAR__", with: "\(date.year)")
            .replacingOccurrences(of: "__MONTH__", with: "\(date.month)")
            .replacingOccurrences(of: "__DAY__", with: "\(date.day)")
        return replacedContent
    }
    
    fileprivate func generate(with prefix: String, for components: [GenerateComponent]) throws {
        print("Begin generate")
        defer {
            print("End generate")
        }
        var pathAndXcodeProject: [String: XCProject] = [:]
        try components.forEach { component in
            let componentType = component.componentType
            let typeFor = componentType
            
            let generateRootPath = yamlReader.generateRootPath(for: typeFor) + prefix + "/"
            let projectRootPath = yamlReader.projectRootPath(for: typeFor)
            let projectFileName = yamlReader.projectFileName(for: typeFor)
            
            let projectFilePath = projectRootPath + projectFileName + "/"
            let directoryPath = generateRootPath + component.generateDirectoryPath.joined(separator: "/") + "/"
            let filePath = directoryPath + prefix + component.templateFileName
            
            let project: XCProject
            if let alreadyExistsProject = pathAndXcodeProject[projectFilePath] {
                project = alreadyExistsProject
            } else {
                let xcodeprojectFileUrl = URL(fileURLWithPath: projectFilePath + "project.pbxproj")
                project = try XCProject(for: xcodeprojectFileUrl)
                pathAndXcodeProject[projectFilePath] = project
            }
            
            let fileOperator = FileOperator(fileManager: Files)
            let templatePath = component.templateDirectoryPath.joined(separator: "/") + "/" + component.templateFileName
            guard let templateContent = try? fileOperator.read(for: templatePath) else {
                print("can't find: \(componentType)")
                return
            }
            let writeCotent = convert(for: templateContent, to: prefix)
            try fileOperator.createDirectory(for: directoryPath)
            fileOperator.createFile(for: filePath)
            
            let targetName = yamlReader.targetName(for: typeFor)
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

