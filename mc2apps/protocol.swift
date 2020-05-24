//
//  protocol.swift
//  mc2apps
//
//  Created by danny santoso on 21/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import Foundation



protocol textfieldSetting {
    func configurePlaceHolder()
    func dismissKeyboard()
    func returnKeyboard()
    
}

protocol datePickerTextfield {
    func showDatePicker()
    func onChangeValueDatePicker()
}

protocol BackHandler {
    func onBackHome()
}

protocol ReceiveData {
    func onReceiveData(color: String)
}
