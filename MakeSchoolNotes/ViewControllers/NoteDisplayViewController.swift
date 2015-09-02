//
//  NoteDisplayViewController.swift
//  MakeSchoolNotes
//
//  Created by Salofi Tautua'a on 9/1/15.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import ConvenienceKit

class NoteDisplayViewController: UIViewController {

    var currentNote: Note?
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: TextView!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var toolbarBottomSpace: NSLayoutConstraint!
    var keyboardNotificationHandler: KeyboardNotificationHandler?
    var edit: Bool = false 
    var note: Note? {
        didSet {
            displayNote(note)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        displayNote(note)
        
        titleTextField.returnKeyType = .Next //1
        titleTextField.delegate = self     //2
        
        keyboardNotificationHandler = KeyboardNotificationHandler()
        
        keyboardNotificationHandler!.keyboardWillBeHiddenHandler = { (height: CGFloat) in
            UIView.animateWithDuration(0.3) {
                self.toolbarBottomSpace.constant = 0
                self.view.layoutIfNeeded()
            }
        }
        
        keyboardNotificationHandler!.keyboardWillBeShownHandler = { (height: CGFloat) in
            UIView.animateWithDuration(0.3) {
                self.toolbarBottomSpace.constant = -height
                self.view.layoutIfNeeded()
            }
        }
        
        if edit {
            deleteButton.enabled = false
        }
    }
    
    //MARK: Business Logic
    
    func displaynote(note: Note?) {
        if let note = note, titleTextField = titleTextField, contentTextView = contentTextView {
            titleTextField.text = note.title
            contentTextView.text = note.content
            
            if count(note.title)==0 && count(note.content)==0 { //1
                titleTextField.becomeFirstResponder()
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveNote()
    }
    
    func saveNote() {
        if let note = note {
            let realm = Realm()
            
            realm.write {
                if (note.title != self.titleTextField.text || note.content != self.contentTextView.textValue) {
                    note.title = self.titleTextField.text
                    note.content = self.contentTextView.textValue
                    note.modificationDate = NSDate()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        currentNote = Note()
    }

    func displayNote(note: Note?) {
        if let note = note, titleTextField = titleTextField, contentTextView = contentTextView  {
            titleTextField.text = note.title
            contentTextView.text = note.content
        }
    }
    
}

extension NoteDisplayViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if (textField == titleTextField) {  //1
            contentTextView.returnKeyType = .Done
            contentTextView.becomeFirstResponder()
        }
        
        return false
    }
}
