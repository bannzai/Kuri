//
//  PiyoUseCase.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol PiyoUseCase {
    func fetch(_ closure: (PiyoModel) -> Void) throws 
}


struct PiyoUseCaseImpl: PiyoUseCase {
    private let repository: PiyoRepository
    private let translator: PiyoTranslator
    
    init(
        repository: PiyoRepository, 
        translator: PiyoTranslator
        ) {
        self.repository = repository
        self.translator = translator
    }
    
    func fetch(_ closure: (PiyoModel) -> Void) throws  {
        try repository.fetch { 
           closure(
              translator.translate(from: $0)
           )
      }
    }
}