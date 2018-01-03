//
//  PiyoDataStore.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol PiyoDataStore {
    func fetch(_ closure: (PiyoEntity) -> Void) throws 
}


struct PiyoDataStoreImpl: PiyoDataStore {
    func fetch(_ closure: (PiyoEntity) -> Void) throws  {
        // you can write get entity method
    }
}