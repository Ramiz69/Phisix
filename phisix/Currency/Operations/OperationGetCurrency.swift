//
//  OperationGetCurrency.swift
//  phisix
//
//  Created by Рамиз Кичибеков on 16.04.2018.
//  Copyright © 2018 Рамиз Кичибеков. All rights reserved.
//

import UIKit

final class OperationGetCurrency: Operation {
    
    public var contentType: ContentType
    
    public init(with contentType: ContentType) {
        self.contentType = contentType
        super.init()
        cancelOperation()
        main()
    }
    
    override func main() {
        cancelOperation()
        CurrencyManager.getCurrency(contentType) { (response, error) in
            guard
                let json = response as? JSON,
                error == nil,
                let stocks = json["stock"] as? [[String: Any]]
                else {
                return
            }
            print("JSON = \(json)")
            for stock in stocks {
                guard
                    let name = stock["name"] as? String,
                    let volume = stock["volume"] as? Int,
                    let price = stock["price"] as? [String: Any],
                    let amount = price["amount"] as? Double else {
                    return
                }
                let currency = Currency(name,
                                        volume: volume,
                                        amount: amount)
                _ = CurrencyEntity.createOrUpdate(withCurrency: currency)
            }
            guard let completionBlock = self.completionBlock else {
                return
            }
            completionBlock()
        }
    }
    
}
