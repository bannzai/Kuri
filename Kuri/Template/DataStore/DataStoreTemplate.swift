

import Foundation

struct DataStoreTemplate: Templatable {
    func interface() -> String {
        return [
            "//",
            "//  __PREFIX__DataStore.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © __YEAR__ __USERNAME__. All rights reserved.",
            "//",
            "",
            "import Foundation",
            "",
            "protocol __PREFIX__DataStore {",
            "    func fetch(_ closure: (__PREFIX__Entity) -> Void) throws ",
            "}",
            ].joined(separator: "\n")
    }
    
    func implement() -> String {
        return [
            "//",
            "//  __PREFIX__DataStoreImpl.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © __YEAR__ __USERNAME__. All rights reserved.",
            "//",
            "",
            "import Foundation",
            "",
            "struct __PREFIX__DataStoreImpl: __PREFIX__DataStore {",
            "    func fetch(_ closure: (__PREFIX__Entity) -> Void) throws  {",
            "        // you can write get entity method",
            "    }",
            "}",
        ].joined(separator: "\n")
    }
}


