//
//  __REPOSITORY__Impl.swift
//  Kuri
//
//  Created by __USERNAME__ on __DATE__.
//  Copyright © 2016年 __USERNAME__. All rights reserved.
//

struct __REPOSITORY__Impl: __REPOSITORY__ {
    private let dataStore: __DATASTORE__
    
    init(
        dataStore: __DATASTORE__
        ) {
        self.dataStore = dataStore
    }
    
    func fetch(_ closure: (__ENTITY__) -> Void) throws  {
        return try dataStore.fetch(closure)
    }
}
