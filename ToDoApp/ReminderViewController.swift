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
        let newRowIndex = reminder.items.count
        reminder.items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ReminderItem) {
        if let index = reminder.items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                let label = cell.viewWithTag(1000) as! UILabel
                label.text = item.text
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    var reminder: Reminder!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = reminder.name
    }

    // MARK: TableView Delegate Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminder.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderItem", for: indexPath)
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = reminder.items[indexPath.row].text
        configureCheckMark(for: cell, at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = reminder.items[indexPath.row]
            item.toggleChecked()
            configureCheckMark(for: cell, at: indexPath)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        reminder.items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    func configureCheckMark(for cell: UITableViewCell, at indexPath: IndexPath) {
        let item = reminder.items[indexPath.row]
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.isHidden = false
        } else {
            label.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = reminder.items[indexPath.row]
            }
        }
    }
}

