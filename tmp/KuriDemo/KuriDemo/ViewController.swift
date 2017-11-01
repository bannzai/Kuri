//
//  ViewController.swift
//  KuriDemo
//
//  Created by kingkong999yhirose on 2016/12/24.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        present(KuriBuilderImpl().build(), animated: true, completion: nil)
    }
}

