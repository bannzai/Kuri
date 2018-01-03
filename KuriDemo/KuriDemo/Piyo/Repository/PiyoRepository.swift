//
//  PiyoRepository.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol PiyoRepository {
    func fetch(_ closure: (PiyoEntity) -> Void) throws 
}


struct PiyoRepositoryImpl: PiyoRepository {
    private let dataStore: PiyoDataStore
    
    init(
        dataStore: PiyoDataStore
        ) {
        self.dataStore = dataStore
    }
    
    func fetch(_ closure: (PiyoEntity) -> Void) throws  {
        return try dataStore.fetch(closure)
    }
}