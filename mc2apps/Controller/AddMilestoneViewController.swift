//
//  AddMilestoneViewController.swift
//  mc2apps
//
//  Created by danny santoso on 18/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit


class AddMilestoneViewController: UIViewController, textfieldSetting, datePickerTextfield {

    
    @IBOutlet weak var titleMilestone: UILabel!
    @IBOutlet weak var milestoneName: UITextField!
    @IBOutlet weak var deadline: UITextField!
    @IBOutlet weak var orangeButtonOutlet: UIButton!
    @IBOutlet weak var greenButtonOutlet: UIButton!
    @IBOutlet weak var blueButtonOutlet: UIButton!
    @IBOutlet weak var purpleButtonOutlet: UIButton!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var randomButtonOutlet: UIButton!
    
    var delegate: BackHandler?
    var delegateData: ReceiveData?
    var selectedProject: Project?
    var datePicker = UIDatePicker()
    var color = ""
    var isEdit = false
    
    var milestone = [Milestone]()
    var nameMilestone: String?
    var dateDeadline: Date?
    var indexMilestone = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        milestoneName.layer.cornerRadius = 13
        milestoneName.layer.backgroundColor = UIColor.white.cgColor
        milestoneName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.milestoneName.frame.height))
        milestoneName.leftViewMode = UITextField.ViewMode.always
        
        deadline.layer.cornerRadius = 13
        deadline.layer.backgroundColor = UIColor.white.cgColor
        deadline.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.deadline.frame.height))
        deadline.leftViewMode = UITextField.ViewMode.always
        
        let buttonColor:[UIButton] = [orangeButtonOutlet, greenButtonOutlet, blueButtonOutlet, purpleButtonOutlet]
        
        for item in buttonColor {
            item.layer.cornerRadius = item.bounds.size.width/2
            item.layer.borderWidth = 4
            item.layer.borderColor = UIColor.clear.cgColor
        }
        print(color)
        
        randomButtonOutlet.layer.cornerRadius = randomButtonOutlet.bounds.size.height/2
        
        if isEdit == true {
            titleMilestone.text = "Edit Milestone"
            milestoneName.text = nameMilestone
            
            let formater = DateFormatter()
            formater.dateFormat = "MMMM d, yyyy"
            datePicker.date = dateDeadline!
            deadline.text = formater.string(from: datePicker.date)
            
            
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
        
        configurePlaceHolder()
        showDatePicker()
        dismissKeyboard()
        returnKeyboard()
        onChangeValueDatePicker()
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
            color = "purple"
            purpleButtonOutlet.layer.borderColor = UIColor.white.cgColor
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
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        print(indexMilestone)
        if isEdit == true{
            if Milestone.update(viewContext: self.getViewContext(), milestoneName: milestoneName.text ?? "", milestone: milestone, indexMilestone: indexMilestone, deadline: datePicker.date, color: color) != nil{
                dismiss(animated: true, completion: nil)
                self.delegateData?.onReceiveData(color: color, name: milestoneName.text ?? "", date: datePicker.date, client: "", reward: "")
                    
            }
        }else{
            if Milestone.save(viewContext: self.getViewContext(), milestoneName: milestoneName.text ?? "", selectedProject: selectedProject!, deadline: datePicker.date, color: color, isCompleted: false) != nil{
                dismiss(animated: true, completion: nil)
                    self.delegate?.onBackHome()
            }
        }

    }
    
    
    //mengatur textfield placeholder pada deadline textfield
    func configurePlaceHolder(){
        let formater = DateFormatter()
        formater.dateFormat = "MMMM dd, yyyy"
        deadline.placeholder = formater.string(from: Date())
    }
    
    //ketika return diketik maka akan close keypad, fungsi lainnya ada diextension
    func returnKeyboard(){
        milestoneName.delegate = self
    }
    
    //ketika view ditap close keypad
    func dismissKeyboard(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(){
        self.view.endEditing(true)
    }
    
    //mendapatkan data date ketika diubah tanggalnya
    func onChangeValueDatePicker(){
        datePicker.addTarget(self, action: #selector(datePickerChanged(datePicker:)), for: .valueChanged)
    }
    
    @objc func datePickerChanged(datePicker: UIDatePicker) {
        let formater = DateFormatter()
        formater.dateFormat = "MMMM dd, yyyy"
        deadline.text = formater.string(from: datePicker.date)
    }
    
    
    //menampilkan datepicker dalam keypad
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
    
    func clearColorBorder() {
        purpleButtonOutlet.layer.borderColor = UIColor.clear.cgColor
        blueButtonOutlet.layer.borderColor = UIColor.clear.cgColor
        greenButtonOutlet.layer.borderColor = UIColor.clear.cgColor
        orangeButtonOutlet.layer.borderColor = UIColor.clear.cgColor
    }
    
    func isSaveEnable() {
        if milestoneName.text != "" && deadline.text != "" && color != "" {
            saveButtonOutlet.alpha = 1
            saveButtonOutlet.isEnabled = true
        } else {
            saveButtonOutlet.alpha = 0.5
            saveButtonOutlet.isEnabled = false
        }
    }
    @IBAction func tfMilestoneName(_ sender: Any) {
        isSaveEnable()
    }
    
    @IBAction func tfDeadline(_ sender: Any) {
        isSaveEnable()
    }
}
