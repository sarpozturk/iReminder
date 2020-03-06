//
//  ViewController.swift
//  ToDoApp
//
//  Created by Sarp Ozturk on 2.03.2020.
//  Copyright © 2020 Sarp Ozturk. All rights reserved.
//

import UIKit

class ReminderViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ReminderItem) {
        navigationController?.popViewController(animated: true)
        
    }
    
    
    var items = [ReminderItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item0 = ReminderItem()
        item0.text = "item 1"
        items.append(item0)
        
        let item1 = ReminderItem()
        item1.text = "item 2"
        item1.checked = true
        items.append(item1)
    }

    // MARK: TableView Delegate Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderItem", for: indexPath)
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = items[indexPath.row].text
        configureCheckMark(for: cell, at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckMark(for: cell, at: indexPath)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    func configureCheckMark(for cell: UITableViewCell, at indexPath: IndexPath) {
        let item = items[indexPath.row]
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    // MARK: Functionality
    @IBAction func addItem() {
        let newRowIndex = items.count
        let item = ReminderItem()
        item.text = "new item"
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
        }
    }

}

