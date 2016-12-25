import Foundation

struct ViewTemplate: Templatable {
    func interface() -> String {
        return [
            "//",
            "//  __VIEW__Output.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © 2016年 __USERNAME__. All rights reserved.",
            "//",
            "",
            "import UIKit",
            "",
            "protocol __VIEW__Output: class {",
            "    ",
            "}",
            ].joined(separator: "\n")
    }
    
    func implement() -> String {
        return [
            "//",
            "//  __VIEW__.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © 2016年 __USERNAME__. All rights reserved.",
            "//",
            "",
            "import UIKit",
            "",
            "class __VIEW__: UIViewController {",
            "    ",
            "    private var presenter: __PRESENTER__!",
            "    ",
            "    func inject(",
            "        presenter: __PRESENTER__",
            "        ) {",
            "        self.presenter = presenter",
            "    }",
            "    ",
            "    override func viewDidLoad() {",
            "        super.viewDidLoad()",
            "    }",
            "}",
            "",
            "extension __VIEW__: __VIEW__Output {",
            "    ",
            "}",
            ].joined(separator: "\n")
    }
}


