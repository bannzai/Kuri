//
//  __PREFIX__Model.swift
//  Kuri
//
//  Created by __USERNAME__ on __DATE__.
//  Copyright © __YEAR__ __USERNAME__. All rights reserved.
//

import Foundation

protocol __PREFIX__Model {
   var id: Int { get }
}


struct __PREFIX__ModelImpl: __PREFIX__Model {
    let id: Int
}