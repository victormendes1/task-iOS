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
    var notes: String?
  
    // MARK: Saving data
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("tasks")
    
    // MARK: Saving data with Codable
/*    func storeTask() {
        do {
            let data = try PropertyListEncoder().encode(tasks)
            let success = NSKeyedArchiver.archivedData(withRootObject: Task, requiringSecureCoding: true)
        }
    } */
    // MARK: Types
    struct PropertyKey {
        static let title = "title"
        static let notes = "notesDescription"
    }
    
    // MARK: Initialization
    init?(title: String, notes: String) {
        
        self.title = title
        self.notes = notes
    }
    
    // MARK: NSConding
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: PropertyKey.title)
        coder.encode(notes, forKey: PropertyKey.notes)
    }
    
    required convenience init?(coder: NSCoder) {
        guard let title = coder.decodeObject(forKey: PropertyKey.title) as? String else {
            os_log("Não foi possivel decodificar o nome do objeto refeição.",log: OSLog.default, type: .debug)
            
            return nil
        }
        
        guard let notes = coder.decodeObject(forKey: PropertyKey.notes) as? String else {
            os_log("Não foi possivel decodificar o nome do objeto refeição.",log: OSLog.default, type: .debug)
            
            return nil
        }
        self.init(title: title, notes: notes)
    }
}
//class SaveTask {
 //   static func saveTask(task: Task) {
  //      let data = NSKeyedArchiver.archivedData(withRootObject: task)
   //     UserDefaults.standard.set(forKey: "tasks")
  //  }
//}
