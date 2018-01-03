//
//  PiyoPresenter.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol PiyoPresenter: class {
    
}


class PiyoPresenterImpl: PiyoPresenter {
    private weak var view: PiyoView?
    private let wireframe: PiyoWireframe
    private let useCase: PiyoUseCase
    
    init(
        view: PiyoView,
        wireframe: PiyoWireframe,
        useCase: PiyoUseCase
        ) {
        self.view = view
        self.useCase = useCase
        self.wireframe = wireframe
    }
}