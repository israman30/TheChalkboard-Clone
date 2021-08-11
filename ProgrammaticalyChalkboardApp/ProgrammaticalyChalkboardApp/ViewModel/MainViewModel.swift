//
//  MainViewModel.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 8/11/21.
//  Copyright © 2021 Israel Manzo. All rights reserved.
//

import UIKit

class MainViewModel {
    
    // MARK: - db model
    let persistLisToDefaults = Model.shared
    
    // MARK: - Add list function with db and re-set textField - if input textField is empty, alert user.
    func add(tableView: UITableView, textField: UITextField, vc: UIViewController) {
        guard let listText = textField.text else {return}
        if !listText.isEmpty {
            addNewList(for: listText)
            persistLisToDefaults.persistListToDefaults()
            textField.text = ""
            
            tableView.reloadData()
            textField.resignFirstResponder()
        } else {
            AlertController.alert(vc, title: "Error 4☠️4!", message: "Not list entered")
        }
    }
    
    // MARK: - Add new list listener - create new object and add into the List array + create a new indx for each list.
    private func addNewList(for listText: String) {
        let lists = List(title: listText)
        myLists.append(lists)
        selectedListIndex = myLists.count
    }
}
