//
//  TaskViewController.swift
//  mc2apps
//
//  Created by danny santoso on 18/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet weak var taskTableView: UITableView!
    
    var task = [Task](){
        didSet{
            taskTableView.reloadData()
        }
    }
    
    var selectedMilestone: Milestone?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        task = Task.fetchQuery(viewContext: getViewContext(), selectedMilestone: (selectedMilestone?.milestoneName)!)
        
        taskTableView.dataSource = self
        
        taskTableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskCell")

    }
    @IBAction func addTask(_ sender: Any) {
        let newTask = Task.save(viewContext: self.getViewContext(), taskName: "hahaa", selectedMilestone: selectedMilestone!)
        task.append(newTask!)
        taskTableView.reloadData()
    }
}


extension TaskViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell

        cell.taskName?.text = task[indexPath.row].taskName
        cell.indexTask =  indexPath.row
        cell.task = task
        
        return cell
    }
    
    
}
