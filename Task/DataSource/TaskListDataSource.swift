//
//  TaskListDataSource.swift
//  Task
//
//  Created by Victor Mendes on 10/09/21.
//

import UIKit

class TaskListDataSource: NSObject {
    typealias CompletedAction = (Int) -> Void
    typealias DeletedAction = () -> Void
    typealias ChangedAction = () -> Void
    
    private var tasks: [Task] = [
        Task(title: "Evento Apple", date: Date().addingTimeInterval(800.0), notes: "Evento na terça-feita", isComplete: false)!,
        Task(title: "Comprar chocolate", date: Date().addingTimeInterval(800.0), notes: "mais tarde", isComplete: false)!
    ] {
        didSet {
            print("Nova tarefa")
        }
    }
    
    private var taskCompletedAction: ChangedAction?
    private var taskDeletedAction: DeletedAction?
    private var taskChangeAction: ChangedAction?
    
    init(taskCompletedAction: @escaping CompletedAction, taskChangeAction: @escaping ChangedAction) {
        self.taskCompletedAction = taskChangeAction
        self.taskChangeAction = taskChangeAction
        super.init()
    }
    
    func task(at row: Int) -> Task {
        return tasks[row]
    }
    
    func add(_ task: Task) {
        tasks.insert(task, at: 0)
        print(task.title)
        
    }
    
    func update(_ task: Task, at row: Int) {
        tasks[row] = task
        // saveTasks()
    }
    
    func delete(at row: Int, _ completion: ((Bool) -> Void)?) {
        tasks.remove(at: row)
    }
    
    func delete(at index: Int, enable: Bool, tableView: UITableView) {
        if enable {
            tasks.remove(at: index)
            print(index)
            tableView.reloadData()
        }
    }
    
    func index(at: Int) {
        
    }
}

extension TaskListDataSource: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskListTableViewCell = tableView.dequeueReusableCell(indexPath)
        let item = task(at: indexPath.row)
        
        cell.configure(item) {
            print("alterando... \(item.isComplete)")
            item.isComplete.toggle()
        }
        return cell
    }
}
