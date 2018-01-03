//
//  HogeViewController.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import UIKit

protocol HogeView: class {
    
}


class HogeViewController: UIViewController {
    
    private var presenter: HogePresenter!
    
    func inject(
        presenter: HogePresenter
        ) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HogeViewController: HogeView {
    
}
