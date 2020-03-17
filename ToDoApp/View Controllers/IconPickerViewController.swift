//
//  IconPickerViewController.swift
//  ToDoApp
//
//  Created by Sarp Ozturk on 17.03.2020.
//  Copyright © 2020 Sarp Ozturk. All rights reserved.
//

import UIKit

protocol IconPickerViewControllerDelegate: class {
    func iconPickerView(_ picker: IconPickerViewController, didPick iconName: String)
}

class IconPickerViewController: UITableViewController {
    weak var delegate: IconPickerViewControllerDelegate?
    
    let icons = ["No Icon", "Appointments", "Birthdays", "Chores", "Drinks", "Folder", "Inbox", "Photos", "Trips"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)
        cell.imageView?.image = UIImage(named: icons[indexPath.row])
        cell.textLabel?.text = icons[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            let iconName = icons[indexPath.row]
            delegate.iconPickerView(self, didPick: iconName)
        }
    }
}
