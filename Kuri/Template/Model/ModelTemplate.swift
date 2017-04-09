

import Foundation

struct ModelTemplate: Templatable {
    func comment() -> String {
        return [
            "//",
            "//  __PREFIX__Model.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © __YEAR__ __USERNAME__. All rights reserved.",
            "//",
            "",
            ].joined(separator: "\n")
    }
    func interface() -> String {
        return [
            "import Foundation",
            "",
            "protocol __PREFIX__Model {",
            "   var id: Int { get }",
            "}",
            ].joined(separator: "\n")
    }
    func implement() -> String {
        return [
            "import Foundation",
            "",
            "struct __PREFIX__ModelImpl: __PREFIX__Model {",
            "    let id: Int",
            "}",
            ].joined(separator: "\n")
    }
}

