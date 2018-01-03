//
//  HogeEntity.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol HogeEntity {
    var id: Int { get }
}


struct HogeEntityImpl: HogeEntity {
    let id: Int
}