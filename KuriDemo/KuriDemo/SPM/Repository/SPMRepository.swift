//
//  SPMRepository.swift
//  Kuri
//
//  Created by yudai-hirose on 2020/5/11.
//  Copyright © 2020 yudai-hirose. All rights reserved.
//

import Foundation

protocol SPMRepository {
    func fetch(_ closure: (SPMEntity) -> Void) throws 
}


struct SPMRepositoryImpl: SPMRepository {
    private let dataStore: SPMDataStore
    
    init(
        dataStore: SPMDataStore
        ) {
        self.dataStore = dataStore
    }
    
    func fetch(_ closure: (SPMEntity) -> Void) throws  {
        return try dataStore.fetch(closure)
    }
}