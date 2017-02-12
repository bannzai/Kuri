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
                  from typeFor: (component: ComponentType, generate: GenerateType)) -> String? {
        let yamlForComponentType = yaml[.string(typeFor.component.name)]
        let yamlForGenerateType = yamlForComponentType[.string(typeFor.generate.name)]
        let yamlForBasic = yaml
        
        return yamlForGenerateType[.string(key)].string
            ?? yamlForComponentType[.string(key)].string
            ?? yamlForBasic[.string(key)].string
    }
    
    func customSuffix(for componentType: ComponentType) -> String? {
        return yaml[.string(componentType.name)][.string(ComponentYamlProperty.CustomSuffix.rawValue)].string
    }
    
    func path(for nameProperty: ComponentYamlProperty,
              from typeFor: (component: ComponentType, generate: GenerateType)) -> String {
        let name = nameProperty.rawValue
        guard let path = env[name]
            ?? readYaml(for: name, from: typeFor)
            else {
                fatalError("should write \(name) in Kuri.yml")
        }
        return path
    }
    
    func templateRootPath(from typeFor: (component: ComponentType, generate: GenerateType)) -> String {
        return path(for: ComponentYamlProperty.TemplateRootPath, from: typeFor)
    }
    
    func kuriTemplatePath(from typeFor: (component: ComponentType, generate: GenerateType)) -> String {
        return path(for: ComponentYamlProperty.DefaltTemplateDirectoryName, from: typeFor)
    }
    
    func generateRootPath(from typeFor: (component: ComponentType, generate: GenerateType)) -> String {
        return path(for: ComponentYamlProperty.GenerateRootPath, from: typeFor)
    }
    
    func projectRootPath(from typeFor: (component: ComponentType, generate: GenerateType)) -> String {
        return path(for: ComponentYamlProperty.ProjectRootPath, from: typeFor)
    }
    
    func projectFileName(from typeFor: (component: ComponentType, generate: GenerateType)) -> String {
        return path(for: ComponentYamlProperty.ProjectFileName, from: typeFor)
    }
    
    func targetName(from typeFor: (component: ComponentType, generate: GenerateType)) -> String {
        return path(for: ComponentYamlProperty.Target, from: typeFor)
    }
}
