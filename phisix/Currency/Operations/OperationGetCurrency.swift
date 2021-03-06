//
//  OperationGetCurrency.swift
//  phisix
//
//  Created by Рамиз Кичибеков on 16.04.2018.
//  Copyright © 2018 Рамиз Кичибеков. All rights reserved.
//

import UIKit
import phisixKit

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
            for stock in stocks {
                guard
                    let symbol = stock["symbol"] as? String,
                    let name = stock["name"] as? String,
                    let volume = stock["volume"] as? Int,
                    let price = stock["price"] as? [String: Any],
                    let amount = price["amount"] as? Double else {
                    return
                }
                let currency = Currency(symbol,
                                        name: name,
                                        volume: volume,
                                        amount: amount)
                let currencyEntity = CurrencyEntity.createOrUpdate(withCurrency: currency)
                if !UserDefaults.isIndexed {
                    guard let model = currencyEntity else {
                        return
                    }
                    SpotlightManager.setDataForDisplay(with: model.name,
                                                       contentDescription: "Volume: \(model.volume) Amount: \(model.amount)",
                                                       keywords: nil,
                                                       creationDate: nil,
                                                       url: nil,
                                                       keyID: model.symbol,
                                                       completionHandler: { (error) in
                                                        guard let error = error else {
                                                            return
                                                        }
                                                        print("Spotlight Error = \(error.localizedDescription)")
                    })
                }
            }
            guard let completionBlock = self.completionBlock else {
                return
            }
            completionBlock()
        }
    }
    
}
