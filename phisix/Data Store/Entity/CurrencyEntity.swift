//
//  CurrencyEntity.swift
//  phisix
//
//  Created by Рамиз Кичибеков on 16.04.2018.
//  Copyright © 2018 Рамиз Кичибеков. All rights reserved.
//

import Foundation
import CoreData

@objc(CurrencyEntity)
final class CurrencyEntity: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var volume: Int
    @NSManaged var amount: Double
    
    public class func createOrUpdate(withCurrency currency: Currency, context: NSManagedObjectContext = DataStore.localDataBase.managedObjectContext) -> CurrencyEntity? {
        var currencyEntity: CurrencyEntity? = .none
        let predicate = NSPredicate(format: "name contains[c] %@", currency.name as CVarArg)
        currencyEntity = findOrCreateWith(context, predicate: predicate) as? CurrencyEntity
        currencyEntity?.name = currency.name
        currencyEntity?.volume = currency.volume
        currencyEntity?.amount = currency.amount
        
        DataStore.saveDataBase()
        
        return currencyEntity
    }
    
}
