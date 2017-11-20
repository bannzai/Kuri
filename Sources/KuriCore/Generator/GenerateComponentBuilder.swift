//
//  GenerateComponentBuilder.swift
//  KuriCore
//
//  Created by Yudai.Hirose on 2017/11/21.
//

import Foundation

public struct GenerateComponentBuilder {
    public var components: [String] = []
    
    public init() { }
    
    public func append(component: String) {
        self.components += component
    }
    
    public func build() -> [GenerateComponent] {
        return GenerateComponent(templateRelativePath: <#T##String#>)
    }
}
