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

public struct Generator {
    public let name: String
    public let templateRootPath: String
    public let generateComponents: [GenerateComponent]

    public init(
        name: String,
        templateRootPath: String,
        generateComponents: [GenerateComponent]
        ) {
        self.name = name
        self.templateRootPath = templateRootPath
        self.generateComponents = generateComponents
    }
    
    public func execute() throws {
        try generate(with: name, for: generateComponents, and: templateRootPath)
    }
}

extension Generator {
    public enum OptionType: String {
        case templatePath
        case specify
        case interactive
    }

    fileprivate mutating func setupForExec(with option: Generator.OptionType) throws {
        switch option {
        case .templatePath:
            
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
        let userName = run(bash: "echo $USER").stdout
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
        }(())
        
        let replacedContent = content
            .replacingOccurrences(of: "__PREFIX__", with: prefix)
            .replacingOccurrences(of: "__USERNAME__", with: userName)
            .replacingOccurrences(of: "__DATE__", with: date.date)
            .replacingOccurrences(of: "__YEAR__", with: "\(date.year)")
            .replacingOccurrences(of: "__MONTH__", with: "\(date.month)")
            .replacingOccurrences(of: "__DAY__", with: "\(date.day)")
        return replacedContent
    }
    
    fileprivate func generate(
        with prefix: String,
        for components: [GenerateComponent],
        and templateRootPath: String
        ) throws {
        print("Begin generate")
        defer {
            print("End generate")
        }
        var pathAndXcodeProject: [String: XcodeProject] = [:]
        try components.forEach { component in
            let componentType = component.componentType
            let typeFor = componen
            tType
            
            let generateRootPath = yamlReader.generateRootPath(for: typeFor) + prefix + "/"
            let projectRootPath = yamlReader.projectRootPath(for: typeFor)
            let projectFileName = yamlReader.projectFileName(for: typeFor)
            
            let projectFilePath = projectRootPath + projectFileName + "/"
            let directoryPath = generateRootPath + component.generateDirectoryPath.joined(separator: "/") + "/"
            let filePath = directoryPath + prefix + component.templateFileName
            
            let project: XcodeProject
            if let alreadyExistsProject = pathAndXcodeProject[projectFilePath] {
                project = alreadyExistsProject
            } else {
                let xcodeprojectFileUrl = URL(fileURLWithPath: projectFilePath + "project.pbxproj")
                project = try XcodeProject(for: xcodeprojectFileUrl)
                pathAndXcodeProject[projectFilePath] = project
            }
            
            let fileOperator = FileOperator(fileManager: Files)
            let templatePath = templateRootPath + component.templateDirectoryPath.joined(separator: "/") + "/" + component.templateFileName
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

