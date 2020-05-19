//
//  MilestoneViewController.swift
//  mc2apps
//
//  Created by danny santoso on 17/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit
import CoreData

class MilestoneViewController: UIViewController, BackHandler {
    
    
    @IBOutlet weak var milestoneTableView: UITableView!
    
    var milestone = [Milestone]()
    
    
    var selectedProject : Project?

    override func viewDidLoad() {
        super.viewDidLoad()
        milestone = Milestone.fetchQuery(viewContext: getViewContext(), selectedProject: (selectedProject?.projectName)!)
        milestoneTableView.reloadData()
        
        
        milestoneTableView.dataSource = self
        milestoneTableView.delegate = self
        milestoneTableView.register(UINib(nibName: "MilestoneTableViewCell", bundle: nil), forCellReuseIdentifier: "MilestoneCell")
    }
    
    
    @IBAction func addMilestone(_ sender: Any) {
        let destination = AddMilestoneViewController(nibName: "AddMilestoneViewController", bundle: nil)
        
        // Mengirim data hero
        destination.delegate = self
        destination.selectedProject = self.selectedProject
        
        
        self.present(destination, animated: true, completion: nil)
    }
    
    
    func onBackHome() {
        milestone = Milestone.fetchQuery(viewContext: getViewContext(), selectedProject: (selectedProject?.projectName)!)
        milestoneTableView.reloadData()
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

extension MilestoneViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = TaskViewController(nibName: "TaskViewController", bundle: nil)

        if let indexPath = milestoneTableView.indexPathForSelectedRow {
            destination.selectedMilestone = milestone[indexPath.row]
        }

        // Push/mendorong view controller lain
        self.navigationController?.pushViewController(destination, animated: true)
        
        
    }
    
}


