//
//  HogeEntity.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/8/8.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol HogeEntity {
    var id: Int { get }
}


struct HogeEntityImpl: HogeEntity {
    let id: Int
}