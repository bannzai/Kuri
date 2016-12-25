//
//  YamlResource.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/19.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation

enum ComponentYamlProperty: String {
    case Target
    case CustomSuffix
    case TemplateRootPath
    case ProjectRootPath
    case ProjectFileName
    case GenerateRootPath
}

struct YamlResource {
    fileprivate static func findYamlFile() -> URL? {
        let path = run(bash: "ls | grep Kuri.yml")
        return URL(fileURLWithPath: path)
    }
    
    fileprivate static func readYamlContent(for fileUrl: URL) throws -> String {
        return try String(contentsOf: fileUrl)
    }
    
    static func loadYamlIfPossible() throws -> Yaml {
        let yaml: Yaml
        if let yamlFile = findYamlFile() {
            do {
                let yamlContent = try readYamlContent(for: yamlFile)
                yaml = try Yaml.load(yamlContent)
            } catch {
                throw KuriErrorType.readYamlError("Can't load yaml file.")
            }
        } else {
            throw KuriErrorType.cannotFindYamlFile("Can't find Kuri.yml, please prepare this file.")
        }
        return yaml
    }
}
