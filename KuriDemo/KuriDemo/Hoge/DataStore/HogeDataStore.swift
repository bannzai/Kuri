//
//  HogeDataStore.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/8/7.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol HogeDataStore {
    func fetch(_ closure: (HogeEntity) -> Void) throws 
}


struct HogeDataStoreImpl: HogeDataStore {
    func fetch(_ closure: (HogeEntity) -> Void) throws  {
        // you can write get entity method
    }
}