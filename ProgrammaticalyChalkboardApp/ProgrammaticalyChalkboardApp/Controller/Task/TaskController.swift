//
//  TaskVC.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 12/8/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit

/*
  =================== TASK CONTROLLER ===================
  - Task Controller saved a list of items for each Title list coming from Main Controller by index.
  - As MainCotroller, TaskController saves a item or list of items by index.
  - This index is used to save a detail for each item in TaskController.
  - Swipe deletes an item by index when the task is done. These also delete the detail that the index contains.
  =======================================================
 */

class TaskController: UIViewController {
    // MARK: Selected list index
    var selectedList: List!
    
    let persistTaskDefault = Model.shared
    
    let tableView = UITableView()
    
    let textField: UITextField = {
        let tf = UITextField(placeholder: "Enter task here...", background: .clear, color: .white, fontSize: 22)
        return tf
    }()
    
    let button: UIButton = {
        let btn = UIButton(title: "Add", background: .clear, border: 2, colorBorder: UIColor.white.cgColor, radius: 25)
        btn.addTarget(self, action: #selector(addButtonTask), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMainTaskView(tableView)
        setTaskNavBar()
        
    }
    
}









