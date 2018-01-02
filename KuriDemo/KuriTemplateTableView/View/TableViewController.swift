//
//  __PREFIX__View.swift
//  Kuri
//
//  Created by __USERNAME__ on __DATE__.
//  Copyright © __YEAR__ __USERNAME__. All rights reserved.
//

import UIKit

protocol __PREFIX__View: class {
    
}


class __PREFIX__TableViewController: UIViewController {
    
    private var presenter: __PREFIX__Presenter!
    @IBOutlet weak var tableView: UITableView!
    
    func inject(
        presenter: __PREFIX__Presenter
        ) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension __PREFIX__ViewController: __PREFIX__View {
    
}
