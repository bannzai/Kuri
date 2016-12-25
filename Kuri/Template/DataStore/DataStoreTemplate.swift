

import Foundation

struct DataStoreTemplate: Templatable {
    func interface() -> String {
        return [
            "//",
            "//  __DATASTORE__.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © 2016年 __USERNAME__. All rights reserved.",
            "//",
            "",
            "import Foundation",
            "",
            "protocol __DATASTORE__ {",
            "    func fetch() throws -> __ENTITY__",
            "}",
            ].joined(separator: "\n")
    }
    
    func implement() -> String {
        return [
            "//",
            "//  __DATASTORE__Impl.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © 2016年 __USERNAME__. All rights reserved.",
            "//",
            "",
            "import Foundation",
            "",
            "struct __DATASTORE__Impl: __DATASTORE__ {",
            "    func fetch() throws -> __ENTITY__ {",
            "        // you can write get entity method",
            "    }",
            "}",
        ].joined(separator: "\n")
    }
}


