//
//  CurrencyViewController.swift
//  phisix
//
//  Created by Рамиз Кичибеков on 16.04.2018.
//  Copyright © 2018 Рамиз Кичибеков. All rights reserved.
//

import UIKit
import CoreData

class CurrencyViewController: UIViewController {
    
    @IBOutlet weak public var tableView: UITableView!
    
    public lazy var fetchedResultsController: NSFetchedResultsController = { () -> NSFetchedResultsController<CurrencyEntity> in
        let context = DataStore.localDataBase.managedObjectContext
        let entityDescription = NSEntityDescription.entity(forEntityName: String(describing: CurrencyEntity.self),
                                                           in: context)
        let sortDescription = NSSortDescriptor(key: "name", ascending: true)
        let request = NSFetchRequest<CurrencyEntity>()
        request.entity = entityDescription
        request.sortDescriptors = [sortDescription]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                                  managedObjectContext: context,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
    }
    
    //MARK: - Custom methods
    
    private func configureController() {
        tableView.register(UINib(nibName: String(describing: CurrencyTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: CurrencyTableViewCell.reuseIdentifier)
        tableView.rowHeight = 50
        let operation = OperationGetCurrency(with: .stocks)
        title = operation.contentType.description
        operation.completionBlock = {
            
        }
        initialFetchedResultsController()
    }
    
    private func initialFetchedResultsController() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Fetched error = \(error.localizedDescription)")
        }
    }

}

