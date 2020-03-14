//
//  Reminder.swift
//  ToDoApp
//
//  Created by Sarp Ozturk on 11.03.2020.
//  Copyright © 2020 Sarp Ozturk. All rights reserved.
//

import UIKit

class Reminder: NSObject {
    var name = ""
    
    init(name: String) {
        self.name = name
        super.init()
    }
}
