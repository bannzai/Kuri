//
//  PiyoTranslator.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol PiyoTranslator {
    func translate(from model: PiyoModel) -> PiyoEntity
    func translate(from entity: PiyoEntity) -> PiyoModel
}


struct PiyoTranslatorImpl: PiyoTranslator {
   func translate(from model: PiyoModel) -> PiyoEntity {
       return PiyoEntityImpl(id: model.id)
   }
   func translate(from entity: PiyoEntity) -> PiyoModel {
       return PiyoModelImpl(id: entity.id)
   }
}