//
//  TaskListViewController.swift
//  Tarefas
//
//  Created by Victor Mendes on 10/09/21.
//

import UIKit
import RxCocoa
import RxSwift
import Lottie

class TaskListViewController: UITableViewController {
    var items: [Task] = []
    var disposed = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCell()
        addNewTask()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTaskDetailSegue",
           let destination = segue.destination as? TaskDetailViewController,
           let selectedCell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: selectedCell) {
            let rowIndex = indexPath.row
            
            // destination.configure(task: task)
        } else if segue.identifier == "ShowNewTaskSegue" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailVC: TaskDetailViewController = storyboard.instantiateViewController(identifier: "TaskDetailViewController")
            detailVC.handler = { self.addTask($0) }
            
            let navigationController = UINavigationController(rootViewController: detailVC)
            present(navigationController, animated: true, completion: nil)
        } else if segue.identifier == "ShowReviewSegue" {
            let viewController = TaskDoneTableViewController()
            viewController.delegate = self
        }
    }
    
    func addTask(_ item: Task) {
        items.append(item)
        saveTasks()
        tableView.reloadData()
    }
    
    // MARK: - Private Functions
    private func configureCell() {
        tableView.register(type: TaskListTableViewCell.self)
        loadTasks()
    }
    
    private func saveTasks() {
        TaskAccessObject.newItems = items
    }
    
    private func loadTasks() {
        if items.isEmpty {
            if let _tasks = TaskAccessObject.loadTasks(done: false) {
                items = _tasks.filter { $0.isComplete == false}
            }
        }
    }
    
    private func index(_ item: Task) -> Int {
        guard let index = items.firstIndex(where: { $0 == item }).map({ Int($0) }) else { return 0 }
        return index
    }
    
    private func addNewTask() {
        let add = UIButton(type: .custom)
        let feedback = UIImpactFeedbackGenerator(style: .heavy)
        add.frame = CGRect(x: 290, y: 720, width: 70, height: 70)
        add.backgroundColor = .lightGray
        add.layer.cornerRadius = 0.5 * add.bounds.size.width
        add.clipsToBounds = true
        add.setImage(UIImage(systemName: "plus"), for: .normal)
        add.imageView?.contentMode = .scaleToFill
        navigationController?.view.addSubview(add)
       
        add.rx
            .tap
            .subscribe(onNext: {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let navigationDetail: UINavigationController = storyboard.instantiateViewController(identifier: "NavigationTaskDetail")
                guard let vcAddNewTask = navigationDetail.viewControllers.first as? TaskDetailViewController else { return }
                vcAddNewTask.handler = { self.addTask($0) }
                self.showDetailViewController(navigationDetail, sender: nil)
            })
            .disposed(by: disposed)
        
        add.rx
            .controlEvent(.touchDown)
            .subscribe(onNext: {
                feedback.impactOccurred()
                UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseIn, animations: {
                    add.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                })
            })
            .disposed(by: disposed)
        
        add.rx
            .controlEvent(.touchUpOutside)
            .subscribe(onNext: {
                feedback.impactOccurred()
                UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseIn, animations: {
                    add.transform = CGAffineTransform.identity
                })
            })
            .disposed(by: disposed)
        
        add.rx
            .controlEvent(.touchUpInside)
            .subscribe(onNext: {
                feedback.impactOccurred()
                UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseIn, animations: {
                    add.transform = CGAffineTransform.identity
                })
            })
            .disposed(by: disposed)
    }
    
    //MARK: - TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskListTableViewCell = tableView.dequeueReusableCell(indexPath)
        let item = items[indexPath.row]
        cell.configure(item) {
            self.saveCompletedTask(item, tableView)
            self.saveTasks()
        }
        return cell
    }
}

// MARK: - Extension
// Responsável de salvar as tarefas pronta
extension TaskListViewController: SaveTaskDelegate {
    func saveCompletedTask(_ task: Task, _ tableView: UITableView) {
        let _index = index(task)
        task.isComplete.toggle()
        task.completedWhen = Date()
        TaskAccessObject.completeItems.append(task)
        items.remove(at:_index)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            tableView.deleteRows(at:[IndexPath(row: _index, section: 0)], with: .fade)
        })
    }
}
