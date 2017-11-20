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


let group = Commander.Group {
    $0.command("generate", { (hoge: String, f: ArgumentParser) in
        print("hoge: \(hoge)")
        print("f: \(f.hasOption("paths"))")
    })
    }
    .run()

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

