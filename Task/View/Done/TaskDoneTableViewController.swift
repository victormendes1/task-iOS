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
            TaskAccessObject.saveTasks(tasks: listTaskComplete, done: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(type: TaskDoneViewCell.self)
         menuFilter()

        if let _tasks = TaskAccessObject.loadTasks(done: true) {
            listTaskComplete = _tasks
        }
    }
    
    private func menuFilter() {
        let earliest = UIAction(title: "Earliest First") { (action) in
            self.filterTasks(self.listTaskComplete, sortBy: .recent)
        }
        
        let latest = UIAction(title: "Latest First") { (action) in
            self.filterTasks(self.listTaskComplete, sortBy: .old)
        }
        
        let menu = UIMenu(title: "Sort By", options: .displayInline, children: [earliest, latest])
        sortButton.menu = menu
    }
    
    // Melhorar essa função
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
        tableView.reloadData()
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
