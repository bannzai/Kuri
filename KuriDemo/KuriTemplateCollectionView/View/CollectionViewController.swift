//
//  __PREFIX__CollectionViewController.swift
//  Kuri
//
//  Created by __USERNAME__ on __DATE__.
//  Copyright © __YEAR__ __USERNAME__. All rights reserved.
//
import UIKit

protocol __PREFIX__View: class {
    
}

class __PREFIX__CollectionViewController: UIViewController {
    
    private var presenter: __PREFIX__Presenter!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func inject(
        presenter: __PREFIX__Presenter
        ) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "__PREFIX__CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "__PREFIX__CollectionViewCell")
        
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

extension __PREFIX__CollectionViewController: __PREFIX__View {
    
}

extension __PREFIX__CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "__PREFIX__CollectionViewCell", for: indexPath) as! __PREFIX__CollectionViewCell
        return cell
    }
}

extension __PREFIX__CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("section: \(indexPath.section), item: \(indexPath.item)")
    }
}
