//
//  UIResponder+Thread.swift
//  phisix
//
//  Created by Рамиз Кичибеков on 16.04.2018.
//  Copyright © 2018 Рамиз Кичибеков. All rights reserved.
//

import UIKit

extension UIResponder {
    
    func executeOnMainThread(_ completion: @escaping () -> ()) {
        if Thread.isMainThread {
            completion()
        } else {
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
