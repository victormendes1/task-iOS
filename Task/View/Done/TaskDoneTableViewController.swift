//
//  TaskDoneTableViewController.swift
//  Task
//
//  Created by Victor Mendes on 01/11/21.
//

import UIKit
import RxSwift
import RxCocoa

class TaskDoneTableViewController: UITableViewController {
    @IBOutlet var sortByControl: UISegmentedControl!
    
    var listTaskComplete: [Task] = []
    var bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(type: TaskDoneViewCell.self)
        
    }
    
    func configureBlinds() {
        sortByControl.rx
            .controlEvent(.valueChanged)
            .subscribe(onNext: {
                self.filterTasks(self.listTaskComplete)
            })
            .disposed(by: bag)
    }
    
    private func filterTasks(_ items: [Task]) {
        var filtered = items
        filtered.sort(by: { $0.completedWhen > $1.completedWhen })
        listTaskComplete = filtered
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
