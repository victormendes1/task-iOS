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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        //if let salveTask = loadTask() {
       //     tasks += salveTask
       // }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TaskCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    //1
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    //2
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskCell
        cell.taskLabel.text = "Lembrete"
        return cell
    }
    //3
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //MARK: Private Methods
    //private func loadTask() -> Task? {
     //   return NSKeyedUnarchiver.unarchivedObject(ofClass: Task, from: <#T##Data#>)
    //}
}

