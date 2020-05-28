//
//  MilestoneViewController.swift
//  mc2apps
//
//  Created by danny santoso on 17/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit
import CoreData

class MilestoneViewController: UIViewController, BackHandler, ReceiveData {
    
    @IBAction func toEditButton(_ sender: UIButton) {
        let destination = AddProjectViewController(nibName: "AddProjectViewController", bundle: nil)
        
        
        destination.delegate = self
        destination.selectedProject = self.selectedProject
        destination.indexProject = self.indexProject
        destination.listOfProjects = self.listOfProjects
        
        self.present(destination, animated: true, completion: nil)
    }
    
    @IBOutlet weak var milestoneTableView: UITableView!
    @IBOutlet weak var bgImage: UIImageView!
    
    var milestone = [Milestone]()
    
    var milestoneCheck = [Milestone]()
    
    @IBOutlet weak var endProject: UIButton!
    @IBOutlet weak var nameProjectLabel: UILabel!
    @IBOutlet weak var nameClientLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet var tapGestureMilestone: UITapGestureRecognizer!
    
    var nameProject: String?
    var nameClient: String?
    var deadline: Date?
    var rewardProject: String?
    var isCompleted = false
    var delegateViewController: BackHandler?
    var colorProject: String?
    var completionReward: String?
    
    var indexProject: Int?
    var selectedProject : Project?
    var listOfProjects : [Project] = []
//    var milestoneCompleted = false
    
    var editBarButtonItem = UIBarButtonItem()
    

    override func viewWillDisappear(_ animated: Bool) {
        self.delegateViewController?.onBackHome()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if milestone.count == 0 {
            milestoneTableView.isHidden = true
            bgImage.isHidden = false
        }else{
            milestoneTableView.isHidden = false
            bgImage.isHidden = true
        }
        
        endProject.layer.cornerRadius = 14
        
        editBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editProject))
        self.navigationItem.rightBarButtonItem  = editBarButtonItem
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        btnAdd.isEnabled = false
        if btnAdd.isEnabled == false {
            btnAdd.tintColor = UIColor(red: 256, green: 256, blue: 256, alpha: 1)
        }
        
        
        if isCompleted == true {
            endProject.isHidden = true
            editBarButtonItem.isEnabled = false
            editBarButtonItem.tintColor = .clear
            tapGestureMilestone.isEnabled = false
        }
        
        milestone = Milestone.fetchQuery(viewContext: getViewContext(), selectedProject: (selectedProject?.projectName)!)
        milestoneTableView.reloadData()
        
        nameProjectLabel.text = nameProject
        nameClientLabel.text = nameClient
        deadlineLabel.text = formatDate(input: deadline!)
        addView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]  //ini mengatur radius corner hanya untuk atas kiri dan bawah
        addView.layer.cornerRadius = 13
        
        
        milestoneTableView.dataSource = self
        milestoneTableView.delegate = self
        milestoneTableView.register(UINib(nibName: "MilestoneTableViewCell", bundle: nil), forCellReuseIdentifier: "MilestoneCell")
    }
    
    @objc func editProject(){
        let destination = AddProjectViewController(nibName: "AddProjectViewController", bundle: nil)
        
        destination.nameProject = nameProject
        destination.nameClient = nameClient
        destination.deadlineProject = deadline
        destination.color = colorProject
        destination.indexProject = indexProject
        destination.isEdit = true
        destination.listOfProjects = listOfProjects
        destination.delegateData = self
        destination.completionReward = completionReward
        
        
        self.present(destination, animated: true, completion: nil)
    }
    
    @IBAction func addMilestone(_ sender: Any) {
        let destination = AddMilestoneViewController(nibName: "AddMilestoneViewController", bundle: nil)
        
        
        destination.delegate = self
        destination.selectedProject = self.selectedProject
        
        
        self.present(destination, animated: true, completion: nil)
    }
    
    
    func onBackHome() {
        milestone = Milestone.fetchQuery(viewContext: getViewContext(), selectedProject: (selectedProject?.projectName)!)
        
        if milestone.count == 0 {
            milestoneTableView.isHidden = true
            bgImage.isHidden = false
        }else{
            milestoneTableView.isHidden = false
            bgImage.isHidden = true
        }
        
        milestoneTableView.reloadData()
    }
    
    func onReceiveData(color: String, name: String, date: Date, client: String, reward: String){
        nameProject = name
        nameProjectLabel.text = name
        deadline = date
        deadlineLabel.text = formatDate(input: date)
        nameClient = client
        nameClientLabel.text = client
        colorProject = color
    }
    
    //mendapatkan warna cell dari data yang disimpan
    func colorCell(color: String, cell: MilestoneTableViewCell){
        switch color {
        case "purple":
            cell.milestoneView.layer.backgroundColor = UIColor(red: 0.722, green: 0.69, blue: 0.996, alpha: 1).cgColor
//            cell.milestoneView.layer.backgroundColor = hexStringToUIColor(hex: "B8B0FE").cgColor
        case "green":
            cell.milestoneView.layer.backgroundColor = UIColor(red: 0.596, green: 0.816, blue: 0.369, alpha: 1).cgColor
//            cell.milestoneView.layer.backgroundColor = hexStringToUIColor(hex: "86D349").cgColor
        case "blue":
            cell.milestoneView.layer.backgroundColor = UIColor(red: 0.486, green: 0.784, blue: 1, alpha: 1).cgColor
//            cell.milestoneView.backgroundColor = hexStringToUIColor(hex: "7CC8FF").cgColor
        case "orange":
            cell.milestoneView.layer.backgroundColor = UIColor(red: 0.992, green: 0.753, blue: 0.333, alpha: 1).cgColor
//            cell.milestoneView.layer.backgroundColor = hexStringToUIColor(hex: "FDC055").cgColor
        default:
            cell.milestoneView.layer.backgroundColor = UIColor(red: 0.722, green: 0.69, blue: 0.996, alpha: 1).cgColor
//            cell.milestoneView.layer.backgroundColor = hexStringToUIColor(hex: "B8B0FE").cgColor
        }
    }

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
    @IBAction func endProject(_ sender: Any) {
        if checkMilestone() == true {
            let alert = UIAlertController(title: nil, message: "Are you sure you want to end this project?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "End", style: .default) { _ in
                let destination = CompleteViewController(nibName: "CompleteViewController", bundle: nil)
                destination.sourceIndex = 2
                destination.projectReward = self.rewardProject
                self.navigationController?.pushViewController(destination, animated: true)
                
                Project.isCompleted(viewContext: self.getViewContext(), isCompleted: true, project:self.listOfProjects, indexProject: self.indexProject!)
                self.endProject.isHidden = true
            })
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }else{
            print("there is a milestone that is not completed")
        }
    }
    
    func formatDate(input: Date) -> String {
        let formater = DateFormatter()
        formater.dateFormat = "MMMM d, yyyy"
        return formater.string(from: input)
    }
    
    func checkMilestone()-> Bool{
        var value = false
        
        milestoneCheck = Milestone.fetchQuery(viewContext: getViewContext(), selectedProject: (selectedProject?.projectName)!)
        
        var complete = 0
        for item in milestoneCheck {
            if item.isCompleted == true {
                complete += 1
            }
        }
        if complete != 0 {
            if complete == milestoneCheck.count {
                print(milestoneCheck.count)
                print(complete)
                value = true
            }else{
                value = false
            }
        }else{
            value = false
        }
        return value
    }
}


extension MilestoneViewController: UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if milestone.count == 0 {
                milestoneTableView.isHidden = true
                bgImage.isHidden = false
                return 0
            }else{
                milestoneTableView.isHidden = false
                bgImage.isHidden = true
                return milestone.count
            }
            
            
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            let cell = tableView.dequeueReusableCell(withIdentifier: "MilestoneCell", for: indexPath) as! MilestoneTableViewCell
            cell.milestoneName?.text = milestone[indexPath.row].milestoneName
            
            //menampilkan date format
            let formater = DateFormatter()
            formater.dateFormat = "MMMM d, yyyy"
            let deadline = formater.string(from: milestone[indexPath.row].deadline!)
            cell.milestoneDeadline?.text = deadline
            
            if milestone[indexPath.row].isCompleted == true{
                cell.milestoneView.alpha = 0.5
                cell.deleteButton.isHidden = true
            }
            

            //setting color
            colorCell(color: milestone[indexPath.row].color ?? "purple", cell: cell)
            cell.selectionStyle = .none
            
            cell.numberLabel.text = String(indexPath.row + 1)
            
            cell.delegate = self
            
            cell.isCompleted = milestone[indexPath.row].isCompleted
            
            
            
            
            
//            let maskLayer = CAShapeLayer()
            cell.milestoneView.layer.cornerRadius = 13
            cell.milestoneView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]  //ini mengatur radius corner hanya untuk atas kiri dan bawah kiri
//            maskLayer.backgroundColor = UIColor.black.cgColor
//            maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height-20)
//            cell.layer.mask = maskLayer
            
            cell.indexMilestone =  indexPath.row
            cell.milestone = milestone
            
            
            return cell

        }
    
}

extension MilestoneViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = TaskViewController(nibName: "TaskViewController", bundle: nil)

        if let indexPath = milestoneTableView.indexPathForSelectedRow {
            destination.selectedMilestone = milestone[indexPath.row]
            destination.selectedProject = selectedProject
            destination.index = indexPath.row
            destination.nameMilestone = milestone[indexPath.row].milestoneName
            destination.deadlineMilestone = milestone[indexPath.row].deadline
            destination.milestoneColor = milestone[indexPath.row].color
            destination.milestone = milestone
            destination.delegate = self
            destination.nameProject = nameProject
            destination.clientName = nameClient
            destination.deadlineProject = formatDate(input: deadline!)
            //                formatDate(input: deadline)
            destination.isCompleted = milestone[indexPath.row].isCompleted
        
        }

        self.navigationController?.pushViewController(destination, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 91
    }
    
}



