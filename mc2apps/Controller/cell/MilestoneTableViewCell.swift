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
    @IBOutlet weak var milestoneDeadline: UILabel!
    @IBOutlet weak var milestoneView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var line: UIView!
    
    var swipedLeft = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gestureSwipe()
        numberView.layer.cornerRadius = numberLabel.bounds.size.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func gestureSwipe(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        milestoneView.addGestureRecognizer(leftSwipe)
        milestoneView.addGestureRecognizer(rightSwipe)
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        
        if (sender.direction == .left) {
            if swipedLeft == false{
            let labelPosition = CGPoint(x: self.milestoneView.frame.origin.x - 70.0, y: self.milestoneView.frame.origin.y)
            milestoneView.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: self.milestoneView.frame.size.width, height: self.milestoneView.frame.size.height)
                swipedLeft = true
            }
            
        }
        
        if (sender.direction == .right) {
            if swipedLeft == true {
            let labelPosition = CGPoint(x: self.milestoneView.frame.origin.x + 70.0, y: self.milestoneView.frame.origin.y)
            milestoneView.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: self.milestoneView.frame.size.width, height: self.milestoneView.frame.size.height)
                swipedLeft = false
            }
        }
    }
}
