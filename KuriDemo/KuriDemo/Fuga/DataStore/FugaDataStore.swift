//
//  FugaDataStore.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol FugaDataStore {
    func fetch(_ closure: (FugaEntity) -> Void) throws 
}


struct FugaDataStoreImpl: FugaDataStore {
    func fetch(_ closure: (FugaEntity) -> Void) throws  {
        // you can write get entity method
    }
}