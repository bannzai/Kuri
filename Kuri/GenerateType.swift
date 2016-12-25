//
//  generateType.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/03.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation
enum GenerateType: Int, Enumerable {
    case Interface
    case Implement
    
    var name: String {
        return "\(self)"
    }
    
    var fileSuffix: String {
        switch self {
        case .Interface:
            return ""
        case .Implement:
            return "Impl"
        }
    }
    
}

