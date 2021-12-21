//
//  TaskListViewController.swift
//  Tarefas
//
//  Created by Victor Mendes on 10/09/21.
//

import UIKit

class TaskListViewController: UITableViewController {
    var items: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCell()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTaskDetailSegue",
           let destination = segue.destination as? TaskDetailViewController,
           let selectedCell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: selectedCell) {
            let rowIndex = indexPath.row
            
            // destination.configure(task: task)
        } else if segue.identifier == "ShowNewTaskSegue" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailVC: TaskDetailViewController = storyboard.instantiateViewController(identifier: "TaskDetailViewController")
            detailVC.handler = { self.add($0) }
            
            let navigationController = UINavigationController(rootViewController: detailVC)
            present(navigationController, animated: true, completion: nil)
        } else if segue.identifier == "ShowReviewSegue" {
            let viewController = TaskDoneTableViewController()
            viewController.delegate = self
        }
    }
    
    func add(_ item: Task) {
        items.append(item)
        saveTasks()
        tableView.reloadData()
    }
    
    // MARK: - Private Functions
    private func configureCell() {
        tableView.register(type: TaskListTableViewCell.self)
        loadTasks()
    }
    
    private func saveTasks() {
        TaskAccessObject.newItems = items
    }
    
    private func loadTasks() {
        if items.isEmpty {
            if let _tasks = TaskAccessObject.loadTasks(done: false) {
                items = _tasks.filter { $0.isComplete == false}
            }
        }
    }
    
    private func index(_ item: Task) -> Int {
        guard let index = items.firstIndex(where: { $0 == item }).map({ Int($0) }) else { return 0 }
        return index
    }
    
    //MARK: - TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskListTableViewCell = tableView.dequeueReusableCell(indexPath)
        let item = items[indexPath.row]
        cell.configure(item) {
            self.saveCompletedTask(item, tableView)
            self.saveTasks()
        }
        return cell
    }
}

// MARK: - Extension
// Responsável de salvar as tarefas pronta
extension TaskListViewController: SaveTaskDelegate {
    func saveCompletedTask(_ task: Task, _ tableView: UITableView) {
        let _index = index(task)
        task.isComplete.toggle()
        task.completedWhen = Date()
        TaskAccessObject.completeItems.append(task)
        items.remove(at:_index)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            tableView.deleteRows(at:[IndexPath(row: _index, section: 0)], with: .fade)
        })
    }
}
