//
//  SPMEntity.swift
//  Kuri
//
//  Created by yudai-hirose on 2020/5/11.
//  Copyright © 2020 yudai-hirose. All rights reserved.
//

import Foundation

protocol SPMEntity {
    var id: Int { get }
}


struct SPMEntityImpl: SPMEntity {
    let id: Int
}