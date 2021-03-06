//
//  CompleteMilestoneViewController.swift
//  mc2apps
//
//  Created by Agnes Felicia on 26/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class CompleteViewController: UIViewController {

    
    @IBOutlet weak var congratsMilestoneLabel: UILabel!
    @IBOutlet weak var completeMilestoneLabel: UILabel!
    @IBOutlet weak var congratsProjectLabel: UILabel!
    @IBOutlet weak var completeProjectLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var yayButton: UIButton! {
        didSet {
            yayButton.layer.cornerRadius = 27.5
        }
    }
   
    var sourceIndex = 0
    var projectReward: String?
    var selectedProject : Project?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        if sourceIndex == 1 {
            congratsMilestoneLabel.isHidden = false
            completeMilestoneLabel.isHidden = false
            congratsProjectLabel.isHidden = true
            completeProjectLabel.isHidden = true
            rewardLabel.isHidden = true
        } else if sourceIndex == 2 {
            congratsMilestoneLabel.isHidden = true
            completeMilestoneLabel.isHidden = true
            congratsProjectLabel.isHidden = false
            completeProjectLabel.isHidden = false
            rewardLabel.isHidden = false
            rewardLabel.text = projectReward
        }
        
    }

    @IBAction func yayButtonClicked(_ sender: UIButton) {
        if sourceIndex == 1 {
            let destination = RewardViewController(nibName: "RewardViewController", bundle: nil)
            destination.selectedProject = selectedProject
            self.navigationController?.pushViewController(destination, animated: true)
        } else if sourceIndex == 2 {
            self.navigationController?.popToRootViewController(animated: true)
        }
        
    }
    
    

}
