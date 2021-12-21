//
//  TaskDoneTableViewController.swift
//  Task
//
//  Created by Victor Mendes on 01/11/21.
//

import UIKit
import RxSwift
import RxCocoa

protocol SaveTaskDelegate {
    func saveCompletedTask(_ task: Task, _ tableView: UITableView)
}

enum Filter {
    case recent
    case old
}

class TaskDoneTableViewController: UITableViewController {
    @IBOutlet var sortButton: UIBarButtonItem!
    
    var delegate: SaveTaskDelegate!
    var completeItems: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCell()
        menuFilter()
    }
    
    private func configureCell() {
        tableView.register(type: TaskDoneViewCell.self)
        if completeItems.isEmpty {
            loadTasks()
        }
    }
    
    private func saveTasks() {
        TaskAccessObject.completeItems = completeItems
    }
    
    private func loadTasks() {
        if let _tasks = TaskAccessObject.loadTasks(done: true) {
            completeItems = _tasks.filter { $0.isComplete == true}
        }
    }
    
    private func menuFilter() {
        let earliest = UIAction(title: "Earliest First") { (action) in
            self.filterTasks(self.completeItems, sortBy: .recent)
        }
        
        let latest = UIAction(title: "Latest First") { (action) in
            self.filterTasks(self.completeItems, sortBy: .old)
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
            completeItems = filtered
            
        case .old:
            filtered.sort(by: { $0.completedWhen < $1.completedWhen })
            completeItems = filtered
        }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        completeItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskDoneViewCell = tableView.dequeueReusableCell(indexPath)
        let date = TaskDueDate().convertDate(completeItems[indexPath.row].completedWhen.description)
        cell.selectionStyle = .none
        cell.titleLabel.text = completeItems[indexPath.row].title
        cell.dateLabel.text = date
        return cell
    }
}
