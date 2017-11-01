//
//  __VIEW__.swift
//  Kuri
//
//  Created by __USERNAME__ on __DATE__.
//  Copyright © 2016年 __USERNAME__. All rights reserved.
//

import UIKit

class __VIEW__: UIViewController {
    
    private var presenter: __PRESENTER__!
    
    func inject(
        presenter: __PRESENTER__
        ) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension __VIEW__: __VIEW__Output {
    
}