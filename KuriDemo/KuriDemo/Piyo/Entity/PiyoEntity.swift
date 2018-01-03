//
//  PiyoEntity.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol PiyoEntity {
    var id: Int { get }
}


struct PiyoEntityImpl: PiyoEntity {
    let id: Int
}