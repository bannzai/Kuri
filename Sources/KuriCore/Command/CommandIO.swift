//
//  Input.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/22.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation

struct CommandInput {
    fileprivate static func waitStandardInput() throws -> String {
        guard
            let characters = main.stdin.readSome()?.characters.dropLast()
            else{
                throw KuriErrorType.readInputError("Should type any character")
        }
        return String(characters)
    }
    
    static func waitStandardInputWhileInvalid(with message: String, validation: ((String) -> Bool)) throws -> String {
        var input: String = ""
        repeat {
            print(message)
            input = (try? waitStandardInput()) ?? ""
        } while(!validation(input))
        return input
    }
}
