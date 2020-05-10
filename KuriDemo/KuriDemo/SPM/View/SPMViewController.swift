//
//  SPMViewController.swift
//  Kuri
//
//  Created by yudai-hirose on 2020/5/11.
//  Copyright © 2020 yudai-hirose. All rights reserved.
//

import UIKit

protocol SPMView: class {
    
}


class SPMViewController: UIViewController {
    
    private var presenter: SPMPresenter!
    
    func inject(
        presenter: SPMPresenter
        ) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SPMViewController: SPMView {
    
}
