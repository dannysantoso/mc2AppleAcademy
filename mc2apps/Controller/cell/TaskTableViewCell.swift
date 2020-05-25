//
//  TaskTableViewCell.swift
//  mc2apps
//
//  Created by danny santoso on 18/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var checklist: UIButton!
    var indexTask: Int?
    var task = [Task]()
    var isChecklist: Bool?
    var isCompleted: Bool?
    
    @IBOutlet weak var taskName: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        checklist.backgroundColor = .clear
        checklist.layer.cornerRadius = 5
        checklist.layer.borderWidth = 1
        checklist.layer.borderColor = UIColor.black.cgColor
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    @IBAction func editingChangedTextfield(_ sender: UITextField) {
        
        Task.update(viewContext: self.getViewContext(), taskName: taskName.text ?? "", task: task, indexTask: indexTask!, isChecklist: false)

    }

    @IBAction func isClicked(_ sender: Any) {
        if isCompleted == false {
            if checklist.backgroundColor == UIColor.black {
                checklist.backgroundColor = .clear
                Task.isCompleted(viewContext: self.getViewContext(), isCompleted: false, task:task, indexTask: indexTask!)
            }else{
                checklist.backgroundColor = UIColor.black
                Task.isCompleted(viewContext: self.getViewContext(), isCompleted: true, task:task, indexTask: indexTask!)
            }
        }
    }
}
