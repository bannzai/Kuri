//
//  SPMPresenter.swift
//  Kuri
//
//  Created by yudai-hirose on 2020/5/11.
//  Copyright © 2020 yudai-hirose. All rights reserved.
//

import Foundation

protocol SPMPresenter: class {
    
}


class SPMPresenterImpl: SPMPresenter {
    private weak var view: SPMView?
    private let wireframe: SPMWireframe
    private let useCase: SPMUseCase
    
    init(
        view: SPMView,
        wireframe: SPMWireframe,
        useCase: SPMUseCase
        ) {
        self.view = view
        self.useCase = useCase
        self.wireframe = wireframe
    }
}