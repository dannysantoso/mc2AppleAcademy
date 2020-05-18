//
//  AddProjectViewController.swift
//  mc2apps
//
//  Created by danny santoso on 18/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class AddProjectViewController: UIViewController {

    @IBOutlet weak var projectName: UITextField!
    @IBOutlet weak var clientName: UITextField!
    @IBOutlet weak var deadline: UITextField!
    @IBOutlet weak var projectCompletionReward: UITextField!
    
    var delegate: BackHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func save(_ sender: Any) {
        if (Project.save(viewContext: getViewContext(), projectName: projectName.text ?? "", clientName: clientName.text ?? "", deadline: Date(), color: "red", isCompleted: false, projectCompletionReward: projectCompletionReward.text ?? "") != nil){
                
                dismiss(animated: true, completion: nil)
                    self.delegate?.onBackHome()
            }
        }
}
