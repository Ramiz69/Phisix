//
//  CurrencyTableViewCell.swift
//  phisix
//
//  Created by Рамиз Кичибеков on 16.04.2018.
//  Copyright © 2018 Рамиз Кичибеков. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "CurrencyCell"
    
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var volumeLabel: UILabel!
    @IBOutlet weak private var amountLabel: UILabel!
    
    override func prepareForReuse() {
        nameLabel.text = nil
        volumeLabel.text = nil
        amountLabel.text = nil
    }
    
    public func configureCell(with currency: CurrencyEntity) {
        nameLabel.text = currency.name
        volumeLabel.text = "Volume: \(currency.volume)"
        amountLabel.text = String(format: "Amount: %.02f", currency.amount)
    }
    
}
