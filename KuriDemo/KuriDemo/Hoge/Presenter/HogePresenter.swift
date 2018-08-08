//
//  HogePresenter.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/8/8.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol HogePresenter: class {
    
}


class HogePresenterImpl: HogePresenter {
    private weak var view: HogeView?
    private let wireframe: HogeWireframe
    private let useCase: HogeUseCase
    
    init(
        view: HogeView,
        wireframe: HogeWireframe,
        useCase: HogeUseCase
        ) {
        self.view = view
        self.useCase = useCase
        self.wireframe = wireframe
    }
}