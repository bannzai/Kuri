//
//  FugaCollectionViewController.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import UIKit

protocol FugaView: class {
    
}


class FugaCollectionViewController: UIViewController {
    
    private var presenter: FugaPresenter!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func inject(
        presenter: FugaPresenter
        ) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FugaViewController: FugaView {
    
}
