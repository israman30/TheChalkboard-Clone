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
    
    var selectedList: List!
    
    let persistTaskDefault = Model.shared
    
    let cell = "cell"
    
    let tableView = UITableView()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Enter task here", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        tf.backgroundColor = .clear
        tf.textColor = .white
        return tf
    }()
    
    let button: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.cornerRadius = 25
        btn.setTitle("Add", for: .normal)
        btn.addTarget(self, action: #selector(addButtonTask), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMainTaskView(tableView)
        setTaskNavBar()
        
    }
    
}













