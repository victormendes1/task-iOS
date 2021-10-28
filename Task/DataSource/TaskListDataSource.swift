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
    
    private func saveTasks() {
        do {
            let savedData = try NSKeyedArchiver.archivedData(withRootObject: tasks, requiringSecureCoding: false)
            try savedData.write(to: Task.archiveURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func loadTasks() -> [Task]? {
        var taskLoaded = [Task]()
        do {
            let data = try Data(contentsOf: Task.archiveURL)
            taskLoaded = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [Task]
        } catch {
            print(error.localizedDescription)
        }
        return taskLoaded
    }
}

extension TaskListDataSource: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskListTableViewCell = tableView.dequeueReusableCell(indexPath)
        let item = task(at: indexPath.row)
        cell.configure(title: item.title) {
            item.isComplete.toggle()
            self.delete(at: indexPath.row, enable: item.isComplete, tableView: tableView)
            return item.isComplete
        }
        return cell
    }
}



/*
 let imageButton = task.isComplete ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
 cell.titleLabel.text = tasks[indexPath.row].title
 cell.dateLabel.text = tasks[indexPath.row].date?.description
 cell.doneButton.setBackgroundImage(imageButton, for: .normal)
 cell.doneButtonAction = {
 self.tasks[indexPath.row].isComplete.toggle()
 tableView.reloadRows(at: [indexPath], with: .none)
 */
