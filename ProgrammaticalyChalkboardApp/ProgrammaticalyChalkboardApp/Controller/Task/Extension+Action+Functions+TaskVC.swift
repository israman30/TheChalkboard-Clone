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
    @objc func addButtonTask() {
        taskViewModel.addTask(textField: textField, tableView: tableView, vc: self)
    }
    
    // MARK: Keyboard dismiss when touch outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


