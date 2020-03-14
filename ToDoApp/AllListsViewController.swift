//
//  AllListsViewController.swift
//  ToDoApp
//
//  Created by Sarp Ozturk on 11.03.2020.
//  Copyright © 2020 Sarp Ozturk. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController {
    
    let cellIdentifier = "ReminderCell"
    var lists = [Reminder]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        var list = Reminder(name: "Development")
        lists.append(list)
        
        list = Reminder(name: "Master")
        lists.append(list)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = lists[indexPath.row].name
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reminder = lists[indexPath.row]
        performSegue(withIdentifier: "ShowReminder", sender: reminder)
    }
    
    // Passing the data happens here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowReminder" {
            let controller = segue.destination as! ReminderViewController
            controller.reminder = sender as? Reminder
        }
    }
}
