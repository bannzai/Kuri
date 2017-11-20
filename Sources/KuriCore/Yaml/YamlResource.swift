//
//  YamlResource.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/19.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation
import SwiftShell
import Yaml

public enum ComponentYamlProperty: String {
    case Target
    case DefaultTemplateDirectoryPath
    case ProjectRootPath
    case ProjectFileName
    case GenerateRootPath
}

public struct YamlResource {
    fileprivate static func findYamlFile(for path: String) -> URL? {
        let path = run(bash: "ls \(path) | grep Kuri.yml").stdout
        return URL(fileURLWithPath: path)
    }
    
    fileprivate static func readYamlContent(for fileUrl: URL) throws -> String {
        return try String(contentsOf: fileUrl)
    }
    
    public static func loadYamlIfPossible(for path: String) throws -> Yaml {
        let yaml: Yaml
        if let yamlFile = findYamlFile(for: path) {
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
