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
    private var resultsController: NSFetchedResultsController<Gift>!
    
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonItem(_:)))
        
        tableView.dataSource = self
        
        setupFetchedResultsController()
        try? resultsController.performFetch()
    }
    
    // MARK: - Actions
    
    @objc
    private func addBarButtonItem(_ sender: UIBarButtonItem) {
        
        DB.shared.performBackgroundTask { context in
            var gifts: [Gift] = []
            for i in 0...100 {
                let gift = Gift(context: context)
                gift.name = "Gift \(i)"
                gifts.append(gift)
            }
            try! context.save()
        }
    }
    
    // MARK: - Helpers
    
    private func setupFetchedResultsController() {
        let request: NSFetchRequest<Gift> = Gift.fetchRequest()
        
        request.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        ]
        
        let resultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: DB.shared.mainContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        resultsController.delegate = self
        self.resultsController = resultsController
    }
    
}

extension CoreDataViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return resultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gift = resultsController.object(at: indexPath)
        
        let cell = UITableViewCell()
        cell.textLabel?.text = gift.name
        
        return cell
    }
    
}

extension CoreDataViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
}
