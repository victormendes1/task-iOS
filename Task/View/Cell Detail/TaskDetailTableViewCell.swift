//
//  TaskDetailTableViewCell.swift
//  Task
//
//  Created by Victor on 29/10/21.
//

import UIKit

class TaskDetailTableViewCell: UITableViewCell {

    @IBOutlet var backgroundToDo: UIView!
    @IBOutlet var datePicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(datePicker.date)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        
    }
}
