//
//  __PREFIX__View.swift
//  Kuri
//
//  Created by __USERNAME__ on __DATE__.
//  Copyright © __YEAR__ __USERNAME__. All rights reserved.
//

import UIKit

class __PREFIX__View: UIViewController {
    
    private var presenter: __PREFIX__Presenter!
    
    func inject(
        presenter: __PREFIX__Presenter
        ) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension __PREFIX__View: __PREFIX__ViewOutput {
    
}
