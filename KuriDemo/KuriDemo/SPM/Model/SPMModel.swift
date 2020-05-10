//
//  SPMModel.swift
//  Kuri
//
//  Created by yudai-hirose on 2020/5/11.
//  Copyright © 2020 yudai-hirose. All rights reserved.
//

import Foundation

protocol SPMModel {
   var id: Int { get }
}


struct SPMModelImpl: SPMModel {
    let id: Int
}