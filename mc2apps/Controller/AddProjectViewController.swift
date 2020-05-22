//
//  AddProjectViewController.swift
//  mc2apps
//
//  Created by danny santoso on 18/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class AddProjectViewController: UIViewController, textfieldSetting, datePickerTextfield  {

    @IBOutlet weak var projectName: UITextField!
    @IBOutlet weak var clientName: UITextField!
    @IBOutlet weak var deadline: UITextField!
    @IBOutlet weak var projectCompletionReward: UITextField!
    @IBOutlet weak var purpleButtonOutlet: UIButton!
    @IBOutlet weak var blueButtonOutlet: UIButton!
    @IBOutlet weak var greenButtonOutlet: UIButton!
    @IBOutlet weak var orangeButtonOutlet: UIButton!
    
    var delegate: BackHandler?
    var selectedProject: Project?
    let datePicker = UIDatePicker()
    var color = "purple"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePlaceHolder()
        showDatePicker()
        dismissKeyboard()
        returnKeyboard()
        onChangeValueDatePicker()
        if let projectToPopulate = selectedProject {
            populateProject(project: projectToPopulate) // populate selected project
        }
    }
    
    @IBAction func randomButton(_ sender: Any) {
        let randomInt = Int.random(in: 1...4)
        switch randomInt {
        case 1:
            color = "purple"
        case 2:
            color = "blue"
        case 3:
            color = "green"
        case 4:
            color = "orange"
        default:
            color = "orange"
        }
    }
    
    @IBAction func purpleButton(_ sender: Any) {
        color = "purple"
        clearColorBorder()
        purpleButtonOutlet.layer.borderColor = UIColor.systemBlue.cgColor
    }
    @IBAction func blueButton(_ sender: Any) {
        color = "blue"
        clearColorBorder()
        blueButtonOutlet.layer.borderColor = UIColor.systemBlue.cgColor
    }
    @IBAction func greenButton(_ sender: Any) {
        color = "green"
        clearColorBorder()
        greenButtonOutlet.layer.borderColor = UIColor.systemBlue.cgColor
    }
    @IBAction func orangeButton(_ sender: Any) {
        color = "orange"
        clearColorBorder()
        orangeButtonOutlet.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    // clear chosen color border
    func clearColorBorder() {
        purpleButtonOutlet.layer.borderColor = UIColor.clear.cgColor
        blueButtonOutlet.layer.borderColor = UIColor.clear.cgColor
        greenButtonOutlet.layer.borderColor = UIColor.clear.cgColor
        orangeButtonOutlet.layer.borderColor = UIColor.clear.cgColor
    }
    
    
    
    func configurePlaceHolder(){
        let formater = DateFormatter()
        formater.dateFormat = "MMMM dd, yyyy"
        deadline.placeholder = formater.string(from: Date())
    }
    
    
    func returnKeyboard(){
        projectName.delegate = self
        clientName.delegate = self
        projectCompletionReward.delegate = self
    }
    
    
    func dismissKeyboard(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(){
        self.view.endEditing(true)
    }
    
    func onChangeValueDatePicker(){
        datePicker.addTarget(self, action: #selector(datePickerChanged(datePicker:)), for: .valueChanged)
    }
    
    @objc func datePickerChanged(datePicker: UIDatePicker) {
        let formater = DateFormatter()
        formater.dateFormat = "MMMM dd, yyyy"
        deadline.text = formater.string(from: datePicker.date)
    }
    
    
    
    
    
    func showDatePicker(){
        datePicker.datePickerMode = .date
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: true)
        
        //assign toolbar
        deadline.inputAccessoryView = toolbar
        deadline.inputView = datePicker
    }
    
    @objc func donePressed(){
        let formater = DateFormatter()
        formater.dateFormat = "MMMM dd, yyyy"
        deadline.text = formater.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelPressed(){
        self.view.endEditing(true)
    }
    
    
    // populate the project data
    func populateProject(project: Project) {
        projectName.text = project.projectName
        clientName.text = project.clientName
        if let date = project.deadline {
            deadline.text = dateFormat(date: date)
        }
        projectCompletionReward.text = project.projectCompletionReward

    }
    
    func dateFormat(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
    

    @IBAction func save(_ sender: Any) {
        if (Project.save(viewContext: getViewContext(), projectName: projectName.text ?? "", clientName: clientName.text ?? "", deadline: Date(), color: color, isCompleted: false, projectCompletionReward: projectCompletionReward.text ?? "") != nil){
                
                dismiss(animated: true, completion: nil)
                    self.delegate?.onBackHome()
            }
        }
}
