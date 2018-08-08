//
//  HogeBuilder.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/8/8.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import UIKit

protocol HogeBuilder {
    func build() -> UIViewController
}


struct HogeBuilderImpl: HogeBuilder {
    func build() -> UIViewController {
        let viewController = HogeViewController()
        viewController.inject(
            presenter: HogePresenterImpl(
                view: viewController,
                wireframe: HogeWireframeImpl(
                    viewController: viewController
                ),
                useCase: HogeUseCaseImpl(
                    repository: HogeRepositoryImpl (
                        dataStore: HogeDataStoreImpl()
                    ),
                    translator: HogeTranslatorImpl()
                )
            )
        )
        return viewController
    }
}