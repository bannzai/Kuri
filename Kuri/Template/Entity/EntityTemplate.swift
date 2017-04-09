

import Foundation

struct EntityTemplate: Templatable {
    func interface() -> String {
        return [
            "//",
            "//  __PREFIX__Entity.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © __YEAR__ __USERNAME__. All rights reserved.",
            "//",
            "",
            "import Foundation",
            "",
            "protocol __PREFIX__Entity {",
            "    var id: Int { get }",
            "}",
            ].joined(separator: "\n")
    }
    func implement() -> String {
        return [
            "//",
            "//  __PREFIX__EntityImpl.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © __YEAR__ __USERNAME__. All rights reserved.",
            "//",
            "",
            "import Foundation",
            "",
            "struct __PREFIX__EntityImpl: __PREFIX__Entity {",
            "    let id: Int",
            "}",
            ]
            .joined(separator: "\n")
    }
    
}

