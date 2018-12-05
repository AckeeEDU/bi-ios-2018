//
//  NetowrkTableView.swift
//  bi-ios-2018
//
//  Created by Dominik Vesely on 04/12/2018.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import Foundation
import UIKit

class NetworkTableViewController : UIViewController {
    
    weak var tableView : UITableView!
    var dataManager = DataManager()
    var data = [Recipe]()

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nil);
        self.title = "Table"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView();
        view.backgroundColor = .white
        
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(RecipeTableCell.self, forCellReuseIdentifier: "Cell")
        table.tableFooterView = UIView()
        view.addSubview(table)
        
        table.snp.makeConstraints { (make) in
            make.size.equalTo(view)
        }
        
        tableView = table
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dataManager.getReipes { [weak self] recipes in
            self?.data = recipes
            self?.tableView.reloadData()
        }

    }
    
    
}

//MARK: UITableView data source
extension NetworkTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecipeTableCell
        cell.recipe = data[indexPath.row]
        
        return cell
    }
    
    
}

//MARK: UITableView delegate
extension NetworkTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        return
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
