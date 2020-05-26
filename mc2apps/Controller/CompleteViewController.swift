//
//  CompleteMilestoneViewController.swift
//  mc2apps
//
//  Created by Agnes Felicia on 26/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class CompleteViewController: UIViewController {

    
    @IBOutlet weak var completeLabel: UILabel!
    @IBOutlet weak var enjoyLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var yayButton: UIButton! {
        didSet {
            yayButton.layer.cornerRadius = 27.5
        }
    }
   
    
    var sourceIndex = 0
    var projectReward: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupUI()
    }
    
    func setupUI() {
        if sourceIndex == 1 {
            completeLabel.text = "1 milestone!"
            enjoyLabel.isHidden = true
            rewardLabel.isHidden = true
        } else if sourceIndex == 2 {
            completeLabel.text = "your project!"
            enjoyLabel.isHidden = false
            rewardLabel.text = projectReward
            rewardLabel.isHidden = false
        }
        
    }


    

}
