//
//  ComponentType.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/23.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation

enum ComponentType: Int, Enumerable {
    case Entity
    case DataStore
    case Repository
    case UseCase
    case Translator
    case Model
    case Presenter
    case View
    case Wireframe
    case Builder
    
    init?(name: String) {
        guard let element = ComponentType
            .elements
            .filter ({ $0.name == name })
            .first
            else {
                return nil
        }
        
        self = element
    }
    
    var name: String {
        return "\(self)"
    }
    
    var fileName: String {
        return name + ".swift"
    }
    
    var templateName: String {
        return "__" + name.uppercased() + "__"
    }
    
    func template() -> Templatable {
        switch self {
        case .Entity:
            return EntityTemplate()
        case .DataStore:
            return DataStoreTemplate()
        case .Repository:
            return RepositoryTemplate()
        case .UseCase:
            return UseCaseTemplate()
        case .Translator:
            return TranslatorTemplate()
        case .Model:
            return ModelTemplate()
        case .Presenter:
            return PresenterTemplate()
        case .View:
            return ViewTemplate()
        case .Wireframe:
            return WireframeTemplate()
        case .Builder:
            return BuilderTemplate()
        }
    }
    
}
