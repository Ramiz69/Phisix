//
//  SettingsTableViewController.swift
//  phisix
//
//  Created by Рамиз Кичибеков on 16.04.2018.
//  Copyright © 2018 Рамиз Кичибеков. All rights reserved.
//

import UIKit
import phisixKit

class SettingsTableViewController: UITableViewController {

    //MARK: - Actions
    
    @IBAction private func didTapClearIndexingButton(_ sender: UIButton) {
        SpotlightManager.deleteAllData()
    }
    
    @IBAction private func didTapSwitchIndexing(_ sender: UISwitch) {
        UserDefaults.didSaveIndexingValue(sender.isOn)
    }

}
