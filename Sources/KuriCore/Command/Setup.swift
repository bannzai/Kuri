//

//  Setup.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/23.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation
import SwiftShell

public struct Setup {
    public let args: [String]
    public let fileOperator: FileOperator
    
    public init(
        args: [String],
        fileOperator: FileOperator
        ) {
        self.args = args
        self.fileOperator = fileOperator
    }
    
    static let templateDirectoryName = "KuriTemplate"
    
    public func execute() throws {
        try setupYaml()
        try setupTemplate()
        
        print("Successfully setup!")
    }
    
    fileprivate func setupTemplate() throws {
        let templatePath = "./\(Setup.templateDirectoryName)/"
        try SetupComponentType.elements.forEach { componentType in
            let directoryPath = templatePath + componentType.name + "/"
            try fileOperator.createDirectory(for: directoryPath)
            
            let filePath = directoryPath + componentType.fileName
            fileOperator.createFile(for: filePath)
            
            let content = try readSetupTemplate(for: (componentType))
            try fileOperator.write(to: filePath, this: content)
            
            print("created template for \(componentType.name)")
        }
    }
    
    fileprivate func readSetupTemplate(for typeFor: SetupComponentType) throws -> String {
        let template = typeFor.template()
        return template.comment() + "\n" + template.interface() + "\n\n\n" + template.implement()
    }
    
    fileprivate func setupYaml() throws {
        guard
            let xcodeProjectFileName = run(bash: "ls | grep xcodeproj")
                .stdout
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
            "\(ComponentYamlProperty.DefaultTemplateDirectoryPath.rawValue): ./\(Setup.templateDirectoryName)/",
            "\(ComponentYamlProperty.ProjectRootPath.rawValue): ./",
            "\(ComponentYamlProperty.ProjectFileName.rawValue): \(xcodeProjectFileName)",
            "\(ComponentYamlProperty.GenerateRootPath.rawValue): ./\(projectName)/",
            "\(ComponentYamlProperty.Target.rawValue): \(projectName)",
            "\(ComponentYamlProperty.ShouldRemoveComponentDirectory.rawValue): \(false)",
            "",
            ].joined(separator: "\n")
        
        try fileOperator.write(to: "./Kuri.yml", this: content)
        
        print("created Kuri.yml.")
    }
}
