//
//  TaskListViewController.swift
//  Tarefas
//
//  Created by Victor Mendes on 10/09/21.
//

import UIKit

class TaskListViewController: UITableViewController {
    
    private var dataSource: TaskListDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(type: TaskListTableViewCell.self)
        
        dataSource = TaskListDataSource(taskCompletedAction: { taskIndex in
            DispatchQueue.main.async {
                self.tableView.reloadRows(at: [IndexPath(row: taskIndex, section: 0)], with: .automatic)
            }
        }, taskChangeAction: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }, takeTask: nil )
        tableView.dataSource = dataSource
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTaskDetailSegue",
           let destination = segue.destination as? TaskDetailViewController,
           let selectedCell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: selectedCell) {
            let rowIndex = indexPath.row
            guard let task = dataSource?.task(at: rowIndex) else {
                fatalError("Couldn't find data source for list.")
            }
            destination.configure(task: task)
        } else if segue.identifier == "ShowNewTaskSegue" {
              addTask()
        }
    }
    
    @IBAction func update(_ sender: Any) {
        print("Atualizando...")
        self.tableView.reloadData()
    }
    @IBAction func unwindToDetail(for: UIStoryboardSegue) {
        
    }
    @IBAction func add(_ sender: UIBarButtonItem) {
        print("AAAAA")
        let task = Task(title: "New Task", date: Date(), notes: "", isComplete: false)!
        dataSource?.add(task)
    }
    
    private func addTask() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController: TaskDetailViewController = storyboard.instantiateViewController(identifier: "TaskDetailViewController")
        let task = Task(title: "New Task", date: Date(), notes: "", isComplete: false)!
        detailViewController.configure(task: task, isNew: true, addAction: { task in
            self.dataSource?.add(task)
        })
        let navigationController = UINavigationController(rootViewController: detailViewController)
        present(navigationController, animated: true, completion: nil)
    }
}

