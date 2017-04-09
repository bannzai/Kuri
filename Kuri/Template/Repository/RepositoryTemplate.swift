

import Foundation

struct RepositoryTemplate: Templatable {
    func interface() -> String {
        return [
            "//",
            "//  __PREFIX__Repository.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © __YEAR__ __USERNAME__. All rights reserved.",
            "//",
            "",
            "protocol __PREFIX__Repository {",
            "    func fetch(_ closure: (__PREFIX__Entity) -> Void) throws ",
            "}",
        ].joined(separator: "\n")
    }
    
    func implement() -> String {
        return [
            "//",
            "//  __PREFIX__RepositoryImpl.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © __YEAR__ __USERNAME__. All rights reserved.",
            "//",
            "",
            "struct __PREFIX__RepositoryImpl: __PREFIX__Repository {",
            "    private let dataStore: __PREFIX__DataStore",
            "    ",
            "    init(",
            "        dataStore: __PREFIX__DataStore",
            "        ) {",
            "        self.dataStore = dataStore",
            "    }",
            "    ",
            "    func fetch(_ closure: (__PREFIX__Entity) -> Void) throws  {",
            "        return try dataStore.fetch(closure)",
            "    }",
            "}",
        ].joined(separator: "\n")
    }
}
