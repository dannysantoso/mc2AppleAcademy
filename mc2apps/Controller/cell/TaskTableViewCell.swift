//
//  TaskTableViewCell.swift
//  mc2apps
//
//  Created by danny santoso on 18/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    

    var indexTask: Int?
    var task = [Task]()
    
    @IBOutlet weak var taskName: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    @IBAction func editingChangedTextfield(_ sender: UITextField) {
        
        Task.update(viewContext: self.getViewContext(), taskName: taskName.text ?? "", task: task, indexTask: indexTask!, isChecklist: false)

    }

}
