//
//  FugaBuilder.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import UIKit

protocol FugaBuilder {
    func build() -> UIViewController
}


struct FugaBuilderImpl: FugaBuilder {
    func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "FugaCollectionViewController", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! FugaCollectionViewController
        viewController.inject(
            presenter: FugaPresenterImpl(
                view: viewController,
                wireframe: FugaWireframeImpl(
                    viewController: viewController
                ),
                useCase: FugaUseCaseImpl(
                    repository: FugaRepositoryImpl (
                        dataStore: FugaDataStoreImpl()
                    ),
                    translator: FugaTranslatorImpl()
                )
            )
        )
        return viewController
    }
}

