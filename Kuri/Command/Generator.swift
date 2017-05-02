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
    
    fileprivate var generateComponents: [GenerateComponent] = []
    fileprivate var templateHeadPath: String = ""
    fileprivate var specityComponents: [String] = []
    
    init(
        argument: GenerateArgument,
        yamlReader: YamlReader
        ) {
        self.argument = argument
        self.yamlReader = yamlReader
    }
    
    mutating func execute() throws {
        templateHeadPath = yamlReader.templateRootPath()
        resetGenerateComponents(for: templateHeadPath)
        
        guard let entityName = argument.prefix else {
            throw KuriErrorType.missingArgument("Should input generate entity name")
        }
        
        let offsetAndOption = try argument.options.enumerated()
            .filter { $1.contains("-") }
            .map { (offset: $0, option: try OptionType(shortCut: $1)) }
            .sorted { $0.0.option.hashValue > $0.1.option.hashValue }
        
        try offsetAndOption.forEach { offset, option in
            try setupForExec(with: option)
        }
        
        guard argument.hasOption else {
            try generate(with: entityName, for: generateComponents, and: templateHeadPath)
            return
        }
        
        try generate(with: entityName, for: generateComponents, and: templateHeadPath)
    }
    
    mutating func resetGenerateComponents(for templateDirectoryName: String) {
        generateComponents = main.run(bash: "find \(templateDirectoryName) -name '*.swift'")
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }
            .map { templateDirectoryFullPath -> String in
                // remove from template directory
                // and template directory name.
                guard let bound = templateDirectoryFullPath.range(of: templateDirectoryName)?.upperBound else {
                    fatalError(
                        "Unexpected path when decide for read template directory path. info: headPath: \(templateDirectoryName), templateDirectoryFullPath: \(templateDirectoryFullPath)"
                    )
                }
                let subString = templateDirectoryFullPath.substring(from: bound)
                return subString
 
            }
            .map( GenerateComponent.init )
    }
    
}

extension Generator {
    enum OptionType: String {
        case template
        case interactive
        case specify
        
        init(shortCut: String) throws {
            switch shortCut {
            case OptionType.template.shortCut:
                self = .template
            case OptionType.interactive.shortCut:
                self = .interactive
            case OptionType.specify.shortCut:
                self = .specify
            default:
                throw KuriErrorType.missingArgument(assertionMessage(description: "Unknown option for \(shortCut)"))
            }
        }
        
        var shortCut: String {
            switch self {
            case .template:
                return "-t"
            case .specify:
                return "-s"
            case .interactive:
                return "-i"
            }
        }
    }

    fileprivate mutating func setupForExec(with option: Generator.OptionType) throws {
        switch option {
        case .template:
            templateHeadPath = try executeForTemplateSpecify()
            resetGenerateComponents(for: templateHeadPath)
        case .interactive:
            generateComponents = try generateComponentsForInteractive()
        case .specify:
            specityComponents = try extractSpecityComponents()
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
    
    fileprivate func extractSpecityComponents() throws -> [String] {
        let optionArguments = try argument.optionArgument(for: OptionType.specify)
        if optionArguments.isEmpty {
            throw KuriErrorType.missingArgument("Should write for componentType. e.g kuri -s View")
        }
        return optionArguments
    }
    
    fileprivate func executeForTemplateSpecify() throws -> String {
        let templateSpecity = OptionType.template
        
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
    
    fileprivate func replaced(for content: String, to prefix: String) -> String {
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
    
    fileprivate func plucked(for content: String) throws -> String {
        guard let _ = content.range(of: "<%") else {
            return content
        }
        
        try specityComponents
            .reduce(content, { (replacedContent, specityComponent) -> String in
                let regex = try NSRegularExpression(pattern: "<%\\s+\(specityComponent.uppercased()).+%>", options: [.anchorsMatchLines, .allowCommentsAndWhitespace])
                guard let match = regex.matches(in: specityComponent, options: [], range: NSMakeRange(0, specityComponent.characters.count)).first else {
                    return replacedContent
                }
                var _content = content
                return _content.removeSubrange(content.range(of: "<%\\s+.+\n"))
            }) 
        
        return content
    }
    
    fileprivate func generate(with prefix: String, for components: [GenerateComponent], and templateHeadPath: String) throws {
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
            let templatePath = templateHeadPath + component.templateDirectoryPath.joined(separator: "/") + "/" + component.templateFileName
            guard let templateContent = try? fileOperator.read(for: templatePath) else {
                print("can't find: \(componentType)")
                return
            }
            let replacedContent = replaced(for: templateContent, to: prefix)
            let writeCotent = try plucked(for: replacedContent)
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

