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
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var titleField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var notesView: UITextView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let bag = DisposeBag()
    var task: Task?
    var handler: ((Task) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
        if task == nil {
            task = Task(title: "", date: Date(), notes: "", isComplete: false, completedWhen: Date())
        } else {
            let _ = showTaskDetail()
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
    
    func showTaskDetail() -> Bool {
        guard let _task = task else { return false }
        titleField.text = _task.title
        datePicker.date = _task.date
        notesView.text = _task.notes
        return true
    }
    
    private func configureBindings() {
        saveButton.rx
            .tap
            .subscribe(onNext: {
                if let item = self.createNewTask() {
                    self.handler?(item)
                }
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: bag)
        
        cancelButton.rx
            .tap
            .subscribe(onNext: {
                let isPresentingInAddMode = self.presentingViewController is UINavigationController
                if isPresentingInAddMode {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            })
            .disposed(by: bag)
    }
}
