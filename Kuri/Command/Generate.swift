//
//  Generate.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/22.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation

struct Generate: CommandProtocol {
    let options: [String]
    let yamlReader: YamlReader
    
    func execute() throws {
        guard let entityName = options.first else {
            throw KuriErrorType.missingArgument("Should input generate entity name")
        }
        
        guard let optionString = options.second else {
            try generate(with: entityName)
            return
        }
        
        guard let option = Generate.OptionType(shortCut: optionString) else {
            throw KuriErrorType.missingArgument("Unknown opition for \(optionString)")
        }
        
        try executeAnyOption(with: option, name: entityName)
    }
}

extension Generate {
    enum OptionType: String, ArgumentOptionProtocol {
        case specity
        case interactive
        
        init?(shortCut: String) {
            switch shortCut {
            case "-s":
                self = .specity
            case "-i":
                self = .interactive
            default:
                return nil
            }
        }
    }
}

fileprivate extension Generate {
    fileprivate func executeAnyOption(with option: Generate.OptionType, name: String) throws {
        switch option {
        case .specity:
            try executeForSpecity(with: name)
        case .interactive:
            try executeForInteractive(with: name)
        }
    }
    
    fileprivate func executeForInteractive(with name: String) throws {
        let answeredComponents = try ComponentType.elements.filter {
            let message = "Do you want to \($0.name) [y/N]"
            let answer = try CommandInput.waitStandardInputWhileInvalid(
                with: message,
                validation: { (input) -> Bool in
                    return input == "y" || input == "Y" || input == "n" || input == "N"
            })
            return answer == "y" || answer == "Y"
        }
        try generate(with: name, for: answeredComponents)
    }
    
    fileprivate func executeForSpecity(with name: String) throws {
        if options.count < 3 {
            // generate specity XXXX
            throw KuriErrorType.missingArgument("Should ")
        }
        let componentOptions = options[2..<options.count]
        let components = componentOptions.flatMap { ComponentType(name: $0.capitalized) }
        try generate(with: name, for: components)
    }
    
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
        
        let replacedContent = ComponentType.elements
            .reduce(content) { content, componentType in
                let suffix = yamlReader.customSuffix(for: componentType) ?? componentType.name
                return content
                    .replacingOccurrences(of: componentType.templateName, with: structure + suffix)
                    .replacingOccurrences(of: "__USERNAME__", with: userName)
                    .replacingOccurrences(of: "__DATE__", with: date)
        }
        return replacedContent
    }
    
    
    fileprivate func generate(with name: String, for components: [ComponentType] = ComponentType.elements) throws {
        var pathAndXcodeProject: [String: XCProject] = [:]
        try components.flatMap { type in
            return GenerateType.elements.map { (type, $0) }
            }
            .forEach { componentType, generateType in
                let typeFor = (componentType, generateType)
                
                let kuriTemplatePath = yamlReader.kuriTemplatePath(from: typeFor)
                let templatePath = kuriTemplatePath + generateType.name + "/" + componentType.name + "/" + componentType.fileName
                let generateRootPath = yamlReader.generateRootPath(from: typeFor)
                let projectRootPath = yamlReader.projectRootPath(from: typeFor)
                let projectFileName = yamlReader.projectFileName(from: typeFor)
                
                let projectFilePath = projectRootPath + projectFileName + "/"
                let directoryPath = generateRootPath + name + "/" + componentType.name + "/"
                let suffix = yamlReader.customSuffix(for: componentType) ?? componentType.name
                let filePath = directoryPath + name + suffix + generateType.fileSuffix + ".swift"
                
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
                    print("can't find: \(generateType.name)/\(componentType.name)")
                    return
                }
                let writeCotent = convert(for: templateContent, to: name)
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

