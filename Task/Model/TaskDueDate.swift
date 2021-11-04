//
//  TaskDueDate.swift
//  Task
//
//  Created by Victor Mendes on 03/11/21.
//

import Foundation

enum DueDate {
    case today, week, month
    
    func compareDate(date: Date)  {
        let isToday = Locale.current.calendar.isDateInToday(date)
        let isWeek = Locale.current.calendar.isDateInWeekend(date)
        switch self {
        case .today:
             isToday
            
        case .week:
             date > Date() && !isToday && isWeek
        case .month:
             break
        }
    }
}



