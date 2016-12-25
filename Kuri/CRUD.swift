//
//  CRUD.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/04.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

//import Foundation

// TODO: CRUDInterface

//
//enum CRUD: Int, Enumerable {
//    case Create
//    case Read
//    case Update
//    case Delete
//    
//    init(from string: String) {
//        switch string {
//        case "C":
//            self = .Create
//        case "R":
//            self = .Read
//        case "U":
//            self = .Update
//        case "D":
//            self = .Delete
//        default:
//            fatalError()
//        }
//    }
//    var name: String {
//        return "\(self)"
//    }
//    var templateName: String {
//        return  "__" + name.uppercased() + "FUNCTION" + "__"
//    }
//}
//
//func replaceForCRUDIfNeeded(for content: String) -> String {
//    let option = "C"
//    let crud: CRUD
//    switch option {
//    case "C":
//        crud = .Create
//    case "R":
//        crud = .Read
//    case "U":
//        crud = .Update
//    case "D":
//        crud = .Delete
//    default:
//        return content
//    }
//    return content.replacingOccurrences(of: content, with: crud.templateName)
//}

//func hasCRUDTemplate(with generateType: ComponentType) -> Bool {
//    CRUD.elements.filter {
//        let fileName = generateType.name + $0.name + ".swift"
//    }
//}
