//
//  YamlReader.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/23.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation

struct YamlReader {
    let yaml: Yaml
    let env: [String: String]
    
    func readYaml(for key: String,
                  from typeFor: String?) -> String? {
        switch typeFor {
        case .none:
            let yamlForBasic = yaml
            return yamlForBasic[.string(key)].string
        case .some(let typeFor):
            let yamlForSetupComponentType = yaml[.string(typeFor)]
            return yamlForSetupComponentType[.string(key)].string
        }
    }
    
    func customSuffix(for componentType: String) -> String? {
        return yaml[.string(componentType)][.string(ComponentYamlProperty.CustomSuffix.rawValue)].string
    }
    
    func path(for nameProperty: ComponentYamlProperty, from typeFor: String?) -> String {
        let name = nameProperty.rawValue
        guard let path = env[name]
            ?? readYaml(for: name, from: typeFor)
            else {
                fatalError("should write \(name) in Kuri.yml")
        }
        return path
    }
    
    func templateRootPath(from typeFor: String) -> String {
        return path(for: ComponentYamlProperty.TemplateRootPath, from: typeFor)
    }
    
    func kuriTemplateName(from typeFor: String? = nil) -> String {
        return path(for: ComponentYamlProperty.DefaultTemplateDirectoryName, from: typeFor)
    }
    
    func generateRootPath(from typeFor: String) -> String {
        return path(for: ComponentYamlProperty.GenerateRootPath, from: typeFor)
    }
    
    func projectRootPath(from typeFor: String) -> String {
        return path(for: ComponentYamlProperty.ProjectRootPath, from: typeFor)
    }
    
    func projectFileName(from typeFor: String) -> String {
        return path(for: ComponentYamlProperty.ProjectFileName, from: typeFor)
    }
    
    func targetName(from typeFor: String) -> String {
        return path(for: ComponentYamlProperty.Target, from: typeFor)
    }
}
