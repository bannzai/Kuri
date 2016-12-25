import Foundation

struct TranslatorTemplate: Templatable {
    func interface() -> String {
        return [
            "//",
            "//  __TRANSLATOR__.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © 2016年 __USERNAME__. All rights reserved.",
            "//",
            "",
            "",
            "import Foundation",
            "",
            "protocol __TRANSLATOR__ {",
            "    func translate(from model: __MODEL__) -> __ENTITY__",
            "    func translate(from entity: __ENTITY__) -> __MODEL__",
            "}",
            ].joined(separator: "\n")
    }
    
    func implement() -> String {
        return [
            "//",
            "//  __TRANSLATOR__Impl.swift",
            "//  Kuri",
            "//",
            "//  Created by __USERNAME__ on __DATE__.",
            "//  Copyright © 2016年 __USERNAME__. All rights reserved.",
            "//",
            "",
            "import Foundation",
            "",
            "struct __TRANSLATOR__Impl: __TRANSLATOR__ {",
            "func translate(from model: __MODEL__) -> __ENTITY__ {",
            "    return __ENTITY__Impl(id: model.id)",
            "}",
            "func translate(from entity: __ENTITY__) -> __MODEL__ {",
            "    return __MODEL__Impl(id: entity.id)",
            "}",
            "}",
            ].joined(separator: "\n")
    }
    
}
