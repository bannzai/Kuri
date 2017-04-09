
import Foundation

struct UseCaseTemplate: Templatable {
    func comment() -> String {
        return [
            "//",
            "//  __PREFIX__UseCase.swift",
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
            "protocol __PREFIX__UseCase {",
            "    func fetch(_ closure: (__PREFIX__Model) -> Void) throws ",
            "}",
            ].joined(separator: "\n")
    }
    
    func implement() -> String {
        return [
            "import Foundation",
            "",
            "struct __PREFIX__UseCaseImpl: __PREFIX__UseCase {",
            "    private let repository: __PREFIX__Repository",
            "    private let translator: __PREFIX__Translator",
            "    ",
            "    init(",
            "        repository: __PREFIX__Repository, ",
            "        translator: __PREFIX__Translator",
            "        ) {",
            "        self.repository = repository",
            "        self.translator = translator",
            "    }",
            "    ",
            "    func fetch(_ closure: (__PREFIX__Model) -> Void) throws  {",
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

