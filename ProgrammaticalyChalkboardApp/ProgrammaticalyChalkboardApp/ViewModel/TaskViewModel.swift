//
//  TaskViewModel.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 8/11/21.
//  Copyright © 2021 Israel Manzo. All rights reserved.
//

import UIKit

class TaskViewModel {
    
    // MARK: Selected list index
    var selectedList: List!
    
    let persistTaskDefault = Model.shared
    
    func addTask(textField: UITextField, tableView: UITableView, vc: UIViewController) {
        guard let taskText = textField.text else { return }
        
        if !taskText.isEmpty {
            addNewTask(for: taskText)
            persistTaskDefault.persistListToDefaults()
            textField.text = ""
            tableView.reloadData()
            textField.resignFirstResponder()
        } else {
            AlertController.alert(vc, title: "Error 4☠️4!", message: "Not task entered")
        }
    }
    
    // MARK: -Add new task listener - creates an object fro task and added to the Items array
    private func addNewTask(for taskText: String) {
        let addItem = Items(title: taskText, detail: "", date: "")
        selectedList.items.append(addItem)
    }
}
