//
//  TaskDetailViewDataSource.swift
//  Task
//
//  Created by Victor Mendes on 12/09/21.
//

import UIKit

class TaskDetailViewDataSource: NSObject {

    enum TaskRow: Int, CaseIterable {
        case title
        case date
        case time
        case notes

        static let timeFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            return formatter
        }()

        static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.timeStyle = .none
            formatter.dateStyle = .long
            return formatter
        }()

        func displayText(for task: Task?) -> String? {
            switch self {
            case .title:
            return task?.title
            case .date:
                guard let date = task?.date else { return nil }
                if Locale.current.calendar.isDateInToday(date) {
                   // return NSLocalizedString("Today", comment: "Today for date description")
                }
                return Self.dateFormatter.string(from: date)
            case .time:
                guard let date = task?.date else { return nil }
                return Self.timeFormatter.string(from: date)
            case .notes:
                return task?.notes
            }
        }

        var cellImage: UIImage? {
            switch self {
            case .title:
                return nil
            case .date:
                return UIImage(systemName: "calendar")
            case .time:
                return UIImage(systemName: "clock")
            case .notes:
                return UIImage(systemName: "square.and.pencil")
            }
        }
    }

    private var task: Task

    init(task: Task) {
        self.task = task
        super.init()
    }
}

extension TaskDetailViewDataSource: UITableViewDataSource {
    static let reminderDetailCellIdentifier = "ReminderDetailCell"

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskRow.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.reminderDetailCellIdentifier, for: indexPath)
        let row = TaskRow(rawValue: indexPath.row)
        cell.textLabel?.text = row?.displayText(for: task)
        cell.imageView?.image = row?.cellImage
        return cell
    }
}
