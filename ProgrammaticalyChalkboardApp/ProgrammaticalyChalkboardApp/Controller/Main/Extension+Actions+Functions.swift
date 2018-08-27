//
//  Extension+Actions+Functions.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 8/26/18.
//  Copyright © 2018 Israel Manzo. All rights reserved.
//

import UIKit

extension MainVC {
    
    @objc func addButton(){
        guard let listText = textField.text else {return}
        if !listText.isEmpty {
            let lists = List(title: listText)
            myLists.append(lists)
            selectedListIndex = myLists.count
            tableView.reloadData()
            textField.resignFirstResponder()
            persistLisToDefaults.persistListToDefaults()
            textField.text = ""
        } else {
            AlertController.alert(viewController: self, title: "Error 4☠️4!", message: "Not list entered found")
        }
    }
    
    // MARK: - Keyboard dismiss
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let taskViewController = segue.destination as! TaskVC
        taskViewController.selectedList = myLists[(tableView.indexPathForSelectedRow?.row)!]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
}
