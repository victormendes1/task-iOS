import UIKit

let now = Date()
let now_1 = Date(timeIntervalSinceNow: 500)

now > now_1

print(now, now_1)


let date = Date().addingTimeInterval(500)
let isToday = Locale.current.calendar.isDateInToday(date)
let isWeek = Locale.current.calendar.isDateInWeekend(date)


date > Date()
isToday
