//
//  Extension+Action+Functions+TaskVC.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 8/27/18.
//  Copyright © 2018 Israel Manzo. All rights reserved.
//

import UIKit

extension TaskVC {
    // MARK: ADD ITEM ACTION FUNCTION
    @objc func addButtonTask(){
        guard let taskText = textField.text else {return}
        
        if !taskText.isEmpty {
            let addItem = Items(title: taskText, detail: "", date: "")
            selectedList.items.append(addItem)
            tableView.reloadData()
            textField.resignFirstResponder()
            persistTaskDefault.persistListToDefaults()
            textField.text = ""
        } else {
            let alert = UIAlertController(title: "Error 4☠️4!", message: "Not task entered found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: Keyboard dismiss when touch outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


