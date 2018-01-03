//
//  KuriPresenter.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import Foundation

protocol KuriPresenter: class {
    
}


class KuriPresenterImpl: KuriPresenter {
    private weak var view: KuriView?
    private let wireframe: KuriWireframe
    private let useCase: KuriUseCase
    
    init(
        view: KuriView,
        wireframe: KuriWireframe,
        useCase: KuriUseCase
        ) {
        self.view = view
        self.useCase = useCase
        self.wireframe = wireframe
    }
}