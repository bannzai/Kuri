//
//  GenerateComponent.swift
//  Kuri
//
//  Created by Hirose.Yudai on 2017/04/10.
//  Copyright © 2017年 Hirose.Yudai. All rights reserved.
//

import Foundation

public struct GenerateComponent {
    // e.g from KuriTemplate/Repository/Repository.swift
    // templateRelativePath is Repository/Repository.swift
    public let templateRelativePath: String
    public let yamlReader: YamlReader
    
    public var componentType: String {
        guard
            let componentType = Array(templateRelativePath.components(separatedBy: "/").dropLast()).last
            else {
                fatalError("Unexpected format file name \(templateFileName)")
        }
        return componentType
    }
    
    public var generateRootPath: String {
        return yamlReader.generateRootPath(for: componentType)
    }
    
    public var projectRootPath: String {
        return yamlReader.projectRootPath(for: componentType)
    }
    
    public var projectFileName: String {
        return yamlReader.projectFileName(for: componentType)
    }
    
    public var templateFileName: String {
        return URL(fileURLWithPath: templateRelativePath).lastPathComponent
    }
    
    public var templateDirectoryPathComponents: [String] {
        // remove file name
        return Array(templateRelativePath.components(separatedBy: "/").dropLast())
    }
    
    public var generateDirectoryPathComponents: [String] {
        return templateDirectoryPathComponents
    }
    
    public var targetName: String {
        return yamlReader.targetName(for: componentType)
    }
}

// MARK: - Private

extension GenerateComponent {
    private var componentTypeVariable: String {
        return "__\(componentType.uppercased())__"
    }
    
}
