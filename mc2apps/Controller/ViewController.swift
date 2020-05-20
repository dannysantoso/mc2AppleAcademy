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
}


extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectTableViewCell

        cell.projectName?.text = projects[indexPath.row].projectName
        cell.clientName?.text = projects[indexPath.row].clientName
        
        let formater = DateFormatter()
        formater.dateFormat = "MMMM dd, yyyy"
        let deadline = formater.string(from: projects[indexPath.row].deadline!)
        cell.deadline?.text = deadline


        return cell

        
    }
}

extension ViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = MilestoneViewController(nibName: "MilestoneViewController", bundle: nil)

        if let indexPath = projectTableView.indexPathForSelectedRow {
            destination.selectedProject = projects[indexPath.row]
        }

        // Push/mendorong view controller lain
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}


