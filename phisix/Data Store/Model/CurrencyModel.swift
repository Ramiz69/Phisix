//
//  CurrencyModel.swift
//  phisix
//
//  Created by Рамиз Кичибеков on 16.04.2018.
//  Copyright © 2018 Рамиз Кичибеков. All rights reserved.
//

import Foundation

struct Currency {
    let name: String
    let volume: Int
    let amount: Double
    
    init(_ name: String, volume: Int, amount: Double) {
        self.name = name
        self.volume = volume
        self.amount = amount
    }
}
