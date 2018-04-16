//
//  UIViewController+UIAlertController.swift
//  phisix
//
//  Created by Рамиз Кичибеков on 16.04.2018.
//  Copyright © 2018 Рамиз Кичибеков. All rights reserved.
//

import UIKit

extension UIViewController {
    typealias AlertActionBlock = (UIAlertController) -> ()
    
    func alert(with title: String? = nil, message: String? = nil, actionBlock: AlertActionBlock) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.view.tintColor = view.tintColor
        actionBlock(alertController)
        present(alertController, animated: true, completion: nil)
    }
}
