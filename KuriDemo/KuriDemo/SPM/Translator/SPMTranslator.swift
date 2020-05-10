//
//  SPMTranslator.swift
//  Kuri
//
//  Created by yudai-hirose on 2020/5/11.
//  Copyright © 2020 yudai-hirose. All rights reserved.
//

import Foundation

protocol SPMTranslator {
    func translate(from model: SPMModel) -> SPMEntity
    func translate(from entity: SPMEntity) -> SPMModel
}


struct SPMTranslatorImpl: SPMTranslator {
   func translate(from model: SPMModel) -> SPMEntity {
       return SPMEntityImpl(id: model.id)
   }
   func translate(from entity: SPMEntity) -> SPMModel {
       return SPMModelImpl(id: entity.id)
   }
}