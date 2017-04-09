
import Foundation

struct WireframeTemplate: Templatable {
    internal func comment() -> String {
        return [
            "//",
            "//  __PREFIX__Wireframe.swift",
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
            "import UIKit",
            "",
            "protocol __PREFIX__Wireframe: class {",
            "    ",
            "}",
            ].joined(separator: "\n")
    }
    
    func implement() -> String {
        return [
            "import UIKit",
            "",
            "class __PREFIX__WireframeImpl: __PREFIX__Wireframe {",
            "    private weak var viewController: UIViewController!",
            "    ",
            "    init(",
            "        viewController: UIViewController",
            "        ) {",
            "        self.viewController = viewController",
            "    }",
            "}",
            ].joined(separator: "\n")
    }
}

