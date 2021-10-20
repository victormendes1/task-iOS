//
//  TaskListTableViewCell.swift
//  Task
//
//  Created by Victor Mendes on 19/10/21.
//

import UIKit

class TaskListTableViewCell: UITableViewCell {
    typealias CompleteAction = () -> Void
    
    @IBOutlet var backgroundCellView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var doneButton: UIButton!
    
    private var doneButtonAction: CompleteAction?
   
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundCellView.layer.cornerRadius = 8
    }
    
    func configure(title: String, isDone: Bool, doneButtonAction: @escaping CompleteAction) {
        self.titleLabel.text = title
       // self.dateLabel.text = date
        let image = isDone ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
        doneButton.setBackgroundImage(image, for: .normal)
        self.doneButtonAction = doneButtonAction
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        if let doneButton = doneButtonAction {
            doneButton()
        }
        
    }
}
