//
//  TaskDoneTableViewController.swift
//  Task
//
//  Created by Victor Mendes on 01/11/21.
//

import UIKit

class TaskDoneTableViewController: UITableViewController {
    var listTaskComplete: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(type: TaskDoneViewCell.self)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listTaskComplete.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskDoneViewCell = tableView.dequeueReusableCell(indexPath)
        let date = TaskDueDate().convertDate(listTaskComplete[indexPath.row].completedWhen.description)
        cell.titleLabel.text = listTaskComplete[indexPath.row].title
        cell.dateLabel.text = date
        return cell
    }

}
