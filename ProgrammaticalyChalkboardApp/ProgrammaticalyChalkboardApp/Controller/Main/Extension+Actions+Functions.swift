//
//  Extension+Actions+Functions.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 8/26/18.
//  Copyright © 2018 Israel Manzo. All rights reserved.
//

import UIKit

/*
  =================== MAIN CONTROLLER EXTENSION - METHODS ===================
 - Add button execute action when user add a new Title list - index.
 - AlertController extension is used to prevent user tap in a empty TextField.
  ============================================================================
 */

extension MainController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func addButton(){
        guard let listText = textField.text else {return}
        if !listText.isEmpty {
            addNewList(for: listText)
            persistLisToDefaults.persistListToDefaults()
            textField.text = ""
        } else {
            AlertController.alert(self, title: "Error 4☠️4!", message: "Not list entered")
        }
    }
    
    func addNewList(for listText: String) {
        let lists = List(title: listText)
        myLists.append(lists)
        selectedListIndex = myLists.count
        tableView.reloadData()
        textField.resignFirstResponder()
    }
    
    // MARK: - Keyboard dismiss
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Passing data from Main to Task Controller using indexPath for each title
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let taskViewController = segue.destination as! TaskController
        guard let index = tableView.indexPathForSelectedRow?.row else { return }
        taskViewController.selectedList = myLists[index]
    }
    
    
}
