//
//  ReminderItem.swift
//  ToDoApp
//
//  Created by Sarp Ozturk on 4.03.2020.
//  Copyright © 2020 Sarp Ozturk. All rights reserved.
//

import Foundation

class ReminderItem: NSObject, Codable {
    var text = ""
    var checked = false
    var dueDate = Date()
    var shouldRemind = false
    var itemID = -1
    
    override init() {
        super.init()
        itemID = DataModel.generateReminderItemID()
    }
    func toggleChecked() {
        checked = !checked
    }
}
