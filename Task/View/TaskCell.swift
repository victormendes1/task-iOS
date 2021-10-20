//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Victor Mendes on 12/08/21.
//

import UIKit

protocol TaskCheckCellDelegate: AnyObject {
    func checkTaskCell(_ cell: TaskCell)
}

class TaskCell: UITableViewCell {
    
    typealias DoneButtonAction = () -> Void
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var doneButton: UIButton!
    
    var doneButtonAction: DoneButtonAction?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
      doneButtonAction?()
    }
}
