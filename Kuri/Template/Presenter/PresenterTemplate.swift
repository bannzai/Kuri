
import Foundation

struct PresenterTemplate: Templatable {
    func comment() -> String {
        return [
            "//",
            "//  __PREFIX__Presenter.swift",
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
            "protocol __PREFIX__Presenter: class {",
            "    ",
            "}",
        ].joined(separator: "\n")
    }
    func implement() -> String {
        return [
            "class __PREFIX__PresenterImpl: __PREFIX__Presenter {",
            "    private weak var view: __PREFIX__ViewOutput?",
            "    private let wireframe: __PREFIX__Wireframe",
            "    private let useCase: __PREFIX__UseCase",
            "    ",
            "    init(",
            "        view: __PREFIX__ViewOutput,",
            "        wireframe: __PREFIX__Wireframe,",
            "        useCase: __PREFIX__UseCase",
            "        ) {",
            "        self.view = view",
            "        self.useCase = useCase",
            "        self.wireframe = wireframe",
            "    }",
            "}",
        ].joined(separator: "\n")
    }
}


