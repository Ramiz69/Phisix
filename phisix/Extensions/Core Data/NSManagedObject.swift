//
//  NSManagedObject.swift
//  phisix
//
//  Created by Рамиз Кичибеков on 16.04.2018.
//  Copyright © 2018 Рамиз Кичибеков. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    
    class func findOrCreateWith(_ context: NSManagedObjectContext, predicate: NSPredicate) -> NSManagedObject? {
        var object: NSManagedObject? = .none
        object = findObjectWith(context,
                                predicate: predicate,
                                error: nil)
        if object == nil {
            object = NSEntityDescription.insertNewObject(forEntityName: String(describing: self), into: context)
        }
        return object
    }
    
    class func findObjectWith(_ context: NSManagedObjectContext, predicate: NSPredicate, error: Error?) -> NSManagedObject? {
        let fetchRequest = createFetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        var object: NSManagedObject? = .none
        context.performAndWait {
            do {
                object = try context.fetch(fetchRequest).first as? NSManagedObject
            } catch {
                print(error.localizedDescription)
            }
        }
        return object
    }
    
    class func findObjectsWith(_ context: NSManagedObjectContext, predicate: NSPredicate, error: Error?) -> [Any]? {
        let fetchRequest = createFetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        var object: Any? = .none
        context.performAndWait {
            do {
                object = try context.fetch(fetchRequest)
            } catch {
                print(error.localizedDescription)
            }
        }
        return [object!]
    }
    
    class func createFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest(entityName: String(describing: self))
    }
}
