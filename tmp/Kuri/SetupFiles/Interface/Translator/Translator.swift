//
//  __PREFIX__Translator.swift
//  Kuri
//
//  Created by __USERNAME__ on __DATE__.
//  Copyright © __YEAR__ __USERNAME__. All rights reserved.
//


import Foundation

protocol __PREFIX__Translator {
    func translate(from model: __PREFIX__Model) -> __PREFIX__Entity 
    func translate(from entity: __PREFIX__Entity) -> __PREFIX__Model 
}
