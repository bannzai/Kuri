//
//  HogeModel.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/8/8.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol HogeModel {
   var id: Int { get }
}


struct HogeModelImpl: HogeModel {
    let id: Int
}