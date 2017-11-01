//
//  __USECASE__Impl.swift
//  Kuri
//
//  Created by __USERNAME__ on __DATE__.
//  Copyright © 2016年 __USERNAME__. All rights reserved.
//

import Foundation

struct __USECASE__Impl: __USECASE__ {
    private let repository: __REPOSITORY__
    private let translator: __TRANSLATOR__
    
    init(
        repository: __REPOSITORY__, 
        translator: __TRANSLATOR__
        ) {
        self.repository = repository
        self.translator = translator
    }
    
    func fetch() throws -> __ENTITY__ {
        return try repository.fetch()
    }
}