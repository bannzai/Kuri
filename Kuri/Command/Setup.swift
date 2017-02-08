//
//  Setup.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/23.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation

struct Setup: CommandProtocol {
    let args: [String] 
    let fileOperator: FileOperator
    
    static let templateDirectoryName = "KuriTemplate"
    
    func execute() throws {
        try setupYaml()
        try setupTemplate()
        
        print("Successfully setup!")
    }
    
    fileprivate func setupTemplate() throws {
        let templatePath = "./\(Setup.templateDirectoryName)/"
        try ComponentType.elements.forEach { componentType in
            try GenerateType.elements.forEach { generateType in
                let directoryPath = templatePath + generateType.name + "/" + componentType.name + "/"
                try fileOperator.createDirectory(for: directoryPath)
                
                let filePath = directoryPath + componentType.fileName
                fileOperator.createFile(for: filePath)
                
                let content = try readSetupTemplate(for: (componentType, generateType))
                try fileOperator.write(to: filePath, this: content)
                
            }
            print("created template for \(componentType.name)")
        }
    }
    
    fileprivate func readSetupTemplate(for typeFor: (component: ComponentType ,generate: GenerateType)) throws -> String {
        switch typeFor.generate {
        case .Interface:
            return typeFor.component.template().interface()
        case .Implement:
            return typeFor.component.template().implement()
        }
    }
    
    fileprivate func setupYaml() throws {
        guard
            let xcodeProjectFileName = run(bash: "ls | grep xcodeproj")
                .components(separatedBy: "\n")
                .first else {
                    throw KuriErrorType.notExistsXcodeProjectFile("Please exec exists .xcodeproj directory.")
        }
        
        guard
            let projectName = xcodeProjectFileName.components(separatedBy: ".").first
            else {
                throw KuriErrorType.missingXcodeProjectFileName("Wrong format for .xcodeproj. Please check exists .xcodeproj file.")
        }
        
        fileOperator.createFile(for: "./Kuri.yml")
        
        let content = [
            "\(ComponentYamlProperty.TemplateRootPath.rawValue): ./",
            "\(ComponentYamlProperty.DefaltTemplateDirectoryName.rawValue): \(Setup.templateDirectoryName)",
            "\(ComponentYamlProperty.ProjectRootPath.rawValue): ./",
            "\(ComponentYamlProperty.ProjectFileName.rawValue): \(xcodeProjectFileName)",
            "\(ComponentYamlProperty.GenerateRootPath.rawValue): ./\(projectName)/",
            "\(ComponentYamlProperty.Target.rawValue): \(projectName)",
            "",
            "\(ComponentType.View.name):",
            " \(ComponentYamlProperty.CustomSuffix.rawValue): ViewController"
            ].joined(separator: "\n")
        
        try fileOperator.write(to: "./Kuri.yml", this: content)
        
        print("created Kuri.yml.")
    }
}
