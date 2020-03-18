//
//  Reminder.swift
//  ToDoApp
//
//  Created by Sarp Ozturk on 11.03.2020.
//  Copyright © 2020 Sarp Ozturk. All rights reserved.
//

import UIKit

class Reminder: NSObject, Codable {
    var name = ""
    var items = [ReminderItem]()
    var iconName: String
    
    init(name: String, iconName: String = "No Icon") {
        self.name = name
        self.iconName = iconName
        super.init()
    }
    
    func countUncheckedReminderItems() -> Int {
        return items.reduce(0) { count, item
            in count + (item.checked ? 0 : 1)
        }
    }
}
