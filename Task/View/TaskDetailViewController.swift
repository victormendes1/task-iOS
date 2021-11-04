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
    
    var task: Task?
    var handler: ((Task) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.task = Task(title: "", date: Date(), notes: "", isComplete: false)
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
    
    private func convertDate(_ date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        let dateRevert = formatter.date(from: date)!
        let date = reverseDate(dateRevert.description)
        return date.description
    }
    
    private func reverseDate(_ date: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let date = formatter.date(from: date)!
        return date
    }
}
