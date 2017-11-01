//
//  error.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/03.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation

enum KuriErrorType: Error {
    case urlError(String)
    case readInputError(String)
    case readYamlError(String)
    case commandParseError(String)
    case missingArgument(String)
    case standardInputValidationError(String)
    case cannotFindYamlFile(String)
    case notExistsXcodeProjectFile(String)
    case missingXcodeProjectFileName(String)
    
    func errorDescription() -> String {
        switch self {
        case .urlError(let message): return message
        case .readInputError(let message): return message
        case .readYamlError(let message): return message
        case .commandParseError(let message): return message
        case .missingArgument(let message): return message
        case .standardInputValidationError(let message): return message
        case .cannotFindYamlFile(let message): return message
        case .notExistsXcodeProjectFile(let message): return message
        case .missingXcodeProjectFileName(let message): return message
        }
    }
}
