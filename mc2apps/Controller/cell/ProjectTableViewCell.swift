//
//  ProjectTableViewCell.swift
//  mc2apps
//
//  Created by danny santoso on 17/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var deadline: UILabel!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var projectView: UIView!
    
    var swipedLeft = false
    var delegate: BackHandler?
    var project = [Project]()
    var indexProject: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        gestureSwipe()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func gestureSwipe(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        projectView.addGestureRecognizer(leftSwipe)
        projectView.addGestureRecognizer(rightSwipe)
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        
        if (sender.direction == .left) {
            if swipedLeft == false{
            let labelPosition = CGPoint(x: self.projectView.frame.origin.x - 70.0, y: self.projectView.frame.origin.y)
            projectView.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: self.projectView.frame.size.width, height: self.projectView.frame.size.height)
                swipedLeft = true
            }
            
        }
        
        if (sender.direction == .right) {
            if swipedLeft == true {
            let labelPosition = CGPoint(x: self.projectView.frame.origin.x + 70.0, y: self.projectView.frame.origin.y)
            projectView.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: self.projectView.frame.size.width, height: self.projectView.frame.size.height)
                swipedLeft = false
            }
        }
    }
    @IBAction func deleteBtn(_ sender: Any) {
        Project.deleteData(viewContext: self.getViewContext(), project: project, indexProject: indexProject!)
        self.delegate?.onBackHome()
        swipedLeft = false
        
    }
    
    
}
