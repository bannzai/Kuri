//
//  KuriDataStore.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol KuriDataStore {
    func fetch(_ closure: (KuriEntity) -> Void) throws 
}


struct KuriDataStoreImpl: KuriDataStore {
    func fetch(_ closure: (KuriEntity) -> Void) throws  {
        // you can write get entity method
    }
}