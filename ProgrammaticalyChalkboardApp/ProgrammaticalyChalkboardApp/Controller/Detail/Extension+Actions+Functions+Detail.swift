//
//  Extension+Actions+Functions+Detail.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 8/27/18.
//  Copyright © 2018 Israel Manzo. All rights reserved.
//

import UIKit
import UserNotifications

extension DetailController {
    // MARK: - Create date picker function + tool bar with done button
    func createDatePicker(){
        datePicker.datePickerMode = .dateAndTime
        datePicker.setValue(UIColor.white, forKey: "textColor")
        datePicker.backgroundColor = .black
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.barTintColor = .black
        
        let doneTapped = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(barButtonDoneTapped))
        toolBar.setItems([doneTapped], animated: true)
        doneTapped.tintColor = .white
        
        dateLabel.inputAccessoryView = toolBar
        dateLabel.inputView = datePicker
    }
    //MARK: - Date format for done tapped button on tool bar for date picker
    @objc func barButtonDoneTapped(){
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short

        dateLabel.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    // MARK: - BAR ITEM ACTION - SAVING INPUT
    @objc func saveDetail(){
        
        guard let detail = textView.text,
              let dateDetail = dateLabel.text else {return}
        
        if !detail.isEmpty || !dateDetail.isEmpty {
            selectedTask?.detail = detail
            selectedTask?.date = dateDetail
            detailPersistDefaults.persistListToDefaults()
            savingDataDetailAlertMsg()
            notifications(for: datePicker.date)
        } else {
            AlertController.alert(self, title: "☠️", message: "Enter a detail please")
        }
    }
    
    // Sub.MARK: - Saving info alarm message function
    func savingDataDetailAlertMsg(){
        AlertController.alert(self, title: "Bingo..👍", message: "You details are saved succesfully!")
    }
    
    // MARK: Keyboard dismiss when touch outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


