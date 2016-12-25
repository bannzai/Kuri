
import Foundation

struct BuilderTemplate: Templatable {
    func interface() -> String {
        return [
            "//",
            "//  __BUILDER__.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © 2016年 __USERNAME__. All rights reserved.",
            "//",
            "",
            "import UIKit",
            "",
            "protocol __BUILDER__ {",
            "    func build() -> UIViewController",
            "}",
            ].joined(separator: "\n")
    }

    func implement() -> String {
        return [
            "//",
            "//  __BUILDER__Impl.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © 2016年 __USERNAME__. All rights reserved.",
            "//",
            "",
            "import UIKit",
            "",
            "struct __BUILDER__Impl: __BUILDER__ {",
            "    func build() -> UIViewController {",
            "        let viewController = __VIEW__()",
            "        viewController.inject(",
            "            presenter: __PRESENTER__Impl(",
            "                view: viewController,",
            "                wireframe: __WIREFRAME__Impl(",
            "                    viewController: viewController",
            "                ),",
            "                useCase: __USECASE__Impl(",
            "                    repository: __REPOSITORY__Impl (",
            "                        dataStore: __DATASTORE__Impl()",
            "                    ),",
            "                    translator: __TRANSLATOR__Impl()",
            "                )",
            "            )",
            "        )",
            "        return viewController",
            "    }",
            "}",
            ].joined(separator: "\n")
    }
}




