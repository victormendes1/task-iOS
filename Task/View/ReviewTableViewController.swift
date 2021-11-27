//
//  ReviewTableViewController.swift
//  Task
//
//  Created by Victor Mendes on 01/11/21.
//

import UIKit

class ReviewTableViewController: UITableViewController {
    var listTaskComplete: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listTaskComplete.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = listTaskComplete[indexPath.row].title

        return cell
    }

}
