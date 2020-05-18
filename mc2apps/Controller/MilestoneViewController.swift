//
//  MilestoneViewController.swift
//  mc2apps
//
//  Created by danny santoso on 17/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit
import CoreData

class MilestoneViewController: UIViewController {
    
    @IBOutlet weak var milestoneTableView: UITableView!
    @IBOutlet weak var tf1: UITextField!
    
    var milestone = [Milestone]()
    
    
    var selectedProject : Project?

    override func viewDidLoad() {
        super.viewDidLoad()
        milestone = Milestone.fetchQuery(viewContext: getViewContext(), selectedProject: (selectedProject?.projectName)!)
        milestoneTableView.reloadData()
        
        
        milestoneTableView.dataSource = self
        milestoneTableView.register(UINib(nibName: "MilestoneTableViewCell", bundle: nil), forCellReuseIdentifier: "MilestoneCell")
    }
    
    @IBAction func save(_ sender: Any) {

        let newMilestone = Milestone.save(viewContext: self.getViewContext(), milestoneName: tf1.text ?? "", selectedProject: self.selectedProject!)
                self.milestone.append(newMilestone!)
                self.milestoneTableView.reloadData()
    }
}


extension MilestoneViewController: UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return milestone.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            let cell = tableView.dequeueReusableCell(withIdentifier: "MilestoneCell", for: indexPath) as! MilestoneTableViewCell
            cell.milestoneName?.text = milestone[indexPath.row].milestoneName

            return cell

        }
    
}


