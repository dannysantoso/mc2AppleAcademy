//
//  DashboardViewController.swift
//  mc2apps
//
//  Created by Agnes Felicia on 22/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

//    @IBOutlet weak var dashboardLabel: UILabel!
//    @IBOutlet weak var approachingLabel: UILabel!
//    @IBOutlet weak var exclamationLabel: UILabel!
    
    @IBOutlet weak var dashboardTableView: UITableView!
    
//    var task = [Task]()
    
    var milestone: [Milestone] = []
    {
        didSet{
            dashboardTableView.reloadData()
        }
    }
    
//    var project = [Project]()
//    var project: [Project] = []
//    var task: [Task] = []
    
    var project: [Project]?
//    var task: [Task]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        milestone = Milestone.fetchClosestMilestone(viewContext: getViewContext())
        
        dashboardTableView.dataSource = self
        
        dashboardTableView.register(UINib(nibName: "DashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "DashboardCell")


        // Do any additional setup after loading the view.
    }
    
    
    func formatDate(input: Date) -> String {
        let formater = DateFormatter()
        formater.dateFormat = "MMMM dd, yyyy"
        return formater.string(from: input)
    }

}

extension DashboardViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCell", for: indexPath) as! DashboardTableViewCell
        
        
        cell.milestoneLabel?.text = milestone[indexPath.row].milestoneName
        cell.deadlineLabel?.text = formatDate(input: milestone[indexPath.row].deadline!)
        
        cell.selectionStyle = .none


//        // if on ongoing, reload data ongoing, else reload completed projects
//        if selectedSegmentIndex == 1 {
//            cell.projectName?.text = projects[indexPath.row].projectName
//            cell.clientName?.text = projects[indexPath.row].clientName
//            cell.deadline?.text = formatDate(input: projects[indexPath.row].deadline!)
//            colorCell(color: projects[indexPath.row].color ?? "purple", cell: cell)
//            cell.selectionStyle = .none
//        } else {
//            cell.projectName?.text = completedProjects[indexPath.row].projectName
//            cell.clientName?.text = completedProjects[indexPath.row].clientName
//            cell.deadline?.text = formatDate(input: completedProjects[indexPath.row].deadline!)
//            colorCell(color: completedProjects[indexPath.row].color ?? "purple", cell: cell)
//            cell.selectionStyle = .none
//        }
//
        //mengatur spacing antar cell serta radius corner cell
        let maskLayer = CAShapeLayer()
        maskLayer.cornerRadius = 13
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height-20)
        cell.layer.mask = maskLayer

        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
}
