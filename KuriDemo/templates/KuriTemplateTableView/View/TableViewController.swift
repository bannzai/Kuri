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
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "__PREFIX__TableViewCell", bundle: nil), forCellReuseIdentifier: "__PREFIX__TableViewCell")
        
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}

extension __PREFIX__TableViewController: __PREFIX__View {
    
}

extension __PREFIX__TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "__PREFIX__TableViewCell") as! __PREFIX__TableViewCell
        cell.textLabel?.text = "section: \(indexPath.section), row: \(indexPath.row)"
        return cell
    }
}

extension __PREFIX__TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section), row: \(indexPath.row)")
    }
}

