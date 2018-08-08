//
//  YamlReader.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/23.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation
import Yaml

public struct YamlReader<T: YamlReadableType> {
    public let yaml: Yaml

    public init(
        yaml: Yaml
        ) {
        self.yaml = yaml
    }
    
    private func readYaml(for key: String, from yaml: Yaml) -> Yaml {
        return yaml[.string(key)]
    }
    
    private func read(for key: String, from yaml: Yaml) -> T? {
        return T.read(for: key, from: yaml)
    }
    
    private func readFromRoot(for key: ComponentYamlProperty) -> T? {
        let readValue = read(for: key.rawValue, from: yaml)
        switch readValue {
        case .none:
            fatalError("Can't find for \(key.rawValue)")
        case let value?:
            return value
        }
    }
    
    private func readYamlFromComponent(for key: ComponentYamlProperty, and componentType: String, from yaml: Yaml) -> T? {
        let yamlForCompoennt = yaml[.string(componentType)]
        return T.read(for: key.rawValue, from: yamlForCompoennt)
    }
    
    private func readYamlForComponent(componentType: String, from yaml: Yaml) -> Yaml {
        if readYaml(for: componentType, from: yaml) == .null {
            fatalError("Can't find component \(componentType)")
        }
        return readYaml(for: componentType, from: yaml)
    }
    
    private func readYamlForComponent(generateComponent: GenerateComponent, from yaml: Yaml) -> Yaml {
        var yamlForComponent: Yaml = yaml
        generateComponent.templateDirectoryPath.forEach { directory in
            yamlForComponent = yamlForComponent[.string(directory)]
            if yamlForComponent == .null {
                fatalError("Can't find \(directory) from \(generateComponent.templateDirectoryPath)")
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
    
    func read(for key: ComponentYamlProperty, and componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> T? {
        // only top level
        guard let componentType = componentType else {
            return readFromRoot(for: key)
        }
        
        // from top level search for key
        guard let generateComponent = generateComponent else{
            return readYamlFromComponent(for: key, and: componentType, from: yaml) ?? readFromRoot(for: key)
        }
        
        // recursive yaml component
        let yamlForContent = readYamlForComponent(generateComponent: generateComponent, from: yaml)
        return readYamlFromComponent(for: key, and: componentType, from: yamlForContent) ?? readYamlFromComponent(for: key, and: componentType, from: yaml) ?? readFromRoot(for: key)
    }
    
    func value(for key: ComponentYamlProperty, componentType: String? = nil, generateComponent: GenerateComponent? = nil) -> T {
        let name = key.rawValue
        let value = read(for: key, and: componentType, with: generateComponent)
        
        switch value {
        case .none:
            fatalError("should write \(name) in Kuri.yml")
        case let value?:
            return value
        }
    }
    
}
