//
//  PiyoWireframe.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import UIKit

protocol PiyoWireframe: class {
    
}


class PiyoWireframeImpl: PiyoWireframe {
    private weak var viewController: UIViewController!
    
    init(
        viewController: UIViewController
        ) {
        self.viewController = viewController
    }
}