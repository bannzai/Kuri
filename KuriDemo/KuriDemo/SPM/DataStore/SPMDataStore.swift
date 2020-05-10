//
//  SPMDataStore.swift
//  Kuri
//
//  Created by yudai-hirose on 2020/5/11.
//  Copyright © 2020 yudai-hirose. All rights reserved.
//

import Foundation

protocol SPMDataStore {
    func fetch(_ closure: (SPMEntity) -> Void) throws 
}


struct SPMDataStoreImpl: SPMDataStore {
    func fetch(_ closure: (SPMEntity) -> Void) throws  {
        // you can write get entity method
    }
}