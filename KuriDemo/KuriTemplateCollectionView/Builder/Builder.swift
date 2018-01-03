//
//  __PREFIX__Builder.swift
//  Kuri
//
//  Created by __USERNAME__ on __DATE__.
//  Copyright © __YEAR__ __USERNAME__. All rights reserved.
//

import UIKit

protocol __PREFIX__Builder {
    func build() -> UIViewController
}


struct __PREFIX__BuilderImpl: __PREFIX__Builder {
    func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "__PREFIX__CollectionViewController", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! __PREFIX__CollectionViewController
        viewController.inject(
            presenter: __PREFIX__PresenterImpl(
                view: viewController,
                wireframe: __PREFIX__WireframeImpl(
                    viewController: viewController
                ),
                useCase: __PREFIX__UseCaseImpl(
                    repository: __PREFIX__RepositoryImpl (
                        dataStore: __PREFIX__DataStoreImpl()
                    ),
                    translator: __PREFIX__TranslatorImpl()
                )
            )
        )
        return viewController
    }
}

