//
//  Task.swift
//  Tarefas
//
//  Created by Victor Mendes on 29/04/21.
//

import UIKit
import os.log

class Task: NSObject, NSCoding {
    
    // MARK: Properties
    var title: String
    var date: Date
    var notes: String?
    var isComplete: Bool = false
    
    // MARK: Saving data
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("tasks")

    // MARK:  Types
    struct PropertyKey {
        static let title = "title"
        static let date = "dueDate"
        static let notes = "notesDescription"
        static let isComplete = "complete"
    }
    
    // MARK: Initialization
    init?(title: String, date: Date, notes: String, isComplete: Bool) {
        self.title = title
        self.date = date
        self.notes = notes
        self.isComplete = isComplete
    }
    
    // MARK: NSConding
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: PropertyKey.title)
        coder.encode(date, forKey: PropertyKey.date)
        coder.encode(notes, forKey: PropertyKey.notes)
        coder.encode(isComplete, forKey: PropertyKey.isComplete)
    }
    
    required convenience init?(coder: NSCoder) {
        guard let title = coder.decodeObject(forKey: PropertyKey.title) as? String else {
            os_log("Unable to decode title.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let date = coder.decodeObject(forKey: PropertyKey.date) as? Date else {
            os_log("Unable to decode date", log: OSLog.default, type: .debug)
            return nil
        }
        guard let notes = coder.decodeObject(forKey: PropertyKey.notes) as? String else {
            os_log("Unable to decode note", log: OSLog.default, type: .debug)
            return nil
        }
        
              let isComplete = coder.decodeBool(forKey: PropertyKey.isComplete)
        
        self.init(title: title, date: date, notes: notes, isComplete: isComplete)
    }
}
