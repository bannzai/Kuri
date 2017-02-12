
import Foundation

struct UseCaseTemplate: Templatable {
    func interface() -> String {
        return [
            "//",
            "//  __USECASE__.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © 2016年 __USERNAME__. All rights reserved.",
            "//",
            "",
            "import Foundation",
            "",
            "protocol __USECASE__ {",
            "    func fetch(_ closure: (__MODEL__) -> Void) throws ",
            "}",
            ].joined(separator: "\n")
    }
    
    func implement() -> String {
        return [
            "//",
            "//  __USECASE__Impl.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © 2016年 __USERNAME__. All rights reserved.",
            "//",
            "",
            "import Foundation",
            "",
            "struct __USECASE__Impl: __USECASE__ {",
            "    private let repository: __REPOSITORY__",
            "    private let translator: __TRANSLATOR__",
            "    ",
            "    init(",
            "        repository: __REPOSITORY__, ",
            "        translator: __TRANSLATOR__",
            "        ) {",
            "        self.repository = repository",
            "        self.translator = translator",
            "    }",
            "    ",
            "    func fetch(_ closure: (__MODEL__) -> Void) throws  {",
            "        try repository.fetch { ",
            "           closure(",
            "              translator.translate(from: $0)",
            "           )",
            "      }",
            "    }",
            "}",
            ].joined(separator: "\n")
    }
}

