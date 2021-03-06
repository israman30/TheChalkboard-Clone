//
//  Extension+Action+Functions+TaskVC.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 8/27/18.
//  Copyright © 2018 Israel Manzo. All rights reserved.
//

import UIKit

extension TaskController {
    
    // MARK: ADD ITEM ACTION FUNCTION AND RESET INPUT TEXTFIELD
    @objc func addButtonTask(){
        guard let taskText = textField.text else {return}
        
        if !taskText.isEmpty {
            addNewTask(for: taskText)
            persistTaskDefault.persistListToDefaults()
            textField.text = ""
        } else {
            AlertController.alert(self, title: "Error 4☠️4!", message: "Not task entered")
        }
    }
    // MARK: -Add new task listener - creates an object fro task and added to the Items array
    func addNewTask(for taskText: String) {
        let addItem = Items(title: taskText, detail: "", date: "")
        selectedList.items.append(addItem)
        tableView.reloadData()
        textField.resignFirstResponder()
    }
    
    // MARK: Keyboard dismiss when touch outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


