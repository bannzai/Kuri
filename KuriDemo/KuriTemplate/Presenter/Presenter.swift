//
//  __PREFIX__Presenter.swift
//  Kuri
//
//  Created by __USERNAME__ on __DATE__.
//  Copyright © __YEAR__ __USERNAME__. All rights reserved.
//

import Foundation

protocol __PREFIX__Presenter: class {
    
}


class __PREFIX__PresenterImpl: __PREFIX__Presenter {
    private weak var view: __PREFIX__View?
    private let wireframe: __PREFIX__Wireframe
    private let useCase: __PREFIX__UseCase
    
    init(
        view: __PREFIX__View,
        wireframe: __PREFIX__Wireframe,
        useCase: __PREFIX__UseCase
        ) {
        self.view = view
        self.useCase = useCase
        self.wireframe = wireframe
    }
}