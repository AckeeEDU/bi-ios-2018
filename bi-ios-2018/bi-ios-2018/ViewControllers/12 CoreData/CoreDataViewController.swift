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
        
        insertUsersIfNeeded()
        
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
        
        alertController.addTextField { textField in
            textField.placeholder = "Komu"
        }
        
        let addAction = UIAlertAction(title: "Přidat", style: .default) { _ in
            guard
                let name = alertController.textFields?.first?.text,
                let userName = alertController.textFields?[1].text
            else { return }
            DB.shared.performBackgroundTask { context in
                let request: NSFetchRequest<Person> = Person.fetchRequest()
                request.predicate = NSPredicate(format: "name = %@", userName)
                request.fetchLimit = 1
                let result = try! context.fetch(request)
                
                guard let user = result.first else { assertionFailure(); return }
                
                let gift = Gift(context: context)
                gift.name = name
                gift.user = user
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
            NSSortDescriptor(key: "user.name", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:))),
            NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        ]
        
        let resultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: DB.shared.mainContext,
            sectionNameKeyPath: "user.name",
            cacheName: nil
        )
        resultsController.delegate = self
        self.resultsController = resultsController
    }
    
    private func insertUsersIfNeeded() {
        let key = "users_inserted" // best practice je mít klíč definovaný jednou a jednom místě
        guard !UserDefaults.standard.bool(forKey: key) else { return }
        
        DB.shared.performBackgroundTask { context in
            let names = ["Jana", "Pavel", "Anna", "Lukáš", "Petra", "Petr"]
            var users: [Person] = []
            for name in names {
                let user = Person(context: context)
                user.name = name
                users.append(user)
            }
            try! context.save()
            UserDefaults.standard.setValue(true, forKey: key)
        }
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
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "subtitle")
        cell.textLabel?.text = gift.name
        cell.detailTextLabel?.text = gift.user?.name
        cell.accessoryType = gift.type == "Zakoupeno" ? .checkmark : .none
        
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
                    try context.save()
                } catch {
                    print("[ERROR]", error.localizedDescription)
                }
            }
        }
        alertController.addAction(okAction)
        
        alertController.addAction(UIAlertAction(title: "Zrušit", style: .cancel))
        
        present(alertController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete, let giftName = resultsController.object(at: indexPath).name else { return }
        
        let request: NSFetchRequest<Gift> = Gift.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", giftName)
        request.fetchLimit = 1
        
        DB.shared.performBackgroundTask { context in
            let result = try! context.fetch(request)
            if let objectToDelete = result.first {
                context.delete(objectToDelete)
            }
            try! context.saveIfNeeded()
        }
        
    }
    
}

extension CoreDataViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
}
