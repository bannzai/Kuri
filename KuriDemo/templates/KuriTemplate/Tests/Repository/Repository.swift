//
//  __PREFIX__Repository.swift
//  Kuri
//
//  Created by __USERNAME__ on __DATE__.
//  Copyright © __YEAR__ __USERNAME__. All rights reserved.
//

import Foundation

protocol __PREFIX__Repository {
    func fetch(_ closure: (__PREFIX__Entity) -> Void) throws 
}


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