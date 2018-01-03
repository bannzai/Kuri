//
//  KuriTranslator.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol KuriTranslator {
    func translate(from model: KuriModel) -> KuriEntity
    func translate(from entity: KuriEntity) -> KuriModel
}


struct KuriTranslatorImpl: KuriTranslator {
   func translate(from model: KuriModel) -> KuriEntity {
       return KuriEntityImpl(id: model.id)
   }
   func translate(from entity: KuriEntity) -> KuriModel {
       return KuriModelImpl(id: entity.id)
   }
}