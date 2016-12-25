

import Foundation

struct ModelTemplate: Templatable {
    func interface() -> String {
        return [
            "//",
            "//  __MODEL__.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © 2016年 __USERNAME__. All rights reserved.",
            "//",
            "",
            "import Foundation",
            "",
            "protocol __MODEL__ {",
            "    var id: Int { get }",
            "}",
            ].joined(separator: "\n")
    }
    func implement() -> String {
        return [
            "//",
            "//  __MODEL__Impl.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © 2016年 __USERNAME__. All rights reserved.",
            "//",
            "",
            "import Foundation",
            "",
            "struct __MODEL__Impl: __MODEL__ {",
            "    let id: Int",
            "}",
            ].joined(separator: "\n")
    }
}

