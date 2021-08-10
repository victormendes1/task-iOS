//
//  Home.swift
//  Tarefas
//
//  Created by Victor Mendes on 14/04/21.
//

import UIKit

class Home: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView: UITableView = {
        let views = UITableView ()
        views.separatorColor = UIColor.white
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()
    
    var tasks = [
        Task(title: "Comprar Leite", notes: "No mercado"),
        Task(title: "Apresentação do novo iPhone", notes: "Em setembro")
    ]
    var tasksExample = [
        Task(title: "Comprar Leite", notes: "No mercado"),
        Task(title: "Apresentação do novo iPhone", notes: "Em setembro")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        print(tasks.count)
        
       
        
        setupTableView()
    }
    
    @objc func loadRefresh() {
        print(tasks.count)
        if let saveTask = loadTasks() {
            tasks += saveTask
        } else {
            print("Não foi possivel refresh e load")
        }
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
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
    
    func saveTasks() {
        do {
            let savedData = try NSKeyedArchiver.archivedData(withRootObject: tasks, requiringSecureCoding: false)
            try savedData.write(to: Task.archiveURL)
            print(savedData, Task.archiveURL)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    @IBAction func saveDataWithButton(_ sender: Any) {
        saveTasks()
    }
    
    // MARK: - TableView
    func setupTableView() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector (loadRefresh), for: .valueChanged)
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskCell
        cell.taskLabel.text = tasks[indexPath.row]?.title
        return cell
    }
    
    /*
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     return 80
     }*/
    
    //MARK: Private Methods
    //private func loadTask() -> Task? {
    //   return NSKeyedUnarchiver.unarchivedObject(ofClass: Task, from: <#T##Data#>)
    //}
}

