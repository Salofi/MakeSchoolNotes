//
//  NewNoteViewController.swift
//  MakeSchoolNotes
//  Test
//  Created by Salofi Tautua'a on 8/31/15.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//  aaaaaaaaa
// hello world!

import UIKit

class NewNoteViewController: UIViewController {
    
    var currentNote: Note?
    
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
        
        if (segue.identifier == "ShowNewNote") {
            // create a new Note and holdonto it, to be able to save it later 
            currentNote = Note()
            let noteViewController = segue.destinationViewController as! NoteDisplayViewController
            noteViewController.note = currentNote
            noteViewController.edit = true 
        }
    }


}
