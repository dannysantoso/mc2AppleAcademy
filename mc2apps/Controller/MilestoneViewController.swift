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
    
    @IBAction func toEditButton(_ sender: UIButton) {
        let destination = AddProjectViewController(nibName: "AddProjectViewController", bundle: nil)
        
        // Mengirim data hero
        destination.delegate = self
        destination.selectedProject = self.selectedProject
        destination.indexProject = self.indexProject
        destination.listOfProjects = self.listOfProjects
        
        
        self.present(destination, animated: true, completion: nil)
    }
    
    @IBOutlet weak var milestoneTableView: UITableView!
    
    var milestone = [Milestone]()
    
    @IBOutlet weak var nameProjectLabel: UILabel!
    @IBOutlet weak var nameClientLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var addView: UIView!
    
    var nameProject: String?
    var nameClient: String?
    var deadline: String?
    
    var indexProject: Int?
    var selectedProject : Project?
    var listOfProjects : [Project] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        milestone = Milestone.fetchQuery(viewContext: getViewContext(), selectedProject: (selectedProject?.projectName)!)
        milestoneTableView.reloadData()
        
        nameProjectLabel.text = nameProject
        nameClientLabel.text = nameClient
        deadlineLabel.text = deadline
        addView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]  //ini mengatur radius corner hanya untuk atas kiri dan bawah
        addView.layer.cornerRadius = 13
        
        
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
    
    //mendapatkan warna cell dari data yang disimpan
    func colorCell(color: String, cell: MilestoneTableViewCell){
        switch color {
        case "purple":
            cell.layer.backgroundColor = hexStringToUIColor(hex: "B8B0FE").cgColor
        case "green":
            cell.layer.backgroundColor = hexStringToUIColor(hex: "86D349").cgColor
        case "blue":
            cell.layer.backgroundColor = hexStringToUIColor(hex: "7CC8FF").cgColor
        case "orange":
            cell.layer.backgroundColor = hexStringToUIColor(hex: "FDC055").cgColor
        default:
            cell.layer.backgroundColor = hexStringToUIColor(hex: "B8B0FE").cgColor
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


extension MilestoneViewController: UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return milestone.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            let cell = tableView.dequeueReusableCell(withIdentifier: "MilestoneCell", for: indexPath) as! MilestoneTableViewCell
            cell.milestoneName?.text = milestone[indexPath.row].milestoneName
            
            //menampilkan date format
            let formater = DateFormatter()
            formater.dateFormat = "MMMM dd, yyyy"
            let deadline = formater.string(from: milestone[indexPath.row].deadline!)
            cell.milestoneDeadline?.text = deadline

            //menampilkan warna cell
            colorCell(color: milestone[indexPath.row].color ?? "purple", cell: cell)
            cell.selectionStyle = .none
            
            
            let maskLayer = CAShapeLayer()
            maskLayer.cornerRadius = 13
            maskLayer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]  //ini mengatur radius corner hanya untuk atas kiri dan bawah kiri
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height-20)
            cell.layer.mask = maskLayer
            
            
            
            
            return cell

        }
    
}

extension MilestoneViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = TaskViewController(nibName: "TaskViewController", bundle: nil)

        if let indexPath = milestoneTableView.indexPathForSelectedRow {
            destination.selectedMilestone = milestone[indexPath.row]
            destination.selectedProject = selectedProject
        }

        self.navigationController?.pushViewController(destination, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
}



