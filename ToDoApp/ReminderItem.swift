//
//  ReminderItem.swift
//  ToDoApp
//
//  Created by Sarp Ozturk on 4.03.2020.
//  Copyright © 2020 Sarp Ozturk. All rights reserved.
//

import Foundation

class ReminderItem {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}
