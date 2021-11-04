//
//  TaskAccessObject.swift
//  Task
//
//  Created by Victor Mendes on 28/10/21.
//

import Foundation

class TaskAccessObject {
    
    static func saveTasks(tasks: [Task]) {
        do {
            let savedData = try NSKeyedArchiver.archivedData(withRootObject: tasks, requiringSecureCoding: false)
            try savedData.write(to: Task.archiveURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func loadTasks() -> [Task]? {
        var taskLoaded = [Task]()
        do {
            let data = try Data(contentsOf: Task.archiveURL)
            taskLoaded = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [Task]
        } catch {
            print(error.localizedDescription)
        }
        return taskLoaded
    }
}
