//
//  FugaRepository.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol FugaRepository {
    func fetch(_ closure: (FugaEntity) -> Void) throws 
}


struct FugaRepositoryImpl: FugaRepository {
    private let dataStore: FugaDataStore
    
    init(
        dataStore: FugaDataStore
        ) {
        self.dataStore = dataStore
    }
    
    func fetch(_ closure: (FugaEntity) -> Void) throws  {
        return try dataStore.fetch(closure)
    }
}