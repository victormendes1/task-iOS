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
        if task == nil {
            task = Task(title: "", date: Date(), notes: "", isComplete: false, completedWhen: Date())
        } else {
            let _ = configureShowTasDetail()
        }
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
    
    func configureShowTasDetail() -> Bool {
        guard let _task = task else { return false }
        titleField.text = _task.title
        datePicker.date = _task.date
        notesView.text = _task.notes
        return true
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
