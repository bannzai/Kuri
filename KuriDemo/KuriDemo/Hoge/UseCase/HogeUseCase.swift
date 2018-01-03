//
//  HogeUseCase.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol HogeUseCase {
    func fetch(_ closure: (HogeModel) -> Void) throws 
}


struct HogeUseCaseImpl: HogeUseCase {
    private let repository: HogeRepository
    private let translator: HogeTranslator
    
    init(
        repository: HogeRepository, 
        translator: HogeTranslator
        ) {
        self.repository = repository
        self.translator = translator
    }
    
    func fetch(_ closure: (HogeModel) -> Void) throws  {
        try repository.fetch { 
           closure(
              translator.translate(from: $0)
           )
      }
    }
}