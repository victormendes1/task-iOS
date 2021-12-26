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
    @IBOutlet var showOptionsButton: UIBarButtonItem!
    
    var items: [Task] = []
    var disposed = DisposeBag()
    let addNewTaskButton: UIButton = {
        let button = UIButton().customButtonAddTask
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.view.addSubview(addNewTaskButton)
        configureBindings()
        configureCell()
        showMenuOptions()
    }
    
    func addTask(_ item: Task) {
        items.append(item)
        saveTasks()
        tableView.reloadData()
    }
    
    func updateTask(updated task: Task) {
        let index = index(task)
        items[index] = task
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
    
    private func showMenuOptions() {
        let reviewTaskDone = UIAction(title: "Review Tasks Done") { action in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController: TaskDoneTableViewController = storyboard.instantiateViewController(identifier: "ReviewTableViewController")
            viewController.delegate = self
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        let options = UIMenu(title: "Options", options: .displayInline, children: [reviewTaskDone])
        showOptionsButton.menu = options
    }
    
    //MARK: - Configure Bindings
    private func configureBindings() {
        let feedback = UIImpactFeedbackGenerator(style: .heavy)
        
        addNewTaskButton.rx
            .tap
            .subscribe(onNext: {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let navigationDetail: UINavigationController = storyboard.instantiateViewController(identifier: "NavigationTaskDetail")
                guard let vcAddNewTask = navigationDetail.viewControllers.first as? TaskDetailViewController else { return }
                vcAddNewTask.handler = { self.addTask($0) }
                self.showDetailViewController(navigationDetail, sender: nil)
            })
            .disposed(by: disposed)
        
        addNewTaskButton.rx
            .controlEvent(.touchDown)
            .subscribe(onNext: {
                feedback.impactOccurred()
                UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseIn, animations: {
                    self.addNewTaskButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                })
            })
            .disposed(by: disposed)
        
        addNewTaskButton.rx
            .controlEvent(.touchUpOutside)
            .subscribe(onNext: {
                feedback.impactOccurred()
                UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseIn, animations: {
                    self.addNewTaskButton.transform = CGAffineTransform.identity
                })
            })
            .disposed(by: disposed)
        
        addNewTaskButton.rx
            .controlEvent(.touchUpInside)
            .subscribe(onNext: {
                feedback.impactOccurred()
                UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseIn, animations: {
                    self.addNewTaskButton.transform = CGAffineTransform.identity
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController: UINavigationController = storyboard.instantiateViewController(identifier: "NavigationTaskDetail")
        guard let detailVC = navigationController.viewControllers.first as? TaskDetailViewController else { return }
        detailVC.task = items[indexPath.row]
        detailVC.handler = { self.updateTask(updated: $0) }
        showDetailViewController(navigationController, sender: nil)
    }
}

// MARK: - Extension
// Responsável de salvar as tarefas pronta
extension TaskListViewController: SaveTaskDelegate {
    func saveCompletedTask(_ task: Task, _ tableView: UITableView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
            let _index = self.index(task)
            task.isComplete = true
            task.completedWhen = Date()
            TaskAccessObject.completeItems.append(task)
            self.items.remove(at:_index)
            tableView.deleteRows(at:[IndexPath(row: _index, section: 0)], with: .fade)
        })
    }
}
