//
//  GenerateComponent.swift
//  Kuri
//
//  Created by Hirose.Yudai on 2017/04/10.
//  Copyright © 2017年 Hirose.Yudai. All rights reserved.
//

import Foundation

struct GenerateComponent {
    let templateFilePath: String
    
    var templateFileName: String {
        return URL(fileURLWithPath: templateFilePath).lastPathComponent
    }
    
    var componentType: String {
        guard let componentType = templateFileName.components(separatedBy: ".").first else {
            fatalError("Unexpected format file name \(templateFileName)")
        }
        return componentType
    }
    
    var componentTypeVariable: String {
        return "__\(componentType.uppercased())__"
    }
    
    var templateDirectoryPath: [String] {
        return Array(templateFilePath.components(separatedBy: "/").dropLast())
    }
    
    var generateDirectoryPath: [String] {
        // remove current directory ./
        // and template directory name.
        return Array(templateDirectoryPath.dropFirst().dropFirst())
    }
}
