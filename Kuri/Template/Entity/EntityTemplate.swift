

import Foundation

struct EntityTemplate: Templatable {
    func interface() -> String {
        return [
            "//",
            "//  __ENTITY__.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © 2016年 __USERNAME__. All rights reserved.",
            "//",
            "",
            "import Foundation",
            "",
            "protocol __ENTITY__ {",
            "    var id: Int { get }",
            "}",
            ].joined(separator: "\n")
    }
    func implement() -> String {
        return [
            "//",
            "//  __ENTITY__Impl.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © 2016年 __USERNAME__. All rights reserved.",
            "//",
            "",
            "import Foundation",
            "",
            "struct __ENTITY__Impl: __ENTITY__ {",
            "    let id: Int",
            "}",
            ]
            .joined(separator: "\n")
    }
    
}

