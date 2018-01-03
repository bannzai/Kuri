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
        
        collectionView.register(UINib(nibName: "FugaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FugaCollectionViewCell")
        
        collectionView.dataSource = self
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
            
        }
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
}

extension FugaCollectionViewController: FugaView {
    
}

extension FugaCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FugaCollectionViewCell", for: indexPath) as! FugaCollectionViewCell
        return cell
    }
}

extension FugaCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("section: \(indexPath.section), item: \(indexPath.item)")
    }
}
