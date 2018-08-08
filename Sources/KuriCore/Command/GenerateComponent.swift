//
//  GenerateComponent.swift
//  Kuri
//
//  Created by Hirose.Yudai on 2017/04/10.
//  Copyright © 2017年 Hirose.Yudai. All rights reserved.
//

import Foundation

class GenerateComponent {
    // e.g from KuriTemplate/Repository/Repository.swift
    // templateRelativePath is Repository/Repository.swift
    let templateRelativePath: String
    var shouldRemoveComponentDirectoryName: Bool = false
    
    init(templateRelativePath: String) {
        self.templateRelativePath = templateRelativePath
    }
    
    var templateFileName: String {
        return URL(fileURLWithPath: templateRelativePath).lastPathComponent
    }
    
    var componentType: String {
        guard
            let componentType = Array(templateRelativePath.components(separatedBy: "/").dropLast()).last
            else {
            fatalError("Unexpected format file name \(templateFileName)")
        }
        return componentType
    }
    
    var componentTypeVariable: String {
        return "__\(componentType.uppercased())__"
    }
    
    var templateDirectoryPath: [String] {
        // remove file name
        let baseSlice = templateRelativePath.components(separatedBy: "/").dropLast()
        switch shouldRemoveComponentDirectoryName {
        case true:
            return Array(baseSlice.dropLast())
        case false:
            return Array(baseSlice)
        }
    }
    
    func makeGeneratingDirectoryPath(prefix: String, targetName: String) -> [String] {
        let replacedPath = templateDirectoryPath.map { $0.replaceEnvironmentText(prefix: prefix, targetName: targetName) }
        return replacedPath
    }
}
