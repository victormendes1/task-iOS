import UIKit

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


let date = Date().addingTimeInterval(500)
let isToday = Locale.current.calendar.isDateInToday(date)
let isWeek = Locale.current.calendar.isDateInWeekend(date)


date > Date()
isToday
