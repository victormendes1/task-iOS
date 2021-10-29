//
//  TaskListDataSource.swift
//  Task
//
//  Created by Victor Mendes on 10/09/21.
//

import UIKit
import RxSwift
import RxCocoa

class TaskListDataSource: NSObject {
    typealias CompletedAction = (Int) -> Void
    typealias DeletedAction = () -> Void
    typealias ChangedAction = () -> Void
    typealias TakeTask = () -> Task
    var bag = DisposeBag()
    
    static  var test: [Task] = [
        Task(title: "Evento Apple", date: Date().addingTimeInterval(800.0), notes: "Evento na terça-feita", isComplete: false)!,
        Task(title: "Comprar chocolate", date: Date().addingTimeInterval(800.0), notes: "mais tarde", isComplete: false)!
    ]
    var listComplete: [Task] = []
//        Task(title: "Evento Apple", date: Date().addingTimeInterval(800.0), notes: "Evento na terça-feita", isComplete: false)!,
//        Task(title: "Comprar chocolate", date: Date().addingTimeInterval(800.0), notes: "mais tarde", isComplete: false)!,
//        Task(title: "Almoço", date: Date().addingTimeInterval(800.0), notes: "mais tarde", isComplete: false)!,
//        Task(title: "Hallowen na Yollanda", date: Date().addingTimeInterval(800.0), notes: "mais tarde", isComplete: false)!,
//        Task(title: "Abastecer carro", date: Date().addingTimeInterval(800.0), notes: "mais tarde", isComplete: false)!
//
    
    var items: [Task] = [
        Task(title: "Evento Apple", date: Date().addingTimeInterval(800.0), notes: "Evento na terça-feita", isComplete: false)!,
        Task(title: "Comprar chocolate", date: Date().addingTimeInterval(800.0), notes: "mais tarde", isComplete: false)!,
        Task(title: "Almoço", date: Date().addingTimeInterval(800.0), notes: "mais tarde", isComplete: false)!,
        Task(title: "Hallowen na Yollanda", date: Date().addingTimeInterval(800.0), notes: "mais tarde", isComplete: false)!,
        Task(title: "Abastecer carro", date: Date().addingTimeInterval(800.0), notes: "mais tarde", isComplete: false)!
    ] { didSet {
        print("Alteração - \(items.count)")
    } }
    
    private var tasks = BehaviorRelay<[Task]>(value: test)
    
    private var taskCompletedAction: ChangedAction?
    private var taskDeletedAction: DeletedAction?
    private var taskChangeAction: ChangedAction?
    private var takeTaskAction: TakeTask?
    
    init(taskCompletedAction: @escaping CompletedAction, taskChangeAction: @escaping ChangedAction, takeTask: TakeTask?) {
        self.taskCompletedAction = taskChangeAction
        self.taskChangeAction = taskChangeAction
       // self.takeTaskAction = takeTask
        super.init()
        guard let newTask = takeTask else { return }
        let tas = newTask()
        add(tas)
        
    }
    
    func configureBindigs() {
        let some = tasks.share()
        
        some.subscribe(onNext: { _ in
            print("1")
        })
        .disposed(by: bag)
        
        some.subscribe(onNext: { _ in
            print("2")
        })
        .disposed(by: bag)
    }
    
    func task(at row: Int) -> Task {
        items[row]
    }
    
    func add(_ task: Task) {
        items.insert(task, at: 0)
        print(task.title)
        
    }
    
    func update(_ task: Task, at row: Int) {
        items[row] = task
        // saveTasks()
    }
    
    func delete(at row: Int, _ completion: ((Bool) -> Void)?) {
        items.remove(at: row)
    }
    
    func delete(at index: Int) {
            items.remove(at: index)
            print(index)
    }
    
    func index(_ index: IndexPath) {
        let indexs = items.map({ item in
            items
        })
        let task = items[index.row]
    }
    
    func index(_ item: Task) -> Array<Task>.Index? {
        items.firstIndex(where: { $0.title == item.title})
    }
}

extension TaskListDataSource: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskListTableViewCell = tableView.dequeueReusableCell(indexPath)
        let item = task(at: indexPath.row)
        
        cell.configure(item) {
            item.isComplete.toggle()
            tableView.reloadData()
            
            if let index = self.index(item) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.listComplete.append(item)
                    self.items.remove(at: index)
                    tableView.deleteRows(at:[IndexPath(row: index, section: 0)], with: .fade)
                })
            }
        }
        return cell
    }
}

