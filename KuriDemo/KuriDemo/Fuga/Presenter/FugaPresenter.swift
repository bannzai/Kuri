//
//  FugaPresenter.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol FugaPresenter: class {
    
}


class FugaPresenterImpl: FugaPresenter {
    private weak var view: FugaView?
    private let wireframe: FugaWireframe
    private let useCase: FugaUseCase
    
    init(
        view: FugaView,
        wireframe: FugaWireframe,
        useCase: FugaUseCase
        ) {
        self.view = view
        self.useCase = useCase
        self.wireframe = wireframe
    }
}