//
//  TasksDoneViewController.swift
//  Tarefas
//
//  Created by Victor Mendes on 14/04/21.
//

import UIKit

class TasksDoneViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupView()
      
    }
    
    func setupView() {
        
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TaskCompletedCell", bundle: nil), forCellReuseIdentifier: "cellTaskDone")
    }
    
}

extension TasksDoneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskDone", for: indexPath) as! TaskCompletedCell
        cell.titleTextFiel.text = tasks[indexPath.row].title
        return cell
    }
}
// MARK: - Protocol
extension TasksDoneViewController: TaskDataDelegate {
    func addTask(newTask: Task) {
        self.tasks.append(newTask)
        self.tableView.reloadData()
    }
}
