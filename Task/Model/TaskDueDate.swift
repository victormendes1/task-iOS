//
//  TaskDueDate.swift
//  Task
//
//  Created by Victor Mendes on 03/11/21.
//

import Foundation

struct TaskDueDate {
    func convertDate(_ date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
        guard let dateRevert = formatter.date(from: date) else { return "" }
        let isToday = Locale.current.calendar.isDateInToday(dateRevert)
        if isToday {
            formatter.dateFormat = "'Today at' HH:mm"
        } else {
            formatter.dateFormat = "dd/MM/yyyy 'at' HH:mm"
        }
        let dateConverted = formatter.string(from: dateRevert)
        return dateConverted.description
    }    
}
