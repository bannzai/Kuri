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

    public init(
        yaml: Yaml
        ) {
        self.yaml = yaml
    }
    
    private func readYaml(for key: String) -> Yaml {
        return yaml[.string(key)]
    }
    
    private func readString(for key: String) -> String? {
        return readYaml(for: key).string
    }
    
    private func readStringFromRoot(for key: ComponentYamlProperty) -> String? {
        guard let value = readString(for: key.rawValue) else {
            fatalError("Can't find for \(key.rawValue)")
        }
        return value
    }
    
    private func readYamlFromComponent(for key: ComponentYamlProperty, and componentType: String) -> String? {
        let yamlForCompoennt = yaml[.string(componentType)]
        return yamlForCompoennt[.string(key.rawValue)].string
    }
    
    private func readYamlForComponent(componentType: String) -> Yaml {
        if readYaml(for: componentType) == .null {
            fatalError("Can't find component \(componentType)")
        }
        return readYaml(for: componentType)
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
        
        // recursive yaml component
        return readYamlFromComponent(for: key, and: componentType) ?? readStringFromRoot(for: key)
    }
    
    func path(for key: ComponentYamlProperty, and componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> String {
        let name = key.rawValue
        guard let path = read(for: key, and: componentType, with: generateComponent)
            else {
                fatalError("should write \(name) in Kuri.yml")
        }
        return path
    }
    
    public func templateRootPath(for componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> String {
        return path(for: ComponentYamlProperty.DefaultTemplateDirectoryPath, and: componentType, with: generateComponent)
    }
    
    public func generateRootPath(for componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> String {
        return path(for: ComponentYamlProperty.GenerateRootPath, and: componentType, with: generateComponent)
    }
    
    public func projectRootPath(for componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> String {
        return path(for: ComponentYamlProperty.ProjectRootPath, and: componentType, with: generateComponent)
    }
    
    public func projectFileName(for componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> String {
        return path(for: ComponentYamlProperty.ProjectFileName, and: componentType, with: generateComponent)
    }
    
    public func targetName(for componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> String {
        return path(for: ComponentYamlProperty.Target, and: componentType, with: generateComponent)
    }
}
