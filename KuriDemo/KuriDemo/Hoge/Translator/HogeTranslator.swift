//
//  HogeTranslator.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol HogeTranslator {
    func translate(from model: HogeModel) -> HogeEntity
    func translate(from entity: HogeEntity) -> HogeModel
}


struct HogeTranslatorImpl: HogeTranslator {
   func translate(from model: HogeModel) -> HogeEntity {
       return HogeEntityImpl(id: model.id)
   }
   func translate(from entity: HogeEntity) -> HogeModel {
       return HogeModelImpl(id: entity.id)
   }
}