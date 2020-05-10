//
//  SPMBuilder.swift
//  Kuri
//
//  Created by yudai-hirose on 2020/5/11.
//  Copyright © 2020 yudai-hirose. All rights reserved.
//

import UIKit

protocol SPMBuilder {
    func build() -> UIViewController
}


struct SPMBuilderImpl: SPMBuilder {
    func build() -> UIViewController {
        let viewController = SPMViewController()
        viewController.inject(
            presenter: SPMPresenterImpl(
                view: viewController,
                wireframe: SPMWireframeImpl(
                    viewController: viewController
                ),
                useCase: SPMUseCaseImpl(
                    repository: SPMRepositoryImpl (
                        dataStore: SPMDataStoreImpl()
                    ),
                    translator: SPMTranslatorImpl()
                )
            )
        )
        return viewController
    }
}