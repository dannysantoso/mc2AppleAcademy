//
//  TaskViewController.swift
//  mc2apps
//
//  Created by danny santoso on 18/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController, BackHandler, ReceiveData {
    

    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var btnAddTask: UIButton!
    
    @IBOutlet weak var milestoneNameLabel: UILabel!
    @IBOutlet weak var deadlineMilestoneLabel: UILabel!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var taskTableView: UITableView!
    
    var task = [Task](){
        didSet{
            taskTableView.reloadData()
        }
    }
    
    var milestone = [Milestone]()
    
    var delegate: BackHandler?
    var selectedMilestone: Milestone?
    var selectedProject: Project?
    var index: Int?
    var isCompleted: Bool?
    
    var nameProject: String?
    var nameMilestone: String?
    var deadlineProject: String?
    var deadlineMilestone: Date?
    var clientName: String?
    var milestoneColor: String?
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var endView: UIButton!
    var editBarButtonItem = UIBarButtonItem()
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.delegate?.onBackHome()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboard()
        
        
        editBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editMilestone))
        self.navigationItem.rightBarButtonItem  = editBarButtonItem
        
        projectNameLabel.text = nameProject
        clientNameLabel.text = clientName
        deadlineLabel.text = deadlineProject
        milestoneNameLabel.text = nameMilestone
        deadlineMilestoneLabel.text = formatDate(input: deadlineMilestone!)
        
        
        addView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]  //ini mengatur radius corner hanya untuk atas kiri dan bawah
        addView.layer.cornerRadius = 13
        endView.layer.cornerRadius = 14
    
//        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        if isCompleted == true{
            endView.isHidden = true
            editBarButtonItem.isEnabled = false
            editBarButtonItem.tintColor = .clear
            btnAddTask.isEnabled = false
        }
        
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        headerView.layer.cornerRadius = 24
        
        
        colorHeader(color: milestoneColor ?? "purple")
        
        task = Task.fetchQuery(viewContext: getViewContext(), selectedMilestone: (selectedMilestone?.milestoneName)!, selectedProject: (selectedProject?.projectName)!)
        
        taskTableView.dataSource = self
        taskTableView.delegate = self
        
        taskTableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskCell")

    }
    
    func dismissKeyboard(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(){
        self.view.endEditing(true)
    }
    
    
    func formatDate(input: Date) -> String {
        let formater = DateFormatter()
        formater.dateFormat = "MMMM dd, yyyy"
        return formater.string(from: input)
    }
    
    @objc func editMilestone(){
        let destination = AddMilestoneViewController(nibName: "AddMilestoneViewController", bundle: nil)
        
        destination.nameMilestone = nameMilestone
        destination.dateDeadline = deadlineMilestone
        destination.color = milestoneColor!
        destination.indexMilestone = index!
        destination.isEdit = true
        destination.milestone = milestone
        destination.delegateData = self
        
        
        self.present(destination, animated: true, completion: nil)
        
    }
    
    @IBAction func addTask(_ sender: Any) {
        let newTask = Task.save(viewContext: self.getViewContext(), taskName: "", selectedMilestone: selectedMilestone!, isChecklist: false)
        
        task.append(newTask!)
        taskTableView.reloadData()
    }
    
    func colorHeader(color: String){
        switch color {
        case "purple":
            headerView.layer.backgroundColor = UIColor(red: 0.722, green: 0.69, blue: 0.996, alpha: 1).cgColor
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.722, green: 0.69, blue: 0.996, alpha: 1)
        case "green":
            headerView.layer.backgroundColor = UIColor(red: 0.596, green: 0.816, blue: 0.369, alpha: 1).cgColor
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.596, green: 0.816, blue: 0.369, alpha: 1)
        case "blue":
            headerView.layer.backgroundColor = UIColor(red: 0.486, green: 0.784, blue: 1, alpha: 1).cgColor
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.486, green: 0.784, blue: 1, alpha: 1)
        case "orange":
            headerView.layer.backgroundColor = UIColor(red: 0.992, green: 0.753, blue: 0.333, alpha: 1).cgColor
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.992, green: 0.753, blue: 0.333, alpha: 1)
        default:
            headerView.layer.backgroundColor = UIColor(red: 0.722, green: 0.69, blue: 0.996, alpha: 1).cgColor
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.722, green: 0.69, blue: 0.996, alpha: 1)
        }
    }
    
    @IBAction func endMilestone(_ sender: Any) {
        Milestone.isCompleted(viewContext: self.getViewContext(), isCompleted: true, milestone:milestone, indexMilestone: index!)
        endView.isHidden = true
        editBarButtonItem.isEnabled = false
        editBarButtonItem.tintColor = .clear
        btnAddTask.isEnabled = false
    }
    
    func onBackHome() {
        
    }
    
    func onReceiveData(color: String, name: String, date: Date, client: String, reward: String){
        colorHeader(color: color)
        milestoneColor = color
        nameMilestone = name
        milestoneNameLabel.text = name
        deadlineMilestone = date
        deadlineLabel.text = formatDate(input: date)
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
        cell.isChecklist = task[indexPath.row].isChecklist
        cell.isCompleted = isCompleted
        cell.taskName.delegate = self
        
        
        
        if task[indexPath.row].isChecklist == true {
            cell.checklist.backgroundColor = UIColor.black
            print("true")
        }else{
            cell.checklist.backgroundColor = .clear
            print("false")
        }
        
        return cell
    }
}


extension TaskViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}


