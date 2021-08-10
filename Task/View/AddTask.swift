//
//  AddTask.swift
//  Tarefas
//
//  Created by Victor Mendes on 13/04/21.
//

import UIKit
import os.log

class AddTask: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var titleTask: UITextField!
    @IBOutlet weak var notesTask: UITextView!
    
    var placeholderLabel: UILabel!
    var task: Task?
    var homeVC = Home()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenComponentAdjustment()
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Navigation
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func buttonDone(_ sender: Any) {
        let title = titleTask.text ?? ""
        let notes = notesTask.text ?? ""
        
        task = Task(title: title, notes: notes)
        homeVC.tasks.append(task)
        print(task)
        dismiss(animated: true, completion: nil)
    }
    

    
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         super.prepare(for: segue, sender: sender)
         
         guard let button = sender as? UIButton, button === doneButton else {
             os_log("O butão save não foi pressionado, cancelando...", log: OSLog.default, type: .debug)
             // Sender == Remetente (Envia)
             return
             
         }
         
         let title = titleTask.text ?? ""
         let notes = notesTask.text ?? ""
         
         task = Task(title: title, notes: notes)
     }*/
}


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
/*//Placeholder setup of title
 titleTask.text = "Titulo"
 titleTask.textColor = .systemGray3
 titleTask.becomeFirstResponder()
 titleTask.selectedTextRange = titleTask.textRange(from: titleTask.beginningOfDocument, to: titleTask.beginningOfDocument)
 
 /*
 // Shadow of title
 titleTask.layer.shadowColor = UIColor.gray.cgColor
 titleTask.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
 titleTask.layer.shadowRadius = 20
 titleTask.layer.masksToBounds = true
 */
 
 func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
 let currentText: String = textView.text
 let updateText = (currentText as NSString).replacingCharacters(in: range, with: text)
 
 if updateText.isEmpty {
 textView.text = "Titulo"
 textView.textColor = .systemGray3
 
 textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
 }
 else if textView.textColor == UIColor.systemGray3 && !text.isEmpty {
 textView.textColor = UIColor.black
 textView.text = text
 }
 else {
 return true
 }
 
 return false
 }
 
 func textViewDidChangeSelection(_ textView: UITextView) {
 if self.view.window != nil {
 if textView.textColor == UIColor.lightGray {
 textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
 }
 }
 }
 
 */
