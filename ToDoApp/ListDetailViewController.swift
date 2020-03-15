//
//  ListDetailViewController.swift
//  ToDoApp
//
//  Created by Sarp Ozturk on 14.03.2020.
//  Copyright © 2020 Sarp Ozturk. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate: class {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding reminder: Reminder)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing reminder: Reminder)
    
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: ListDetailViewControllerDelegate?
    
    var reminderToEdit: Reminder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let reminder = reminderToEdit {
            title = "Edit Reminder"
            textField.text = reminder.name
            doneBarButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let reminder = reminderToEdit {
            reminder.name = textField.text!
            delegate?.listDetailViewController(self, didFinishEditing: reminder)
        } else {
            let reminder = Reminder(name: textField.text!)
            delegate?.listDetailViewController(self, didFinishAdding: reminder)
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        doneBarButton.isEnabled = !newText.isEmpty
        return true
    }
}
