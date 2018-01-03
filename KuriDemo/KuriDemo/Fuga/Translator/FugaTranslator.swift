//
//  FugaTranslator.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol FugaTranslator {
    func translate(from model: FugaModel) -> FugaEntity
    func translate(from entity: FugaEntity) -> FugaModel
}


struct FugaTranslatorImpl: FugaTranslator {
   func translate(from model: FugaModel) -> FugaEntity {
       return FugaEntityImpl(id: model.id)
   }
   func translate(from entity: FugaEntity) -> FugaModel {
       return FugaModelImpl(id: entity.id)
   }
}