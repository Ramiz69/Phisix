//
//  DataStore.swift
//  phisix
//
//  Created by Рамиз Кичибеков on 16.04.2018.
//  Copyright © 2018 Рамиз Кичибеков. All rights reserved.
//

import Foundation

final class DataStore {
    
    public class var localDataBase: CoreDataManager {
        return CoreDataManager.shared
    }
    
    public class func saveDataBase() {
        CoreDataManager.shared.saveContext()
    }
    
    public class func saveMainDataBase() {
        CoreDataManager.shared.saveMainContext()
    }
}
