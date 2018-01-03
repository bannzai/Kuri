//
//  KuriUseCase.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol KuriUseCase {
    func fetch(_ closure: (KuriModel) -> Void) throws 
}


struct KuriUseCaseImpl: KuriUseCase {
    private let repository: KuriRepository
    private let translator: KuriTranslator
    
    init(
        repository: KuriRepository, 
        translator: KuriTranslator
        ) {
        self.repository = repository
        self.translator = translator
    }
    
    func fetch(_ closure: (KuriModel) -> Void) throws  {
        try repository.fetch { 
           closure(
              translator.translate(from: $0)
           )
      }
    }
}