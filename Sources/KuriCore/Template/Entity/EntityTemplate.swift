

import Foundation

struct EntityTemplate: Templatable {
    internal func comment() -> String {
        return [
            "//",
            "//  __PREFIX__Entity.swift",
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
            "protocol __PREFIX__Entity {",
            "    var id: Int { get }",
            "}",
            ].joined(separator: "\n")
    }
    func implement() -> String {
        return [
            "struct __PREFIX__EntityImpl: __PREFIX__Entity {",
            "    let id: Int",
            "}",
            ]
            .joined(separator: "\n")
    }
    
}

