//
//  HogeRepository.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/8/7.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol HogeRepository {
    func fetch(_ closure: (HogeEntity) -> Void) throws 
}


struct HogeRepositoryImpl: HogeRepository {
    private let dataStore: HogeDataStore
    
    init(
        dataStore: HogeDataStore
        ) {
        self.dataStore = dataStore
    }
    
    func fetch(_ closure: (HogeEntity) -> Void) throws  {
        return try dataStore.fetch(closure)
    }
}