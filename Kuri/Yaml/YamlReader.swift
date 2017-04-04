//
//  YamlReader.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/23.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation

struct YamlReader {
    struct Generate {
        let yaml: Yaml
        let env: [String: String]
        
        private func readYaml(for key: String, from yaml: Yaml) -> Yaml {
            return yaml[.string(key)]
        }
        
        private func readString(for key: String, from yaml: Yaml) -> String? {
            return readYaml(for: key, from: yaml).string
        }
        
        private func readStringFromRoot(for key: ComponentYamlProperty) -> String {
            guard let value = readString(for: key.rawValue, from: yaml) else {
                fatalError("Can't find for \(key.rawValue)")
            }
            return value
        }
        
        private func readYamlFromComponent(for key: ComponentYamlProperty, and componentType: String, from yaml: Yaml) -> String {
            let yamlForCompoennt = yaml[.string(componentType)]
            if yamlForCompoennt == .null {
                fatalError("Can't find from \(componentType) for \(key.rawValue)")
            }
            guard let value = yamlForCompoennt[.string(key.rawValue)].string else {
                fatalError("Can't find from \(componentType) for \(key.rawValue)")
            }
            return value
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
        
        func read(for key: ComponentYamlProperty, and componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> String {
            // only top level
            guard let componentType = componentType else {
                return readStringFromRoot(for: key)
            }
            
            // from top level search for key
            guard let generateComponent = generateComponent else{
                return readYamlFromComponent(for: key, and: componentType, from: yaml)
            }
            
            // recursive yaml component
            let yamlForContent = readYamlForComponent(generateComponent: generateComponent, from: yaml)
            return readYamlFromComponent(for: key, and: componentType, from: yamlForContent)
        }
        
        func templateRootPath(for componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> String {
            return read(for: ComponentYamlProperty.TemplateRootPath, and: componentType, with: generateComponent)
        }
        
        func kuriTemplateName(for componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> String {
            return read(for: ComponentYamlProperty.DefaultTemplateDirectoryName, and: componentType, with: generateComponent)
        }
        
        func generateRootPath(for componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> String {
            return read(for: ComponentYamlProperty.GenerateRootPath, and: componentType, with: generateComponent)
        }
        
        func projectRootPath(for componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> String {
            return read(for: ComponentYamlProperty.ProjectRootPath, and: componentType, with: generateComponent)
        }
        
        func projectFileName(for componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> String {
            return read(for: ComponentYamlProperty.ProjectFileName, and: componentType, with: generateComponent)
        }
        
        func targetName(for componentType: String? = nil, with generateComponent: GenerateComponent? = nil) -> String {
            return read(for: ComponentYamlProperty.Target, and: componentType, with: generateComponent)
        }
    }
}
