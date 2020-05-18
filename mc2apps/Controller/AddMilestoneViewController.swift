//
//  AddMilestoneViewController.swift
//  mc2apps
//
//  Created by danny santoso on 18/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class AddMilestoneViewController: UIViewController {

    @IBOutlet weak var milestoneName: UITextField!
    @IBOutlet weak var deadline: UITextField!
    
    var delegate: BackHandler?
    var selectedProject: Project?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func save(_ sender: Any) {
        if Milestone.save(viewContext: self.getViewContext(), milestoneName: milestoneName.text ?? "", selectedProject: selectedProject!) != nil{
            dismiss(animated: true, completion: nil)
                self.delegate?.onBackHome()
        }
            
    }
}
