//
//  ViewController.swift
//  mc2apps
//
//  Created by danny santoso on 17/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit


class ViewController: UIViewController, BackHandler {

    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var addButton: UIButton! {
        didSet {
            addButton.layer.cornerRadius = 13
        }
    }
    @IBOutlet weak var segmentSwitch: UISegmentedControl! {
        didSet {
 //           segmentSwitch.layer.cornerRadius = 100
            segmentSwitch.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        }
    }
    @IBOutlet weak var projectTableView: UITableView!
    
    
    var projects: [Project] = []
//    {
//        didSet{
//            projectTableView.reloadData()
//        }
//    }
    
    var completedProjects: [Project] = []
//    {
//        didSet{
//            projectTableView.reloadData()
//        }
//    }

    var selectedSegmentIndex: Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
//        projects = Project.fetchAll(viewContext: getViewContext())
        projects = Project.fetchOngoing(viewContext: getViewContext())
        completedProjects = Project.fetchCompleted(viewContext: getViewContext())

        projectTableView.dataSource = self
        projectTableView.delegate = self

        projectTableView.register(UINib(nibName: "ProjectTableViewCell", bundle: nil), forCellReuseIdentifier: "ProjectCell")
    }
    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        if segmentSwitch.selectedSegmentIndex == 0 {
            projectLabel.text = "List of Projects"
            addButton.isHidden = false
            self.selectedSegmentIndex = 1
        } else {
            projectLabel.text = "Completed Projects"
            addButton.isHidden = true
            self.selectedSegmentIndex = 2
        }
        projectTableView.reloadData()
    }

    
    @IBAction func addProject(_ sender: Any) {
        let destination = AddProjectViewController(nibName: "AddProjectViewController", bundle: nil)
        
        destination.delegate = self
        
        self.present(destination, animated: true, completion: nil)
        
    }
    

    
    func onBackHome() {
        projects = Project.fetchAll(viewContext: getViewContext())
        projectTableView.reloadData()
    }
    
    
    //function untuk mendapatkan color cell sesuai dengan data color yang disimpan
    func colorCell(color: String, cell: ProjectTableViewCell){
        switch color {
        case "purple":
            cell.projectView.layer.backgroundColor = UIColor(red: 0.722, green: 0.69, blue: 0.996, alpha: 1).cgColor
//            cell.layer.backgroundColor = hexStringToUIColor(hex: "B8B0FE").cgColor
        case "green":
            cell.projectView.layer.backgroundColor = UIColor(red: 0.596, green: 0.816, blue: 0.369, alpha: 1).cgColor
//            cell.layer.backgroundColor = hexStringToUIColor(hex: "86D349").cgColor
        case "blue":
            cell.projectView.layer.backgroundColor = UIColor(red: 0.486, green: 0.784, blue: 1, alpha: 1).cgColor
//            cell.layer.backgroundColor = hexStringToUIColor(hex: "7CC8FF").cgColor
        case "orange":
            cell.projectView.layer.backgroundColor = UIColor(red: 0.992, green: 0.753, blue: 0.333, alpha: 1).cgColor
//            cell.layer.backgroundColor = hexStringToUIColor(hex: "FDC055").cgColor
        default:
            cell.projectView.layer.backgroundColor = UIColor(red: 0.722, green: 0.69, blue: 0.996, alpha: 1).cgColor
//            cell.layer.backgroundColor = hexStringToUIColor(hex: "B8B0FE").cgColor
        }
    }
    
    func formatDate(input: Date) -> String {
        let formater = DateFormatter()
        formater.dateFormat = "MMMM dd, yyyy"
        return formater.string(from: input)
    }
    
//    //function untuk mendapatkan hex color
//    func hexStringToUIColor (hex:String) -> UIColor {
//        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//        
//        if (cString.hasPrefix("#")) {
//            cString.remove(at: cString.startIndex)
//        }
//        
//        if ((cString.count) != 6) {
//            return UIColor.gray
//        }
//        
//        var rgbValue:UInt64 = 0
//        Scanner(string: cString).scanHexInt64(&rgbValue)
//        
//        return UIColor(
//            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//            alpha: CGFloat(1.0)
//        )
//    }
}


extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSegmentIndex == 1 {
            return projects.count
        } else {
            return completedProjects.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectTableViewCell

        // if on ongoing, reload data ongoing, else reload completed projects
        if selectedSegmentIndex == 1 {
            cell.projectName?.text = projects[indexPath.row].projectName
            cell.clientName?.text = projects[indexPath.row].clientName
            cell.deadline?.text = formatDate(input: projects[indexPath.row].deadline!)
            colorCell(color: projects[indexPath.row].color ?? "purple", cell: cell)
            cell.selectionStyle = .none
        } else {
            cell.projectName?.text = completedProjects[indexPath.row].projectName
            cell.clientName?.text = completedProjects[indexPath.row].clientName
            cell.deadline?.text = formatDate(input: completedProjects[indexPath.row].deadline!)
            colorCell(color: completedProjects[indexPath.row].color ?? "purple", cell: cell)
            cell.selectionStyle = .none
        }

        //mengatur spacing antar cell serta radius corner cell
        let maskLayer = CAShapeLayer()
        maskLayer.cornerRadius = 13
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height-20)
        cell.layer.mask = maskLayer

        return cell


    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = MilestoneViewController(nibName: "MilestoneViewController", bundle: nil)
        
        if let indexPath = projectTableView.indexPathForSelectedRow {
            if selectedSegmentIndex == 1 {
                destination.selectedProject = projects[indexPath.row]
                destination.nameProject = projects[indexPath.row].projectName
                destination.nameClient = projects[indexPath.row].clientName
                destination.deadline = formatDate(input: projects[indexPath.row].deadline!)
                destination.indexProject = indexPath.row
                destination.listOfProjects = projects
            } else {
                destination.selectedProject = completedProjects[indexPath.row]
                destination.nameProject = completedProjects[indexPath.row].projectName
                destination.nameClient = completedProjects[indexPath.row].clientName
                destination.deadline = formatDate(input: completedProjects[indexPath.row].deadline!)
                destination.indexProject = indexPath.row
                destination.listOfProjects = completedProjects
            }
        }
        
        // Push/mendorong view controller lain
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){(action,view,nil) in
//            
//        }
//        
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//        
//    }
    
    //tinggi dari cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
}


