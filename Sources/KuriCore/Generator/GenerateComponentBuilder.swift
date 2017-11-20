//
//  GenerateComponentBuilder.swift
//  KuriCore
//
//  Created by Yudai.Hirose on 2017/11/21.
//

import Foundation
import SwiftShell
import Yaml

public class GenerateComponentBuilder {
    public let context: CommandRunning
    public let templateRootPath: String
    public let rootYaml: Yaml
    
    public init(
        context: CommandRunning,
        templateRootPath: String,
        rootYaml: Yaml
        ) {
        self.context = context
        self.templateRootPath = templateRootPath
        self.rootYaml = rootYaml
    }
    
    public func build() -> [GenerateComponent] {
        let generateComponent: [GenerateComponent] =  {
            let templateDirectoryFullPaths =  self.context.run(bash: "find \(templateRootPath) -name '*.swift'")
                .stdout
                .components(separatedBy: "\n")
                .filter { !$0.isEmpty }

            let relativePaths = templateDirectoryFullPaths
                .map { templateDirectoryFullPath -> String in
                    // remove from template directory
                    // and template directory name.
                    guard let bound = templateDirectoryFullPath.range(of: templateRootPath)?.upperBound else {
                        fatalError(
                            "Unexpected path when decide for read template directory path. info: headPath: \(templateRootPath), templateDirectoryFullPath: \(templateDirectoryFullPath)"
                        )
                    }
                    let templateRelativePath = String(templateDirectoryFullPath[bound])
                    return templateRelativePath
                }
                
            let yamls: [Yaml] = templateDirectoryFullPaths
                .map { templateDirectoryFullPath -> Yaml in
                    var currentYaml: Yaml = rootYaml
                    var currentPath: String = ""
                    
                    templateDirectoryFullPath
                        .components(separatedBy: "/")
                        .forEach { path in
                            currentPath += path
                            if let yaml = try? YamlResource.loadYamlIfPossible(for: currentPath) {
                                currentYaml = yaml
                            }
                    }
                    
                    return currentYaml
                }
            
            let yamlReaders = yamls.map { YamlReader(yaml: $0) }
            return zip(relativePaths, yamlReaders).map {
                return GenerateComponent(templateRelativePath: $0, yamlReader: $1)
            }
        }()
        
        return generateComponent
    }
}
