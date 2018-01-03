//
//  KuriEntity.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol KuriEntity {
    var id: Int { get }
}


struct KuriEntityImpl: KuriEntity {
    let id: Int
}