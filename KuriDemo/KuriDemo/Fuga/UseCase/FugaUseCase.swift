//
//  FugaUseCase.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol FugaUseCase {
    func fetch(_ closure: (FugaModel) -> Void) throws 
}


struct FugaUseCaseImpl: FugaUseCase {
    private let repository: FugaRepository
    private let translator: FugaTranslator
    
    init(
        repository: FugaRepository, 
        translator: FugaTranslator
        ) {
        self.repository = repository
        self.translator = translator
    }
    
    func fetch(_ closure: (FugaModel) -> Void) throws  {
        try repository.fetch { 
           closure(
              translator.translate(from: $0)
           )
      }
    }
}