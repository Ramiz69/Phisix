//
//  CoreDataManager.swift
//  phisix
//
//  Created by Рамиз Кичибеков on 16.04.2018.
//  Copyright © 2018 Рамиз Кичибеков. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    public var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static let shared: CoreDataManager = {
        return CoreDataManager()
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "phisix")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private enum EntityType: String {
        case category = "CategoryEntity"
        case music = "MusicEntity"
    }
    
    //MARK: - Private methods
    
    private init() {
        managedObjectContext = persistentContainer.viewContext
    }
    
    private func createRequestOnDataBase(_ entityType: EntityType) -> (context: NSManagedObjectContext, request:  NSFetchRequest<NSFetchRequestResult>) {
        let context = managedObjectContext
        let entityDescription = NSEntityDescription.entity(forEntityName: entityType.rawValue, in: context)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entityDescription
        
        return (context, request)
    }
    
    //MARK: - Public methods
    
    public func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
