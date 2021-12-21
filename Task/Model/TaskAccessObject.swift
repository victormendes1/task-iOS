//
//  TaskAccessObject.swift
//  Task
//
//  Created by Victor Mendes on 28/10/21.
//

import Foundation

class TaskAccessObject {
    
    static var newItems: [Task] = [] {
        didSet {
            saveTasks(tasks: newItems, done: false)
        }
    }
    
    static var completeItems: [Task] {
        get {
            guard let tasks = loadTasks(done: true) else { return [] }
            return tasks
        }
        set {
            saveTasks(tasks: newValue, done: true)
        }
    }
    
    static func saveTasks(tasks: [Task], done: Bool) {
        do {
            let savedData = try NSKeyedArchiver.archivedData(withRootObject: tasks, requiringSecureCoding: false)
            try done ? savedData.write(to: Task.archiveDoneURL) : savedData.write(to: Task.archiveURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func loadTasks(done: Bool) -> [Task]? {
        var taskLoaded = [Task]()
        do {
            let data = done ?  try Data(contentsOf: Task.archiveDoneURL) : try Data(contentsOf: Task.archiveURL)
            taskLoaded = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [Task]
        } catch {
            print(error.localizedDescription)
        }
        return taskLoaded
    }
}
