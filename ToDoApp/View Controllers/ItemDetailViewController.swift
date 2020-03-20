//
//  ItemDetailViewControllerTableViewController.swift
//  ToDoApp
//
//  Created by Sarp Ozturk on 6.03.2020.
//  Copyright © 2020 Sarp Ozturk. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ReminderItem)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ReminderItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var shouldRemindSwitch: UISwitch!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    var itemToEdit: ReminderItem?
    var dueDate = Date()
    
    weak var delegate: ItemDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        textField.becomeFirstResponder()
        
        if let itemToEdit = itemToEdit {
            navigationItem.title = "Edit Item"
            textField.text = itemToEdit.text
            doneButton.isEnabled = true
            shouldRemindSwitch.isOn = itemToEdit.shouldRemind
            dueDate = itemToEdit.dueDate
        }
        updateDueDateLabel()
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // MARK: Textfield Delegate Method
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let textRange = Range(range, in: oldText)! // convert to swift range from obj-c
        let newText = oldText.replacingCharacters(in: textRange, with: string)
        
        if newText.isEmpty {
            doneButton.isEnabled = false
        } else {
            doneButton.isEnabled = true
        }
        return true
    }
    
    // MARK: Actions
    @IBAction func cancel() {
        delegate?.itemDetailViewControllerDidCancel(self)
    }

    @IBAction func done() {
        if let item = itemToEdit {
            item.text = textField.text!
            item.dueDate = dueDate
            item.shouldRemind = shouldRemindSwitch.isOn
            delegate?.itemDetailViewController(self, didFinishEditing: item)
        } else {
            let item = ReminderItem()
            item.text = textField.text!
            item.dueDate = dueDate
            item.shouldRemind = shouldRemindSwitch.isOn
            delegate?.itemDetailViewController(self, didFinishAdding: item)
        }
    }
    
    // MARK: Date
    func updateDueDateLabel() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dueDateLabel.text = dateFormatter.string(from: dueDate)
    }
}
