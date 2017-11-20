//
//  TemplateReader.swift
//  Kuri
//
//  Created by Yudai.Hirose on 2017/11/21.
//

import Foundation
import SwiftShell

public struct TemplateReader {
    public let context: CommandRunning
    public let templateRootPath: String
    public var generateComponent: [GenerateComponent] {
         return self.context.run(bash: "find \(templateRootPath) -name '*.swift'")
            .stdout
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }
            .map { templateDirectoryFullPath -> String in
                // remove from template directory
                // and template directory name.
                guard let bound = templateDirectoryFullPath.range(of: templateRootPath)?.upperBound else {
                    fatalError(
                        "Unexpected path when decide for read template directory path. info: headPath: \(templateRootPath), templateDirectoryFullPath: \(templateDirectoryFullPath)"
                    )
                }
                let subString = String(templateDirectoryFullPath[bound])
                return subString
                
            }
            .map( GenerateComponent.init )
    }
    
    public init(
        context: CommandRunning,
        templateRootPath: String
        ) {
        self.context = context
        self.templateRootPath = templateRootPath
    }
    
}
