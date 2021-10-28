//
//  TaskListTableViewCell.swift
//  Task
//
//  Created by Victor Mendes on 19/10/21.
//

import UIKit

class TaskListTableViewCell: UITableViewCell {
    typealias CompleteAction = () -> Bool
   
    @IBOutlet var backgroundCellView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var doneButton: UIButton!
    
    private var doneButtonAction: CompleteAction?
   
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundCellView.layer.cornerRadius = 8
    }
    
    func configure(title: String, doneButtonAction: @escaping CompleteAction) {
        self.titleLabel.text = title
       // self.dateLabel.text = date
        self.doneButtonAction = doneButtonAction
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        if let doneButton = doneButtonAction {
           let isDone = doneButton()
            let image = isDone ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
            self.doneButton.setBackgroundImage(image, for: .normal)
        }
    }
}
