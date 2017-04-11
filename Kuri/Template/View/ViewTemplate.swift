import Foundation

struct ViewTemplate: Templatable {
    func comment() -> String {
        return [
            "//",
            "//  __PREFIX__View.swift",
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
            "protocol __PREFIX__View: class {",
            "    ",
            "}",
            ].joined(separator: "\n")
    }
    
    func implement() -> String {
        return [
            "class __PREFIX__ViewController: UIViewController {",
            "    ",
            "    private var presenter: __PREFIX__Presenter!",
            "    ",
            "    func inject(",
            "        presenter: __PREFIX__Presenter",
            "        ) {",
            "        self.presenter = presenter",
            "    }",
            "    ",
            "    override func viewDidLoad() {",
            "        super.viewDidLoad()",
            "    }",
            "}",
            "",
            "extension __PREFIX__ViewController: __PREFIX__View {",
            "    ",
            "}",
            ].joined(separator: "\n")
    }
}


