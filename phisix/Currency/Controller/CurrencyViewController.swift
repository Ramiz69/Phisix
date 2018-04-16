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
    
    private let refreshControl = UIRefreshControl()
    private var timer: DispatchSourceTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
    }
    
    //MARK: - Custom methods
    
    private func configureController() {
        tableView.register(UINib(nibName: String(describing: CurrencyTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: CurrencyTableViewCell.reuseIdentifier)
        tableView.rowHeight = 50
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(didChangeValueWithRefreshControl(_:)), for: .valueChanged)
        configureTimer()
        initialFetchedResultsController()
    }
    
    private func getData() {
        let operation = OperationGetCurrency(with: .stocks)
        executeOnMainThread { [weak self] in
            self?.title = operation.contentType.description
        }
        operation.completionBlock = {
            self.executeOnMainThread { [weak self] in
                if (self?.refreshControl.isRefreshing)! {
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    private func initialFetchedResultsController() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Fetched error = \(error.localizedDescription)")
        }
    }
    
    private func configureTimer() {
        let queue = DispatchQueue(label: "com.phisix.timer")
        
        timer?.cancel()
        timer = DispatchSource.makeTimerSource(flags: .strict, queue: queue)
        
        timer?.schedule(deadline: .now(), repeating: .seconds(15), leeway: .never)
        
        timer?.setEventHandler(handler: { [weak self] in
            self?.getData()
        })
        
        timer?.resume()
    }
    
    //MARK: - Actions
    
    @objc private func didChangeValueWithRefreshControl(_ sender: UIRefreshControl) {
        getData()
    }

}

