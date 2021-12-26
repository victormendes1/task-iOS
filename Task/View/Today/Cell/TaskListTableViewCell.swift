//
//  TaskListTableViewCell.swift
//  Task
//
//  Created by Victor Mendes on 19/10/21.
//

import UIKit
import RxSwift
import RxCocoa
import Lottie

class TaskListTableViewCell: UITableViewCell {
    typealias Action = () -> Void
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var doneButton: UIButton!
    
    private var buttonAction: Action?
    private var bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureBindings()
        checkAnimation()
    }
    
    func configure(_ task: Task, handler: @escaping Action) {
        titleLabel.text = task.title
        dateLabel.text = TaskDueDate().convertDate(task.date.description)
        doneButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        buttonAction = handler
    }
    
    private func configureBindings() {
        doneButton.rx
            .tap
            .subscribe( onNext: { _ in
                guard let handlingButtonClick = self.buttonAction else { return }
                handlingButtonClick()
                self.checkAnimation()
            })
            .disposed(by: bag)
    }
    
    private func checkAnimation() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            self.doneButton.alpha = 0
        }, completion: { _ in
            self.doneButton.isHidden = true
        })
        let checkAnimationView = AnimationView(name: "checkMark_click")
        let frame = doneButton.frame
        checkAnimationView.frame = CGRect(x: 0, y: 0, width: frame.width + 28, height: frame.height + 28)
        checkAnimationView.center = doneButton.center
        contentView.addSubview(checkAnimationView)
        checkAnimationView.play(completion: { finished in
            if finished {
                self.doneButton.isHidden = !finished
                self.doneButton.alpha = 1
                checkAnimationView.isHidden = finished
            }
        })
    }
}
