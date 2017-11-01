//
//  __PREFIX__RepositoryImpl.swift
//  Kuri
//
//  Created by __USERNAME__ on __DATE__.
//  Copyright © __YEAR__ __USERNAME__. All rights reserved.
//

struct __PREFIX__RepositoryImpl: __PREFIX__Repository {
    private let dataStore: __PREFIX__DataStore
    
    init(
        dataStore: __PREFIX__DataStore
        ) {
        self.dataStore = dataStore
    }
    
    func fetch(_ closure: (__PREFIX__Entity) -> Void) throws  {
        return try dataStore.fetch(closure)
    }
}
