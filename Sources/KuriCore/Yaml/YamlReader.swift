//
//  YamlReader.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/23.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation
import Yaml

public struct YamlReader {
    public let yaml: Yaml
    public let env: [String: String]
    
    public init(
        yaml: Yaml,
        env: [String: String]
        ) {
        self.yaml = yaml
        self.env = env
    }
    
    private func readYaml(for key: String, from yaml: Yaml) -> Yaml {
        return yaml[.string(key)]
    }
    
    private func readString(for key: String, from yaml: Yaml) -> String? {
        return readYaml(for: key, from: yaml).string
    }
    
    private func readStringFromRoot(for key: ComponentYamlProperty) -> String? {
        guard let value = readString(for: key.rawValue, from: yaml) else {
            fatalError("Can't find for \(key.rawValue)")
        }
        return value
    }
    
    private func readYamlFromComponent(for key: ComponentYamlProperty, and componentType: String, from yaml: Yaml) -> String? {
        let yamlForCompoennt = yaml[.string(componentType)]
        return yamlForCompoennt[.string(key.rawValue)].string
    }
    
    private func readYamlForComponent(componentType: String, from yaml: Yaml) -> Yaml {
        if readYaml(for: componentType, from: yaml) == .null {
            fatalError("Can't find component \(componentType)")
        }
        return readYaml(for: componentType, from: yaml)
    }
    
    private func readYamlForComponent(generateComponent: GenerateComponent, from yaml: Yaml) -> Yaml {
        var yamlForComponent: Yaml = yaml
        generateComponent.generateDirectoryPath.forEach { directory in
            yamlForComponent = yamlForComponent[.string(directory)]
            if yamlForComponent == .null {
                fatalError("Can't find \(directory) from \(generateComponent.generateDirectoryPath)")
            }
        }
        return yamlForComponent
    }
    
    /* read from yaml for key. If nessecary componentType and genearteComponent
     - parameter key: key is already define. 
     - parameter componentType: e.g Entity, View, Presenter..., component type for generate.
     - parameter generateComponent: generateComponent used search `componentType` argument value.
     
     - returns: searched value for key
     */
    
    func read(for key: ComponentYamlProperty, and componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> String? {
        // only top level
        guard let componentType = componentType else {
            return readStringFromRoot(for: key)
        }
        
        // from top level search for key
        guard let generateComponent = generateComponent else{
            return readYamlFromComponent(for: key, and: componentType, from: yaml) ?? readStringFromRoot(for: key)
        }
        
        // recursive yaml component
        let yamlForContent = readYamlForComponent(generateComponent: generateComponent, from: yaml)
        return readYamlFromComponent(for: key, and: componentType, from: yamlForContent) ?? readYamlFromComponent(for: key, and: componentType, from: yaml) ?? readStringFromRoot(for: key)
    }
    
    func path(for key: ComponentYamlProperty, and componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> String {
        let name = key.rawValue
        guard let path = env[name]
            ?? read(for: key, and: componentType, with: generateComponent)
            else {
                fatalError("should write \(name) in Kuri.yml")
        }
        return path
    }
    
    public func templateRootPath(for componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> String {
        return path(for: ComponentYamlProperty.DefaultTemplateDirectoryPath, and: componentType, with: generateComponent)
    }
    
    func generateRootPath(for componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> String {
        return path(for: ComponentYamlProperty.GenerateRootPath, and: componentType, with: generateComponent)
    }
    
    func projectRootPath(for componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> String {
        return path(for: ComponentYamlProperty.ProjectRootPath, and: componentType, with: generateComponent)
    }
    
    func projectFileName(for componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> String {
        return path(for: ComponentYamlProperty.ProjectFileName, and: componentType, with: generateComponent)
    }
    
    func targetName(for componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> String {
        return path(for: ComponentYamlProperty.Target, and: componentType, with: generateComponent)
    }
}
