//
//  TableViewController.swift
//  bi-ios-2018
//
//  Created by Lukáš Hromadník on 20/11/2018.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import UIKit

final class TableViewController: UIViewController {
    
    private weak var tableView: UITableView!
    
    private let data: [User] = [
        User(name: "Eliška", university: "Matfyz"),
        User(name: "Lukáš", university: "ČVUT FEL"),
        User(name: "Honza", university: "ČVUT FIT"),
        User(name: "Jana", university: "ČZU"),
        User(name: "Michal", university: nil)
    ]
    
    // MARK: - Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Controller lifecycle
    
    override func loadView() {
        super.loadView()
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.tableView = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.reuseIdentifier)
    }
    
}

extension TableViewController: UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 10
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = data[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.reuseIdentifier, for: indexPath) as! CustomCell
//        let cell = CustomCell(style: .default, reuseIdentifier: nil)
        cell.title = user.name
        cell.message = user.university
        
        return cell
    }
    
}

extension TableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section + 1)"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
