//
//  TaskDoneTableViewController.swift
//  Task
//
//  Created by Victor Mendes on 01/11/21.
//

import UIKit
import RxSwift
import RxCocoa

enum Filter {
    case recent
    case old
}
class TaskDoneTableViewController: UITableViewController {
    @IBOutlet var sortButton: UIBarButtonItem!
    
    var listTaskComplete: [Task] = [] {
        didSet {
            TaskAccessObject.saveTasks(tasks: listTaskComplete)
            print("salvando...")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(type: TaskDoneViewCell.self)
        let earliest = UIAction(title: "Earliest First") { (action) in
                print("Users action was tapped")
           }
        let latest = UIAction(title: "Latest First") { (action) in
            print("Users action was tapped")
        }
        let menu = UIMenu(title: "Sort By", options: .displayInline, children: [earliest, latest])
        sortButton.menu = menu
        if let tasks = TaskAccessObject.loadTasks() {
            listTaskComplete = tasks.filter({ $0.isComplete == true })
            print(listTaskComplete.count)
        }
    }
    
   // adicionar botoes para selecionar como organizar.
    private func filterTasks(_ items: [Task], sortBy: Filter) {
        var filtered = items
        switch sortBy {
        case .recent:
        filtered.sort(by: { $0.completedWhen > $1.completedWhen })
            listTaskComplete = filtered
        case .old:
            filtered.sort(by: { $0.completedWhen < $1.completedWhen })
            listTaskComplete = filtered
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listTaskComplete.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskDoneViewCell = tableView.dequeueReusableCell(indexPath)
        let date = TaskDueDate().convertDate(listTaskComplete[indexPath.row].completedWhen.description)
        cell.selectionStyle = .none
        cell.titleLabel.text = listTaskComplete[indexPath.row].title
        cell.dateLabel.text = date
        return cell
    }
    
}
