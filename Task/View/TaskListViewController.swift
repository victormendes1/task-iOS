//
//  TaskListViewController.swift
//  Tarefas
//
//  Created by Victor Mendes on 10/09/21.
//

import UIKit

class TaskListViewController: UITableViewController {
    var items: [Task] = []
    var itemsComplete: [Task] = []
    
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
            let destination = segue.destination as? ReviewTableViewController
            destination?.listTaskComplete = itemsComplete
        }
    }
    
    // MARK: - Actions
    @IBAction func update(_ sender: Any) {
        self.tableView.reloadData()
        print("Atualizando...")
    }
    
    // MARK: - Private Func
    private func configureCell() {
        tableView.register(type: TaskListTableViewCell.self)
        if let tasks = TaskAccessObject.loadTasks(){
            items = tasks
        }
    }
    
    func index(_ item: Task) -> Array<Task>.Index? {
        items.firstIndex(where: { $0.title == item.title})
    }
    
    func add(_ item: Task) {
        items.append(item)
        tableView.reloadData()
    }
    // MARK: - Private Func
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
    
    //MARK: - TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskListTableViewCell = tableView.dequeueReusableCell(indexPath)
        let item = items[indexPath.row]
        
        cell.configure(item) {
            item.isComplete.toggle()
            tableView.reloadData()
            
            if let index = self.index(item) {
                self.itemsComplete.append(item)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.items.remove(at: index)
                    tableView.deleteRows(at:[IndexPath(row: index, section: 0)], with: .fade)
                })
            }
        }
        return cell
    }
}
