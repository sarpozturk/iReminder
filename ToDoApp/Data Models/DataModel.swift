//
//  DataModel.swift
//  ToDoApp
//
//  Created by Sarp Ozturk on 15.03.2020.
//  Copyright © 2020 Sarp Ozturk. All rights reserved.
//

import Foundation

class DataModel {
    var lists = [Reminder]()
    
    var selectedReminderIndex: Int {
        get {
            return UserDefaults.standard.integer(forKey: "ReminderIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "ReminderIndex")
        }
    }
    
    init() {
        loadReminders()
        registerInitDefault()
        handleFirstTime()
    }
    
    // MARK: - Saving Data
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("ToDoApp.plist")
    }
    
    func saveReminders() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(lists)
            try data.write(to: dataFilePath(), options: .atomic)
            
        } catch {
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    
    func loadReminders() {
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                lists = try decoder.decode([Reminder].self, from: data)
            } catch {
                print("Error encoding item array: \(error.localizedDescription)")
            }
        }
    }
    
    func registerInitDefault() {
        let dictionary = ["ReminderIndex": -1, "isFirstTime": true] as [String : Any]
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    func handleFirstTime() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "isFirstTime")
        if firstTime {
            let reminder = Reminder(name: "List")
            lists.append(reminder)
            selectedReminderIndex = 0
            userDefaults.set(false, forKey: "isFirstTime")
        }
    }
}
