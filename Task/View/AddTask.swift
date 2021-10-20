//
//  AddTask.swift
//  Tarefas
//
//  Created by Victor Mendes on 13/04/21.
//

import UIKit
import os.log

protocol TaskDataDelegate {
    func addTask(newTask: Task)
}

class AddTask: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var titleTask: UITextField!
    @IBOutlet weak var notesTask: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    var placeholderLabel: UILabel!
    var savedTask: Task?
    var delegate: TaskDataDelegate? = nil
    
    // MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        screenComponentAdjustment()
        updateSaveButtonState()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Desabilitando o botão Save enquanto digitar
        saveButton.isEnabled = false
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        title = textField.text
    }
    
    // MARK: Actions
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func buttonDone(_ sender: Any) {
        let title = titleTask.text ?? ""
        let notes = notesTask.text ?? ""
        let date = Date().addingTimeInterval(800.0)
        
        savedTask = Task(title: title, date: date, notes: notes, isComplete: false)
        if self.delegate != nil {
            self.delegate?.addTask(newTask: savedTask!)
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func updateSaveButtonState() {
        let text = titleTask.text ?? ""
        saveButton.isEnabled = !text.isEmpty
        
    }
}

// MARK: - Design
extension AddTask {
    
    func screenComponentAdjustment() {
        //Placeholder setup
        placeholderLabel = UILabel()
        placeholderLabel.text = "Notas"
        placeholderLabel.font = UIFont.systemFont(ofSize: 15.0)
        placeholderLabel.textColor = .systemGray3
        placeholderLabel.frame.origin.y = 10
        placeholderLabel.frame.origin.x = 5
        placeholderLabel.sizeToFit()
        
        // Style Title
        titleTask.delegate = self
        titleTask.backgroundColor = .secondarySystemBackground
        titleTask.layer.cornerRadius = 8
        titleTask.borderStyle = .none
        
        // Notes setup
        notesTask.delegate = self
        notesTask.addSubview(placeholderLabel)
        
        // Style Notes
        notesTask.backgroundColor = .secondarySystemBackground
        notesTask.font = UIFont.systemFont(ofSize: 15.0)
        //notesTask.font = UIFont.preferredFont(forTextStyle: .)
        notesTask.layer.cornerRadius = 10
        
        // Shadow of notes
        notesTask.layer.shadowColor = UIColor.gray.cgColor
        notesTask.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        notesTask.layer.shadowRadius = 20
        notesTask.layer.masksToBounds = true
    }
}
