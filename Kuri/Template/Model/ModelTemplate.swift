

import Foundation

struct ModelTemplate: Templatable {
    func interface() -> String {
        return [
            "//",
            "//  __PREFIX__Model.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © __YEAR__ __USERNAME__. All rights reserved.",
            "//",
            "",
            "import Foundation",
            "",
            "protocol __PREFIX__Model {",
            "   var id: Int { get }",
            "}",
            ].joined(separator: "\n")
    }
    func implement() -> String {
        return [
            "//",
            "//  __PREFIX__ModelImpl.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © __YEAR__ __USERNAME__. All rights reserved.",
            "//",
            "",
            "import Foundation",
            "",
            "struct __PREFIX__ModelImpl: __PREFIX__Model {",
            "    let id: Int",
            "}",
            ].joined(separator: "\n")
    }
}

