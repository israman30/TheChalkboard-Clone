//
//  TaskVC.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 12/8/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit

class TaskVC:UIViewController {
    
    var selectedList: List!
    
    let persistTaskDefault = Model.shared
    
    let cell = "cell"
    
    let tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Tap list here", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
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
        
        setMainTaskView()
        setTaskNavBar()
        
        tableView.register(TaskCell.self, forCellReuseIdentifier: cell)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}













