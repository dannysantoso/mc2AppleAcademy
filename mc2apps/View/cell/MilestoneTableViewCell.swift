//
//  MilestoneTableViewCell.swift
//  mc2apps
//
//  Created by danny santoso on 17/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class MilestoneTableViewCell: UITableViewCell {

    @IBOutlet weak var milestoneName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
