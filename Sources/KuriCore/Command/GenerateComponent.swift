//
//  GenerateComponent.swift
//  Kuri
//
//  Created by Hirose.Yudai on 2017/04/10.
//  Copyright © 2017年 Hirose.Yudai. All rights reserved.
//

import Foundation

struct GenerateComponent {
    // e.g from KuriTemplate/Repository/Repository.swift
    // templateRelativePath is Repository/Repository.swift
    let templateRelativePath: String
    
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
        return Array(templateRelativePath.components(separatedBy: "/").dropLast())
    }
    
    func makeDirectoryPath(prefix: String, targetName: String) -> [String] {
        let replacedPath = templateDirectoryPath.map { $0.replaceEnvironmentText(prefix: prefix, targetName: targetName) }
        return replacedPath
    }
}
