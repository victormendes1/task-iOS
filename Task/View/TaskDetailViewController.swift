//
//  DetailViewController.swift
//  Task
//
//  Created by Victor Mendes on 11/08/21.
//

import UIKit

class TaskDetailViewController: UITableViewController {
    typealias Action = (Task) -> Void
    
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var titleField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var notesView: UITextView!
    
    var task: Task?
   // private var tempTask: Task?
    private var dataSource: TaskListDataSource?
    private var taskAddAction: Action?
    private var taskEditAction: Action?
    private var isNew = false
    
    func configure(task: Task, isNew: Bool = false, addAction: Action? = nil, editAction: Action? = nil) {
        self.task = task
        self.isNew = isNew
        self.taskAddAction = addAction
        self.taskEditAction = editAction
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.text = task?.title
        notesView.text = task?.notes
    }
    
    func addNewTask(task: Task) {
        task.title = titleField.text!
        task.date = datePicker.date
        task.notes = notesView.text
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if let task = task {
            addNewTask(task: task)
        }
        
        dataSource = TaskListDataSource(taskCompletedAction: {_ in }, taskChangeAction: {}, takeTask: { self.task! })
        
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
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

/*
 fileprivate func changingToViewMode(_ task: Task) {
     if isNew {
        let addTask = tempTask ?? task
         dismiss(animated: true) {
             self.taskAddAction?(addTask)
         }
         return
     }
     if let tempTask = tempTask {
         self.task = tempTask
         self.tempTask = nil
         taskEditAction?(tempTask)
         //dataSource = TaskDetailViewDataSource(task: tempTask)
     } else {
        // dataSource = TaskDetailViewDataSource(task: task)
     }
     navigationItem.title = "View Task"
     navigationItem.leftBarButtonItem = nil
     editButtonItem.isEnabled = true
 }
 
 fileprivate func changingToEditMode(_ task: Task) {
    // dataSource = TaskDetailViewDataSource(task: task) {
         
     }
 
 override func setEditing(_ editing: Bool, animated: Bool) {
     super.setEditing(editing, animated: animated)
     guard let task = task else {
         fatalError("No task found")
     }
     if editing {
         changingToEditMode(task)
     } else {
         changingToViewMode(task)
     }
 }
 
 */
