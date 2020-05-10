//
//  SPMUseCase.swift
//  Kuri
//
//  Created by yudai-hirose on 2020/5/11.
//  Copyright © 2020 yudai-hirose. All rights reserved.
//

import Foundation

protocol SPMUseCase {
    func fetch(_ closure: (SPMModel) -> Void) throws 
}


struct SPMUseCaseImpl: SPMUseCase {
    private let repository: SPMRepository
    private let translator: SPMTranslator
    
    init(
        repository: SPMRepository, 
        translator: SPMTranslator
        ) {
        self.repository = repository
        self.translator = translator
    }
    
    func fetch(_ closure: (SPMModel) -> Void) throws  {
        try repository.fetch { 
           closure(
              translator.translate(from: $0)
           )
      }
    }
}