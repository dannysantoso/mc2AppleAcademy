//
//  AddMilestoneViewController.swift
//  mc2apps
//
//  Created by danny santoso on 18/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit


class AddMilestoneViewController: UIViewController, textfieldSetting, datePickerTextfield {

    @IBOutlet weak var milestoneName: UITextField!
    @IBOutlet weak var deadline: UITextField!
    
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
            color = "purple"
        }
    }
    
    @IBAction func purpleButton(_ sender: Any) {
        color = "purple"
    }
    @IBAction func blueButton(_ sender: Any) {
        color = "blue"
    }
    @IBAction func greenButton(_ sender: Any) {
        color = "green"
    }
    @IBAction func orangeButton(_ sender: Any) {
        color = "orange"
    }
    
    
    @IBAction func save(_ sender: Any) {
        if Milestone.save(viewContext: self.getViewContext(), milestoneName: milestoneName.text ?? "", selectedProject: selectedProject!, deadline: datePicker.date, color: color, isCompleted: false) != nil{
            dismiss(animated: true, completion: nil)
                self.delegate?.onBackHome()
        }

    }
    
    
    
    func configurePlaceHolder(){
        let formater = DateFormatter()
        formater.dateFormat = "MMMM dd, yyyy"
        deadline.placeholder = formater.string(from: Date())
    }
    
    
    func returnKeyboard(){
        milestoneName.delegate = self
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
    
}
