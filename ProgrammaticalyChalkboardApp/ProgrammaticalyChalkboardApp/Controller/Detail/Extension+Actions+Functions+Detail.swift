//
//  Extension+Actions+Functions+Detail.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 8/27/18.
//  Copyright © 2018 Israel Manzo. All rights reserved.
//

import UIKit

extension DetailVC {
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
        guard let detail = textView.text else {return}
        guard let dateDetail = dateLabel.text else {return}
        
        if !detail.isEmpty || !dateDetail.isEmpty {
            selectedTask?.detail = detail
            selectedTask?.date = dateDetail
            detailPersistDefaults.persistListToDefaults()
            savingDataDetailAlertMsg()
        } else {
            let alert = UIAlertController(title: "☠️", message: "Enter a description please", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    // Sub.MARK: - Saving info alarm message function
    func savingDataDetailAlertMsg(){
        let alert = UIAlertController(title: "Bingo..👍", message: "You details are saved succesfully!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Keyboard dismiss when touch outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
