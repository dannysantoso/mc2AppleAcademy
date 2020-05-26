//
//  DashboardViewController.swift
//  mc2apps
//
//  Created by Agnes Felicia on 22/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var dashboardTableView: UITableView!
    
    var milestone: [Milestone] = []
    {
        didSet{
            dashboardTableView.reloadData()
        }
    }
    
    var currentProject: [Project] = []
//    var currentProject: [Project]?
    var currentTask: [Task] = []
    var index = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        milestone = Milestone.fetchClosestMilestone(viewContext: getViewContext())
        
        dashboardTableView.dataSource = self
        dashboardTableView.delegate = self
        
        dashboardTableView.register(UINib(nibName: "DashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "DashboardCell")



        // Do any additional setup after loading the view.
    }
    
    
    func formatDate(input: Date) -> String {
        let formater = DateFormatter()
        formater.dateFormat = "MMMM dd, yyyy"
        return formater.string(from: input)
    }
    
    func colorCell(color: String, cell: DashboardTableViewCell){
            switch color {
            case "purple":
                cell.dashboardTaskView.layer.backgroundColor = UIColor(red: 0.722, green: 0.69, blue: 0.996, alpha: 1).cgColor
            case "green":
                cell.dashboardTaskView.layer.backgroundColor = UIColor(red: 0.596, green: 0.816, blue: 0.369, alpha: 1).cgColor
            case "blue":
                cell.dashboardTaskView.layer.backgroundColor = UIColor(red: 0.486, green: 0.784, blue: 1, alpha: 1).cgColor
            case "orange":
                cell.dashboardTaskView.layer.backgroundColor = UIColor(red: 0.992, green: 0.753, blue: 0.333, alpha: 1).cgColor
            default:
                cell.dashboardTaskView.layer.backgroundColor = UIColor(red: 0.722, green: 0.69, blue: 0.996, alpha: 1).cgColor
            }
        }

}

extension DashboardViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCell", for: indexPath) as! DashboardTableViewCell
        var yPos:CGFloat = 132
        
        currentTask = Task.fetchTask(viewContext: getViewContext(), selectedMilestone: milestone[indexPath.row].milestoneName!)
        currentProject = Project.fetchProject(viewContext: getViewContext(), selectedMilestone: milestone[indexPath.row].milestoneName!)
        
        cell.milestoneLabel?.text = milestone[indexPath.row].milestoneName
        cell.deadlineLabel?.text = formatDate(input: milestone[indexPath.row].deadline!)
        cell.projectNameLabel?.text = currentProject[index].projectName
        cell.clientNameLabel?.text = currentProject[index].clientName

        for task in currentTask {
            let label = UILabel(frame: CGRect(x: 24, y: yPos, width: 117, height: 23))
            cell.addSubview(label)
            label.font = UIFont(name: "SFProRounded-Regular", size: 20)
            label.textColor = .white
            label.text = task.taskName
            yPos += 30
        }
          
        colorCell(color: milestone[indexPath.row].color ?? "purple", cell: cell)
        cell.selectionStyle = .none


        //mengatur spacing antar cell serta radius corner cell
        let maskLayer = CAShapeLayer()
        maskLayer.cornerRadius = 13
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height-20)
        cell.layer.mask = maskLayer
        
//        index += 1

        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
}

extension DashboardViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = TaskViewController(nibName: "TaskViewController", bundle: nil)

        if let indexPath = dashboardTableView.indexPathForSelectedRow {
            destination.selectedMilestone = milestone[indexPath.row]
            destination.selectedProject = currentProject[index]
            destination.index = indexPath.row
            destination.nameMilestone = milestone[indexPath.row].milestoneName
            destination.deadlineMilestone = milestone[indexPath.row].deadline
            destination.milestoneColor = milestone[indexPath.row].color
            destination.milestone = milestone
//            destination.delegate = self
            destination.nameProject = currentProject[index].projectName
            destination.clientName = currentProject[index].clientName
            destination.deadlineProject = formatDate(input: currentProject[index].deadline!)
            destination.isCompleted = milestone[indexPath.row].isCompleted

        }

        self.navigationController?.pushViewController(destination, animated: true)

//    }


//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 91
    }

}
