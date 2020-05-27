//
//  DashboardTableViewCell.swift
//  mc2apps
//
//  Created by Agnes Felicia on 24/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var milestoneLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var dashboardTaskView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
