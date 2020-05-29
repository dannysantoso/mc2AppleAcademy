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
    @IBOutlet weak var bgImage: UIImageView!
    
    var milestone: [Milestone] = []
    var currentProject: [Project] = []
    var currentTask: [Task] = []
    var index = 0 
    
    
    override func viewWillAppear(_ animated: Bool) {
        milestone = Milestone.fetchClosestMilestone(viewContext: getViewContext())
        self.dashboardTableView.reloadData()
        
        if milestone.count == 0 {
            bgImage.isHidden = false
            dashboardTableView.isHidden = true
        } else {
            bgImage.isHidden = true
            dashboardTableView.isHidden = false
        }
     
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        if milestone.count == 0 {
            bgImage.isHidden = false
            dashboardTableView.isHidden = true
        } else {
            bgImage.isHidden = true
            dashboardTableView.isHidden = false
        }
        
        dashboardTableView.dataSource = self
        dashboardTableView.delegate = self
        
        dashboardTableView.register(UINib(nibName: "DashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "DashboardCell")

        // Do any additional setup after loading the view.
    }
    
    
    func formatDate(input: Date) -> String {
        let formater = DateFormatter()
        formater.dateFormat = "MMMM d, yyyy"
        return formater.string(from: input)
    }
    
//    Psst, Tomorrow's the deadline!
//    Let's do your best to finish it on time!
    
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
        
        if milestone.count == 0 {
            bgImage.isHidden = false
            dashboardTableView.isHidden = true
            return 0
        } else {
            return milestone.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCell", for: indexPath) as! DashboardTableViewCell
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "Your Text")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        var yPos:CGFloat = 120
        
        currentTask = Task.fetchTask(viewContext: getViewContext(), selectedMilestone: milestone[indexPath.row].milestoneName!)
        let printedProject = Project.fetchProject(viewContext: getViewContext(), selectedMilestone: milestone[indexPath.row].milestoneName!)
        currentProject.append(contentsOf: printedProject)
        
        if currentTask.count == 0 {
            cell.noTaskLabel.isHidden = false
        } else {
            cell.noTaskLabel.isHidden = true
        }
        
        cell.milestoneLabel?.text = milestone[indexPath.row].milestoneName
        cell.deadlineLabel?.text = formatDate(input: milestone[indexPath.row].deadline!)
        cell.projectNameLabel?.text = printedProject[0].projectName
        cell.clientNameLabel?.text = printedProject[0].clientName

        var taskCount = currentTask.count
        if currentTask.count > 3 {
            taskCount = 3
        }
        if taskCount > 0 {
            for index in 0..<taskCount {
                let label = UILabel(frame: CGRect(x: cell.bounds.origin.x + 20, y: cell.bounds.origin.x + yPos, width: cell.bounds.width - 100, height: 23))
                cell.addSubview(label)
                label.font = UIFont(name: "SFProRounded-Bold", size: 20)
                label.textColor = .white
                let text = "-    " + currentTask[index].taskName!
                if currentTask[index].isChecklist == true {
                    label.attributedText = text.strikeThrough()
                    label.textColor = UIColor(white: 1, alpha: 0.7)
                } else {
                    label.text = text
                }
                yPos += 30
            }
        }
          
        colorCell(color: milestone[indexPath.row].color ?? "purple", cell: cell)
        cell.selectionStyle = .none


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

extension DashboardViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = TaskViewController(nibName: "TaskViewController", bundle: nil)

        if let indexPath = dashboardTableView.indexPathForSelectedRow {
            destination.selectedMilestone = milestone[indexPath.row]
            destination.selectedProject = currentProject[indexPath.row]
            destination.index = indexPath.row
            destination.nameMilestone = milestone[indexPath.row].milestoneName
            destination.deadlineMilestone = milestone[indexPath.row].deadline
            destination.milestoneColor = milestone[indexPath.row].color
            destination.milestone = milestone
//            destination.delegate = self
            destination.nameProject = currentProject[indexPath.row].projectName
            destination.clientName = currentProject[indexPath.row].clientName
            destination.deadlineProject = formatDate(input: currentProject[indexPath.row].deadline!)
            destination.isCompleted = milestone[indexPath.row].isCompleted

        }

        self.navigationController?.pushViewController(destination, animated: true)

//    }


//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 91
    }

}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
               value: NSUnderlineStyle.single.rawValue,
                   range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
}
