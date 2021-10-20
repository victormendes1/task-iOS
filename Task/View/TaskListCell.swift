//
//  TaskListCell.swift
//  Task
//
//  Created by Victor Mendes on 10/09/21.
//

import UIKit

class TaskListCell: UITableViewCell {
    typealias CompleteAction = () -> Void
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var doneButton: UIButton!
    
    private var doneButtonAction: CompleteAction?
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        if let doneButton = doneButtonAction {
            doneButton()
        }
        
    }
    
    func configure(title: String, isDone: Bool, doneButtonAction: @escaping CompleteAction) {
        self.titleLabel.text = title
       // self.dateLabel.text = date
        let image = isDone ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
        doneButton.setBackgroundImage(image, for: .normal)
        self.doneButtonAction = doneButtonAction
    }
}
