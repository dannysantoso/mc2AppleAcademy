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
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var titlePage: UILabel!
    
    var delegate: BackHandler?
    var indexProject: Int?
    var selectedProject: Project?
    var listOfProjects: [Project] = []
    let datePicker = UIDatePicker()
    var color: String?
    var isEdit: Bool?
    var delegateData: ReceiveData?
    
    var nameMilestone: String?
    var dateDeadline: Date?
    var indexMilestone = 0
    
    var nameProject: String?
    var nameClient: String?
    var deadlineProject: Date?
    var completionReward: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePlaceHolder()
        showDatePicker()
        dismissKeyboard()
        returnKeyboard()
        onChangeValueDatePicker()
        customTextField()
//        // populate selected project for edit
//        if let projectToPopulate = selectedProject {
//            populateProject(project: projectToPopulate)
//            titlePage.text = "Edit Project"
//        }
        
        if isEdit == true{
            titlePage.text = "Edit Project"
            projectName.text = nameProject
            clientName.text = nameClient
            
            let formater = DateFormatter()
            formater.dateFormat = "MMMM d, yyyy"
            datePicker.date = deadlineProject!
            deadline.text = formater.string(from: datePicker.date)
            
            projectCompletionReward.text = completionReward
            
            switch color {
            case "purple":
                purpleButtonOutlet.layer.borderColor = UIColor(red: 0.984, green: 0.584, blue: 0.576, alpha: 1).cgColor
            case "blue":
                blueButtonOutlet.layer.borderColor = UIColor(red: 0.984, green: 0.584, blue: 0.576, alpha: 1).cgColor
            case "green":
                greenButtonOutlet.layer.borderColor = UIColor(red: 0.984, green: 0.584, blue: 0.576, alpha: 1).cgColor
            case "orange":
                orangeButtonOutlet.layer.borderColor = UIColor(red: 0.984, green: 0.584, blue: 0.576, alpha: 1).cgColor
            default:
                purpleButtonOutlet.layer.borderColor = UIColor(red: 0.984, green: 0.584, blue: 0.576, alpha: 1).cgColor
            }
        }
        isSaveEnable()
    }
    
    @IBAction func randomButton(_ sender: Any) {
        clearColorBorder()
        let randomInt = Int.random(in: 1...4)
        switch randomInt {
        case 1:
            color = "purple"
            purpleButtonOutlet.layer.borderColor = UIColor.white.cgColor
        case 2:
            color = "blue"
            blueButtonOutlet.layer.borderColor = UIColor.white.cgColor
        case 3:
            color = "green"
            greenButtonOutlet.layer.borderColor = UIColor.white.cgColor
        case 4:
            color = "orange"
            orangeButtonOutlet.layer.borderColor = UIColor.white.cgColor
        default:
            color = "orange"
            orangeButtonOutlet.layer.borderColor = UIColor.white.cgColor
        }
        isSaveEnable()
    }
    
    @IBAction func purpleButton(_ sender: Any) {
        color = "purple"
        clearColorBorder()
        purpleButtonOutlet.layer.borderColor = UIColor.white.cgColor
        isSaveEnable()
    }
    @IBAction func blueButton(_ sender: Any) {
        color = "blue"
        clearColorBorder()
        blueButtonOutlet.layer.borderColor = UIColor.white.cgColor
        isSaveEnable()
    }
    @IBAction func greenButton(_ sender: Any) {
        color = "green"
        clearColorBorder()
        greenButtonOutlet.layer.borderColor = UIColor.white.cgColor
        isSaveEnable()
    }
    @IBAction func orangeButton(_ sender: Any) {
        color = "orange"
        clearColorBorder()
        orangeButtonOutlet.layer.borderColor = UIColor.white.cgColor
        isSaveEnable()
    }
    
    // custom text field
    func customTextField() {
        projectName.layer.cornerRadius = 13
        projectName.layer.backgroundColor = UIColor.white.cgColor
        projectName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.projectName.frame.height))
        projectName.leftViewMode = UITextField.ViewMode.always
        clientName.layer.cornerRadius = 13
        clientName.layer.backgroundColor = UIColor.white.cgColor
        clientName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.clientName.frame.height))
        clientName.leftViewMode = UITextField.ViewMode.always
        deadline.layer.cornerRadius = 13
        deadline.layer.backgroundColor = UIColor.white.cgColor
        deadline.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.deadline.frame.height))
        deadline.leftViewMode = UITextField.ViewMode.always
        projectCompletionReward.layer.cornerRadius = 13
        projectCompletionReward.layer.backgroundColor = UIColor.white.cgColor
        projectCompletionReward.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.projectCompletionReward.frame.height))
        projectCompletionReward.leftViewMode = UITextField.ViewMode.always
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        // make sure the result is under 15 characters
        return updatedText.count <= 15
    }
    
    // clear chosen color border
    func clearColorBorder() {
        purpleButtonOutlet.layer.borderColor = UIColor.clear.cgColor
        blueButtonOutlet.layer.borderColor = UIColor.clear.cgColor
        greenButtonOutlet.layer.borderColor = UIColor.clear.cgColor
        orangeButtonOutlet.layer.borderColor = UIColor.clear.cgColor
    }
    
    func isSaveEnable() {
        if projectName.text != "" && clientName.text != "" && deadline.text != "" && projectCompletionReward.text != "" && color != "" {
            saveButtonOutlet.alpha = 1
            saveButtonOutlet.isEnabled = true
        } else {
            saveButtonOutlet.alpha = 0.5
            saveButtonOutlet.isEnabled = false
        }
    }
    
    func configurePlaceHolder(){
        let formater = DateFormatter()
        formater.dateFormat = "MMMM d, yyyy"
        deadline.placeholder = formater.string(from: Date())
    }
    
    //ketika return diketik close keypad, fungsi lainnya ada diextension
    func returnKeyboard(){
        projectName.delegate = self
        clientName.delegate = self
        projectCompletionReward.delegate = self
        isSaveEnable()
    }
    
    //ketika view ditap close keypad
    func dismissKeyboard(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        isSaveEnable()
    }
    
    @objc func handleTap(){
        self.view.endEditing(true)
        isSaveEnable()
    }
    
    //mengambil data date ketika datepicker berubah
    func onChangeValueDatePicker(){
        datePicker.addTarget(self, action: #selector(datePickerChanged(datePicker:)), for: .valueChanged)
        isSaveEnable()
    }
    
    @objc func datePickerChanged(datePicker: UIDatePicker) {
        let formater = DateFormatter()
        formater.dateFormat = "MMMM d, yyyy"
        deadline.text = formater.string(from: datePicker.date)
    }
    
    
    //menampilkan datepicker pada keypad
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
        formater.dateFormat = "MMMM d, yyyy"
        deadline.text = formater.string(from: datePicker.date)
        self.view.endEditing(true)
        isSaveEnable()
    }
    
    @objc func cancelPressed(){
        self.view.endEditing(true)
        isSaveEnable()
    }
    
    
    // populate the project data
    func populateProject(project: Project) {
        projectName.text = project.projectName
        clientName.text = project.clientName
        if let date = project.deadline {
            deadline.text = dateFormat(date: date)
        }
        projectCompletionReward.text = project.projectCompletionReward
        color = project.color!
        switch color {
        case "purple":
            purpleButtonOutlet.layer.borderColor = UIColor(red: 0.984, green: 0.584, blue: 0.576, alpha: 1).cgColor
        case "blue":
            blueButtonOutlet.layer.borderColor = UIColor(red: 0.984, green: 0.584, blue: 0.576, alpha: 1).cgColor
        case "green":
            greenButtonOutlet.layer.borderColor = UIColor(red: 0.984, green: 0.584, blue: 0.576, alpha: 1).cgColor
        case "orange":
            orangeButtonOutlet.layer.borderColor = UIColor(red: 0.984, green: 0.584, blue: 0.576, alpha: 1).cgColor
        default:
            clearColorBorder()
        }
    }
    
    func dateFormat(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
    

    @IBAction func save(_ sender: Any) {
        if isEdit == true {
            if (Project.update(viewContext: getViewContext(), projectName: projectName.text ?? "", clientName: clientName.text ?? "", deadline: datePicker.date, color: color!, isCompleted: false, projectCompletionReward: projectCompletionReward.text ?? "", project: listOfProjects, indexProject: indexProject!) != nil){
                    dismiss(animated: true, completion: nil)
                self.delegateData?.onReceiveData(color: color!, name: projectName.text ?? "", date: datePicker.date, client: clientName.text ?? "", reward: projectCompletionReward.text ?? "")
            }
        } else {
            if (Project.save(viewContext: getViewContext(), projectName: projectName.text ?? "", clientName: clientName.text ?? "", deadline: datePicker.date, color: color!, isCompleted: false, projectCompletionReward: projectCompletionReward.text ?? "") != nil){
                    
                    dismiss(animated: true, completion: nil)
                        self.delegate?.onBackHome()
            }
        }
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        self.delegate?.onBackHome()
    }
    
    @IBAction func tfProjectName(_ sender: Any) {
        isSaveEnable()
    }
    
    @IBAction func tfClientName(_ sender: Any) {
        isSaveEnable()
    }
    
    @IBAction func tfDateDeadline(_ sender: Any) {
        isSaveEnable()
    }
    
    @IBAction func tfReward(_ sender: Any) {
        isSaveEnable()
    }
}
