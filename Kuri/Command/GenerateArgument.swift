//
//  GenerateArgument.swift
//  Kuri
//
//  Created by Hirose.Yudai on 2017/04/10.
//  Copyright © 2017年 Hirose.Yudai. All rights reserved.
//

import Foundation

struct GenerateArgument {
    let args: [String]
    let yamlReader: YamlReader
    
    var prefix: String? {
        return args.first
    }
    var options: [String] {
        return Array(args.dropFirst())
    }
    var hasOption: Bool {
        return !options.isEmpty
    }
    
    func optionArgument(for option: Generator.OptionType) throws -> [String] {
        let isMatchOption: ((String) -> Bool) = { string in
            return option.shortCut == string || option.rawValue == string
        }
        
        let optionAndArgument = options.reduce([String]()) { result, optionString in
            let isMatch = isMatchOption(optionString)
            if isMatch {
                return result + [optionString]
            }
            
            if optionString.contains("-"), !isMatch {
                return result
            }
            
            if result.count > 0 {
                return result + [optionString]
            }
            
            return result
        }
        
        guard optionAndArgument.count > 1 else {
            throw KuriErrorType.missingArgument("Not enough argument for kuri \(option.shortCut)")
        }
        
        // Drop -XXXX options
        return Array(optionAndArgument.dropFirst())
    }
}
