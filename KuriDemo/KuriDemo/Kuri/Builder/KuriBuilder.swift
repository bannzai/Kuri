//
//  KuriBuilder.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import UIKit

protocol KuriBuilder {
    func build() -> UIViewController
}


struct KuriBuilderImpl: KuriBuilder {
    func build() -> UIViewController {
        let viewController = KuriViewController()
        viewController.inject(
            presenter: KuriPresenterImpl(
                view: viewController,
                wireframe: KuriWireframeImpl(
                    viewController: viewController
                ),
                useCase: KuriUseCaseImpl(
                    repository: KuriRepositoryImpl (
                        dataStore: KuriDataStoreImpl()
                    ),
                    translator: KuriTranslatorImpl()
                )
            )
        )
        return viewController
    }
}