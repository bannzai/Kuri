//
//  PiyoBuilder.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import UIKit

protocol PiyoBuilder {
    func build() -> UIViewController
}


struct PiyoBuilderImpl: PiyoBuilder {
    func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "PiyoTableViewController", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! PiyoTableViewController
        viewController.inject(
            presenter: PiyoPresenterImpl(
                view: viewController,
                wireframe: PiyoWireframeImpl(
                    viewController: viewController
                ),
                useCase: PiyoUseCaseImpl(
                    repository: PiyoRepositoryImpl (
                        dataStore: PiyoDataStoreImpl()
                    ),
                    translator: PiyoTranslatorImpl()
                )
            )
        )
        return viewController
    }
}
