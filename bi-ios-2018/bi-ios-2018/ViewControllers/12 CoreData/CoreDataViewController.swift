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
        tableView.delegate = self
        
        setupFetchedResultsController()
        try? resultsController.performFetch()
    }
    
    // MARK: - Actions
    
    @objc
    private func addBarButtonItem(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Nový dárek", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Název dárku"
        }
        
        let addAction = UIAlertAction(title: "Přidat", style: .default) { _ in
            guard let name = alertController.textFields?.first?.text else { return }
            DB.shared.performBackgroundTask { context in
                let gift = Gift(context: context)
                gift.name = name
                do {
                    try context.saveIfNeeded()
                } catch {
                    print("[ERROR]", error.localizedDescription)
                }
            }
        }
        alertController.addAction(addAction)
        
        alertController.addAction(UIAlertAction(title: "Zrušit", style: .cancel))
        
        present(alertController, animated: true)
    }
    
    // MARK: - Helpers
    
    private func setupFetchedResultsController() {
        let request: NSFetchRequest<Gift> = Gift.fetchRequest()
        
        request.sortDescriptors = [
            NSSortDescriptor(key: "type", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:))),
            NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        ]
        
        let resultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: DB.shared.mainContext,
            sectionNameKeyPath: "type",
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

extension CoreDataViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return resultsController.sections?[section].name
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Zakoupený dárek", message: "Opravdu mám přidat dárek na seznam zakoupených?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let giftName = self?.resultsController.object(at: indexPath).name else { return }
            DB.shared.performBackgroundTask { context in
                
                let request: NSFetchRequest<Gift> = Gift.fetchRequest()
                request.predicate = NSPredicate(format: "name = %@", giftName)
                request.fetchLimit = 1
                
                do {
                    let result = try context.fetch(request)
                    result.first?.type = "Zakoupeno"
                    try context.saveIfNeeded()
                } catch {
                    print("[ERROR]", error.localizedDescription)
                }
            }
        }
        alertController.addAction(okAction)
        
        alertController.addAction(UIAlertAction(title: "Zrušit", style: .cancel))
        
        present(alertController, animated: true)
    }
    
}

extension CoreDataViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
}
