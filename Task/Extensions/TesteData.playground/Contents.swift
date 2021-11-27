import UIKit


    func convertDate(_ date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
        guard let dateRevert = formatter.date(from: date) else { return "" }
        print(dateRevert)
        let isToday = Locale.current.calendar.isDateInToday(dateRevert)
        if isToday {
            formatter.dateFormat = "'Hoje às' HH:mm"
        } else {
            formatter.dateFormat = "dd/MM/yyyy 'às' HH:mm:"
        }
        let dateConverted = formatter.string(from: dateRevert)
        return dateConverted.description
    }

let date = "2021-11-27 22:16:00 UTC"
print(convertDate(date))
