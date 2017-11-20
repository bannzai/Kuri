//
//  main.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/02.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//
 
import Foundation
import KuriCore
import SwiftShell
import Stencil
import Commander

let env = ProcessInfo().environment
let args = Array(ProcessInfo().arguments.dropFirst())

if let debugPath = env["WorkingDirectory"] {
    main.currentdirectory = debugPath
}


do {
    let group = Commander.Group {
        $0.command("generate", { (commandName: String, options: ArgumentParser) in
            func hasOption(_ type: Generator.OptionType) -> Bool {
                return options.hasOption(type.rawValue)
            }
            
            func value(_ type: Generator.OptionType) throws -> String {
                guard let value = try? options.shiftValue(for: type.rawValue) else {
                    throw KuriErrorType.missingArgument("Not enough argument for kuri \(type.rawValue)")
                }
                
                return value
            }

            let templatePath: String
            switch hasOption(.templatePath) {
            case true:
                templatePath = value(.templatePath)
            case false:
                let yaml = try YamlResource.loadYamlIfPossible()
                let yamlReader = YamlReader(yaml: yaml, env: env)
                templatePath = yamlReader.templateRootPath()
            }
            switch (hasOption(.templatePath), hasOption(.specify), hasOption(.interactive)) {
            case (false, false, false):
                return
            case (true, _, _):
                templatePath = value(.templatePath)
                return
            case (true, false, _):
                return
            case (true, _, false):
                return
            case (false, true, _):
                return
            case (_, true, false):
                return
            case (false, _, true):
                return
            case (_, false, true):
                return
            }
        })
        }
        .run()
    
} catch {
    
    
}

do {
    guard
        let commandString = args.first,
        let command = CommandType(rawValue: commandString)
        else {
            throw KuriErrorType.missingArgument("Please command name Kuri XXXX")
    }
    
    let options = Array(args.dropFirst())
    switch command {
    case .setup:
        try Setup(args: options, fileOperator: FileOperator(fileManager: Files)).execute()
    case .generate:
        let yaml = try YamlResource.loadYamlIfPossible()
        let yamlReader = YamlReader(yaml: yaml, env: env)
        let argument = GenerateArgument(args: options, yamlReader: yamlReader)
        var generater = Generator(argument: argument, yamlReader: yamlReader)
        try generater.execute()
    }
} catch let e as KuriErrorType {
    print("ErrorType \(e) description: \(e.errorDescription())")
    exit(1)
} catch let e as NSError {
    print(e.localizedDescription)
    exit(2)
} catch {
    print("unknown error")
    
    exit(3)
}

exit(0)

