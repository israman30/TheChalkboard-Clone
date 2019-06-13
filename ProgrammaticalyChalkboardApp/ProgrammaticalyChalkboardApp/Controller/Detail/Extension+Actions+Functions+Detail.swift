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
            print(datePicker.date)
        } else {
            AlertController.alert(viewController: self, title: "☠️", message: "Enter a detail please")
        }
    }
    
    func notifications(for date: Date){
        // 1. Ask for permission
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // If user no give permissions, let it know go to user settings
            if let error = error {
                print("Error", error)
                return
            }
        }
        guard let title = selectedTask?.title,
              let body = selectedTask?.detail else { return }
        // 2. Add a content
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        // 3. Create a trigger
        
        let dateComponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        // 4. Create a request
        
        let request = UNNotificationRequest(identifier: uidString, content: content, trigger: trigger)
        
        // 5. Register the request
        center.add(request) { (error) in
            // check error
            
        }
    }
    
    // Sub.MARK: - Saving info alarm message function
    func savingDataDetailAlertMsg(){
        AlertController.alert(viewController: self, title: "Bingo..👍", message: "You details are saved succesfully!")
    }
    
    // MARK: Keyboard dismiss when touch outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
