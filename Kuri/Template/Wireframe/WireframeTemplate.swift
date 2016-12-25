
import Foundation

struct WireframeTemplate: Templatable {
    func interface() -> String {
        return [
            "//",
            "//  __WIREFRAME__.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © 2016年 __USERNAME__. All rights reserved.",
            "//",
            "",
            "import UIKit",
            "",
            "protocol __WIREFRAME__: class {",
            "    ",
            "}",
            ].joined(separator: "\n")
    }
    
    func implement() -> String {
        return [
            "//",
            "//  __WIREFRAME__Impl.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © 2016年 __USERNAME__. All rights reserved.",
            "//",
            "",
            "import UIKit",
            "",
            "class __WIREFRAME__Impl: __WIREFRAME__ {",
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

