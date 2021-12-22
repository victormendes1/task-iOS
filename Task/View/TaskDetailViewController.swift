//
//  DetailViewController.swift
//  Task
//
//  Created by Victor Mendes on 11/08/21.
//

import UIKit
import RxSwift
import RxCocoa

class TaskDetailViewController: UITableViewController {
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var titleField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var notesView: UITextView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var task: Task?
    var handler: ((Task) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.becomeFirstResponder()
        self.task = Task(title: "", date: Date(), notes: "", isComplete: false, completedWhen: Date())
    }
    
    
    func createNewTask() -> Task? {
        guard let item = task else { return nil }
        item.date = datePicker.date
        item.notes = notesView.text
        item.date = datePicker.date
        item.isComplete = false
        if let title = titleField.text {
            item.title = title
        }
        appDelegate.scheduleLocalNotification(item)
        return item
    }
    
    @IBAction func saveTask(_ sender: Any) {
        if let item = createNewTask() {
            handler?(item)
            }
            dismiss(animated: true, completion: nil)
        }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
