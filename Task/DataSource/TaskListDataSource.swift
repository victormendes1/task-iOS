//
//  TaskListDataSource.swift
//  Task
//
//  Created by Victor Mendes on 10/09/21.
//

import UIKit

class TaskListDataSource: NSObject {
    
    var itemsCompleted: [Task] = [
        Task(title: "Evento Apple", date: Date().addingTimeInterval(800.0), notes: "Evento na terça-feita", isComplete: true, completedWhen: Date())!,
        Task(title: "Comprar chocolate", date: Date().addingTimeInterval(800.0), notes: "mais tarde", isComplete: true, completedWhen: Date())!,
        Task(title: "Almoço", date: Date().addingTimeInterval(800.0), notes: "mais tarde", isComplete: true, completedWhen: Date())!,
        Task(title: "Hallowen na Yollanda", date: Date().addingTimeInterval(800.0), notes: "mais tarde", isComplete: true, completedWhen: Date())!,
        Task(title: "Abastecer carro", date: Date().addingTimeInterval(800.0), notes: "mais tarde", isComplete: true, completedWhen: Date())!
    ] {
        didSet {
            print("Salvando")
            TaskAccessObject.saveTasks(tasks: itemsCompleted, done: true)
        }
    }
    
    var items = [
        Task(title: "Evento Apple", date: Date().addingTimeInterval(800.0), notes: "Evento na terça-feita", isComplete: false, completedWhen: Date())!,
        Task(title: "Comprar chocolate", date: Date().addingTimeInterval(800.0), notes: "mais tarde", isComplete: false, completedWhen: Date())!,
        Task(title: "Almoço", date: Date().addingTimeInterval(800.0), notes: "mais tarde", isComplete: false, completedWhen: Date())!,
        Task(title: "Hallowen na Yollanda", date: Date().addingTimeInterval(800.0), notes: "mais tarde", isComplete: false, completedWhen: Date())!,
        Task(title: "Abastecer carro", date: Date().addingTimeInterval(800.0), notes: "mais tarde", isComplete: false, completedWhen: Date())!
    ]
    
    init(_ update: (() -> Void)? = nil ) {
        if let completion = update {
            completion()
        }
        super.init()
    }
    
    func add(_ item: Task) {
        items.append(item)
    }
    
    func updateData(tableView: UITableView) {
        tableView.performBatchUpdates({
            tableView.reloadData()
        }, completion: nil)
    }
    
    func task(at: Int) -> Task {
        items[at]
    }
    
    func tasks() -> [Task] {
        items
    }
    
}

extension TaskListDataSource: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskListTableViewCell = tableView.dequeueReusableCell(indexPath)
        let item = items[indexPath.row]
        
        cell.configure(item) {
            item.isComplete.toggle()
            tableView.reloadData()
        }
        return cell
    }
}
