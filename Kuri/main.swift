//
//  main.swift
//  Kuri
//
//  Created by kingkong999yhirose on 2016/12/02.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//
 
import Foundation

let env = ProcessInfo().environment
let args = Array(ProcessInfo().arguments.dropFirst())

if let debugPath = env["WorkingDirectory"] {
    main.currentdirectory = debugPath
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
        try Setup(options: options, fileOperator: FileOperator(fileManager: Files)).execute()
    case .generate:
        let yaml = try YamlResource.loadYamlIfPossible()
        let yamlReader = YamlReader(yaml: yaml, env: env)
         try Generate(options: options, yamlReader: yamlReader).execute()
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


//let mainProjectPath = main.currentdirectory
//let mainGeneratePath = mainProjectPath + "Kuri/"

//func getStandardInput() throws -> String {
//    guard
//        let characters = main.stdin.readSome()?.characters.dropLast()
//        else{
//            throw KuriErrorType.readInputError
//    }
//    let input = String(characters)
//    return input
//}

//func generateMainProject() throws -> XCProject {
//    if let yamlProjectPath = yaml?.dictionary?[.string(MainYamlProperty.Project.rawValue)]?.string {
//        let url = URL(fileURLWithPath: yamlProjectPath + "/" + "project.pbxproj")
//        return try XCProject(for: url)
//    }
//    
//    let xcodeprojcts = run(bash: "ls | grep xcodeproj").components(separatedBy: "\n")
//    if xcodeprojcts.count > 1 {
//        fatalError("There are many Xcode project found, please specify one.")
//    }
//    
//    guard
//        let _ = xcodeprojcts.first?.components(separatedBy: ".").first
//        else {
//            fatalError("No Xcode project found, please specify one")
//    }
//    
//    let xcodeprojectFilePath = mainProjectPath + run(bash: "ls | grep xcodeproj") + "/"
//    let xcodeprojectFileUrl = URL(fileURLWithPath: xcodeprojectFilePath + "project.pbxproj")
//    return try XCProject(for: xcodeprojectFileUrl)
//}


exit(0)

