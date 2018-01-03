//
//  ViewController.swift
//  KuriDemo
//
//  Created by Yudai.Hirose on 2018/01/02.
//  Copyright © 2018年 廣瀬雄大. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tableViewButtonPressed(_ sender: Any) {
        let viewController = PiyoBuilderImpl().build()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func collectionViewButtonPressed(_ sender: Any) {
        let viewController = FugaBuilderImpl().build()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

