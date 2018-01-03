//
//  PiyoView.swift
//  Kuri
//
//  Created by hiroseyuudai on 2018/1/3.
//  Copyright © 2018 hiroseyuudai. All rights reserved.
//

import UIKit

protocol PiyoView: class {
    
}

class PiyoTableViewController: UIViewController {
    
    private var presenter: PiyoPresenter!
    @IBOutlet weak var tableView: UITableView!
    
    func inject(
        presenter: PiyoPresenter
        ) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "PiyoTableViewCell", bundle: nil), forCellReuseIdentifier: "PiyoTableViewCell")
        
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}

extension PiyoTableViewController: PiyoView {
    
}

extension PiyoTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PiyoTableViewCell") as! PiyoTableViewCell
        cell.textLabel?.text = "section: \(indexPath.section), row: \(indexPath.row)"
        return cell
    }
}

extension PiyoTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section), row: \(indexPath.row)")
    }
}
