//
//  ViewController.swift
//  mc2apps
//
//  Created by danny santoso on 17/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit


class ViewController: UIViewController, BackHandler {

    @IBOutlet weak var projectTableView: UITableView!
    
    
    var projects: [Project] = []{
        didSet{
            projectTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        projects = Project.fetchAll(viewContext: getViewContext())
        
        projectTableView.dataSource = self
        projectTableView.delegate = self
        
        projectTableView.register(UINib(nibName: "ProjectTableViewCell", bundle: nil), forCellReuseIdentifier: "ProjectCell")
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
    
    //function untuk mendapatkan hex color
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


extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectTableViewCell

        cell.projectName?.text = projects[indexPath.row].projectName
        cell.clientName?.text = projects[indexPath.row].clientName
        
        
        //mengambil date dan diformat
        let formater = DateFormatter()
        formater.dateFormat = "MMMM dd, yyyy"
        let deadline = formater.string(from: projects[indexPath.row].deadline!)
        cell.deadline?.text = deadline
        
        //menampilkan warna
        colorCell(color: projects[indexPath.row].color ?? "purple", cell: cell)
        cell.selectionStyle = .none

        //mengatur spacing antar cell serta radius corner cell
        let maskLayer = CAShapeLayer()
        maskLayer.cornerRadius = 13
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height-20)
        cell.layer.mask = maskLayer
                
        return cell

        
    }
}

extension ViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = MilestoneViewController(nibName: "MilestoneViewController", bundle: nil)

        if let indexPath = projectTableView.indexPathForSelectedRow {
            destination.selectedProject = projects[indexPath.row]
            destination.nameProject = projects[indexPath.row].projectName
            destination.nameClient = projects[indexPath.row].clientName
            let formater = DateFormatter()
            formater.dateFormat = "MMMM dd, yyyy"
            let deadline = formater.string(from: projects[indexPath.row].deadline!)
            destination.deadline = deadline
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


