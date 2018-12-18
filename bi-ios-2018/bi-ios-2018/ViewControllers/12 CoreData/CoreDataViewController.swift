//
//  CoreDataViewController.swift
//  bi-ios-2018
//
//  Created by Lukáš Hromadník on 18.12.18.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import UIKit
import CoreData

final class CoreDataViewController: UIViewController {
    
    private weak var tableView: UITableView!
    
    // MARK: - Controller lifecycle
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.tableView = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "CoreData"
        
        tableView.dataSource = self
    }
    
}

extension CoreDataViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Cell \(indexPath.row + 1)"
        
        return cell
    }
    
}
