//
//  AllListsViewController.swift
//  ToDoApp
//
//  Created by Sarp Ozturk on 11.03.2020.
//  Copyright © 2020 Sarp Ozturk. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding reminder: Reminder) {
        dataModel.lists.append(reminder)
        dataModel.sortReminders()
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing reminder: Reminder) {
        dataModel.sortReminders()
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    
    let cellIdentifier = "ReminderCell"
    var dataModel: DataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = self
        let index = dataModel.selectedReminderIndex
        if index >= 0 && index < dataModel.lists.count {
            let reminder = dataModel.lists[index]
            performSegue(withIdentifier: "ShowReminder", sender: reminder)
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if let c = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            cell = c
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        cell.textLabel!.text = dataModel.lists[indexPath.row].name
        if dataModel.lists[indexPath.row].items.count == 0 {
            cell.detailTextLabel!.text = "(No item)"
        } else {
            let count = dataModel.lists[indexPath.row].countUncheckedReminderItems()
            cell.detailTextLabel!.text = count == 0 ? "All done!" : "\(count) Remaining"
        }
        cell.accessoryType = .detailDisclosureButton
        cell.imageView?.image = UIImage(named: dataModel.lists[indexPath.row].iconName)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        dataModel.lists.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        controller.delegate = self
        let reminder = dataModel.lists[indexPath.row]
        controller.reminderToEdit = reminder
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reminder = dataModel.lists[indexPath.row]
        performSegue(withIdentifier: "ShowReminder", sender: reminder)
        dataModel.selectedReminderIndex = indexPath.row
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // back button is tapped
        if viewController === self {
            dataModel.selectedReminderIndex = -1
        }
    }
    
    // Passing the data happens here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowReminder" {
            let controller = segue.destination as! ReminderViewController
            controller.reminder = sender as? Reminder
        } else if segue.identifier == "AddReminder" {
            let controller = segue.destination as! ListDetailViewController
            controller.delegate = self
        }
    }
}
