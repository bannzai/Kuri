//
//  KuriRepository.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol KuriRepository {
    func fetch(_ closure: (KuriEntity) -> Void) throws 
}


struct KuriRepositoryImpl: KuriRepository {
    private let dataStore: KuriDataStore
    
    init(
        dataStore: KuriDataStore
        ) {
        self.dataStore = dataStore
    }
    
    func fetch(_ closure: (KuriEntity) -> Void) throws  {
        return try dataStore.fetch(closure)
    }
}