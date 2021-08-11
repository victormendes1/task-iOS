//
//  Home.swift
//  Tarefas
//
//  Created by Victor Mendes on 14/04/21.
//

import UIKit

class Home: UIViewController {
    
    let tableView: UITableView = {
        let views = UITableView ()
        views.separatorColor = UIColor.white
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()
    
    var tasks = [Task]() {
        didSet {
            print("Valor alterado")
            saveTasks()
        }
    }
    
    // MARK: - ViewDiLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        print(tasks.count)
        
        if let saveTasks = loadTasks() {
            tasks += saveTasks
        } else {
            print("Não foi possivel carregar")
        }
    
        setupTableView()
    }
    
    
    // MARK: Funcion for load new Tasks
    func loadTasks() -> [Task]? {
        var taskLoaded = [Task]()
        do {
            let data = try Data(contentsOf: Task.archiveURL)
            taskLoaded = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [Task]
            print("Task após serialização - \(taskLoaded as Any)")
            
        } catch {
            print(error.localizedDescription)
        }
        return taskLoaded
    }
    
    // MARK: Funcion for save new Tasks
    func saveTasks() {
        do {
            let savedData = try NSKeyedArchiver.archivedData(withRootObject: tasks, requiringSecureCoding: false)
            try savedData.write(to: Task.archiveURL)
            print("Salvo - \(savedData) - \(tasks.count) Tasks")
            
        } catch {
            print(error.localizedDescription)
        }
    }
        
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "AddNewTask":
            let addTaskVC: AddTask = segue.destination as! AddTask
            addTaskVC.delegate = self
        case "ShowDetailTask":
            let detailVC: DetailViewController = segue.destination as! DetailViewController
            let selectedTaskCell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: selectedTaskCell)
            let selectedTask = tasks[indexPath!.row]
            detailVC.task = selectedTask
            
        default:
            fatalError("Unexpected Segue Identifier: \(String(describing: segue.identifier))")
        }
    }
}

// MARK: - TableView
extension Home: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskCell
        cell.taskLabel.text = tasks[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {}
    }
}
// MARK: - Design
extension Home {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.rowHeight = 80
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
}
// MARK: - Protocol
extension Home: TaskDataDelegate {
    func addTask(newTask: Task) {
        self.tasks.append(newTask)
        self.tableView.reloadData()
    }
}
