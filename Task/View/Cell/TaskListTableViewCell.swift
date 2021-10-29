//
//  TaskListTableViewCell.swift
//  Task
//
//  Created by Victor Mendes on 19/10/21.
//

import UIKit
import RxSwift
import RxCocoa

class TaskListTableViewCell: UITableViewCell {
    typealias Action = () -> Void
    
    @IBOutlet var backgroundCellView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var doneButton: UIButton!
    
    private var buttonAction: Action?
    private var bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundCellView.layer.cornerRadius = 8
        configureBindings()
    }
    
    func configure(_ task: Task, handler: @escaping Action) {
        titleLabel.text = task.title
        isDone(task.isComplete)
        buttonAction = handler
    }
    
    private func configureBindings() {
        doneButton.rx
            .tap
            .subscribe( onNext: { _ in
                if let completion = self.buttonAction { completion() }
            })
            .disposed(by: bag)
    }
    
    private func isDone(_ done: Bool) {
        let image = done ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
        doneButton.setBackgroundImage(image, for: .normal)
    }
}
