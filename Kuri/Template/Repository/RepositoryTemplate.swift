

import Foundation

struct RepositoryTemplate: Templatable {
    func interface() -> String {
        return [
            "//",
            "//  __REPOSITORY__.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © 2016年 __USERNAME__. All rights reserved.",
            "//",
            "",
            "protocol __REPOSITORY__ {",
            "    func fetch() throws -> __ENTITY__",
            "}",
        ].joined(separator: "\n")
    }
    
    func implement() -> String {
        return [
            "//",
            "//  __REPOSITORY__Impl.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © 2016年 __USERNAME__. All rights reserved.",
            "//",
            "",
            "struct __REPOSITORY__Impl: __REPOSITORY__ {",
            "    private let dataStore: __DATASTORE__",
            "    ",
            "    init(",
            "        dataStore: __DATASTORE__",
            "        ) {",
            "        self.dataStore = dataStore",
            "    }",
            "    ",
            "    func fetch() throws -> __ENTITY__ {",
            "        return try dataStore.fetch()",
            "    }",
            "}",
        ].joined(separator: "\n")
    }
}
