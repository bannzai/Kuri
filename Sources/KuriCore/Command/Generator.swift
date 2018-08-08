//
//  Generator.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/22.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation
import SwiftShell
import XcodeProject
import Yaml

public struct Generator {
    public let argument: GenerateArgument
    public let yaml: Yaml
    
    public init(
        argument: GenerateArgument,
        yaml: Yaml
        ) {
        self.argument = argument
        self.yaml = yaml
    }
    
    fileprivate var generateComponents: [GenerateComponent] = []
    fileprivate var templateHeadPath: String = ""
    
    public mutating func execute() throws {
        let yamlReader = YamlReader<String>(yaml: yaml)
        templateHeadPath = yamlReader.value(for: .DefaultTemplateDirectoryPath)
        resetGenerateComponents(for: templateHeadPath)
        
        guard let entityName = argument.prefix else {
            throw KuriErrorType.missingArgument("Should input generate entity name")
        }
        
        let offsetAndOption = try argument.options.enumerated()
            .filter { $1.contains("-") }
            .map { (offset: $0, option: try OptionType(shortCut: $1)) }
            .sorted { $0.option.hashValue > $1.option.hashValue }

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
        generateComponents = main.run(bash: "find \(templateDirectoryName) -name '*.swift' -o -name '*.xib' -o -name '*.storyboard'")
            .stdout
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
                let subString = templateDirectoryFullPath[bound...]
                return String(subString)
            }
            .map( GenerateComponent.init )
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

    fileprivate mutating func setupForExec(with option: Generator.OptionType) throws {
        switch option {
        case .templateSpecify:
            templateHeadPath = try executeForTemplateSpecify()
            resetGenerateComponents(for: templateHeadPath)
        case .specify:
            generateComponents = try generateComponentsForSpecity()
        case .interactive:
            generateComponents = try generateComponentsForInteractive()
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
    fileprivate func generate(with prefix: String, for components: [GenerateComponent], and templateHeadPath: String) throws {
        print("Begin generate")
        defer {
            print("End generate")
        }
        var pathAndXcodeProject: [String: XcodeProject] = [:]
        try components.forEach { component in
            let componentType = component.componentType

            let stringYamlReader = YamlReader<String>(yaml: yaml)
            let booleanYamlReader = YamlReader<Bool>(yaml: yaml)
            
            let generateRootPath = stringYamlReader.value(for: .GenerateRootPath, componentType: componentType) + prefix + "/"
            let projectRootPath = stringYamlReader.value(for: .ProjectRootPath, componentType: componentType)
            let projectFileName = stringYamlReader.value(for: .ProjectFileName, componentType: componentType)
            
            let targetName = stringYamlReader.value(for: .Target, componentType: componentType)
            let projectFilePath = projectRootPath + projectFileName + "/"
            let baseGeneratingDirectoryPath = generateRootPath
            let shouldRemoveComponentDirectoryName = booleanYamlReader.value(for: .ShouldRemoveComponentDirectory, componentType: componentType)
            let generatingDirectoryPath: String
            switch shouldRemoveComponentDirectoryName {
            case true:
                generatingDirectoryPath = baseGeneratingDirectoryPath
            case false:
                generatingDirectoryPath = baseGeneratingDirectoryPath + component.makeGeneratingDirectoryPath(prefix: prefix, targetName: targetName).joined(separator: "/") + "/"
            }
            
            let filePath = (generatingDirectoryPath + component.templateFileName).replaceEnvironmentText(prefix: prefix, targetName: targetName)
            
            let project: XcodeProject
            if let alreadyExistsProject = pathAndXcodeProject[projectFilePath] {
                project = alreadyExistsProject
            } else {
                let xcodeprojectFileUrl = URL(fileURLWithPath: projectFilePath + "project.pbxproj")
                project = try XcodeProject(for: xcodeprojectFileUrl)
                pathAndXcodeProject[projectFilePath] = project
            }
            
            let fileOperator = FileOperator(fileManager: Files)
            let templatePath = templateHeadPath + component.templateDirectoryPath.joined(separator: "/") + "/" + component.templateFileName
            guard let templateContent = try? fileOperator.read(for: templatePath) else {
                print("can't find: \(componentType)")
                return
            }
            let writeCotent = templateContent.replaceEnvironmentText(prefix: prefix, targetName: targetName)
            try fileOperator.createDirectory(for: generatingDirectoryPath)
            fileOperator.createFile(for: filePath)
            
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

