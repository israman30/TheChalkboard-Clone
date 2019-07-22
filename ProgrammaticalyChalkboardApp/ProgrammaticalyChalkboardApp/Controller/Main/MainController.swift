//
//  ViewController.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 12/1/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit


/*
   ========================== MAIN CONTROLLER =================================
 - Main Controller load first when app is opened.
 - TableView show a list where user can add a new Title list for a TODO.
 - This can be delete after the List is done. Swipe delete feauture.
 - SelecectedIndex Int is the index of the Title list that user can add and storage a new task or list of tasks for it. Including a date picker for a reminder using Local Notifications.
 - For this index is ued user defaults 
   ============================================================================
 */

class MainController: UIViewController {
    
    var selectedIndex: Int?
    
    let persistLisToDefaults = Model.shared
    
    let tableView = UITableView()
    
    let myLabel: UILabel = {
        let label = UILabel ()
        label.text = "My Chalkboard"
        label.font = UIFont(name: "Marker Felt", size: 30.0)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let textField: UITextField = {
        let tf = UITextField(placeholder: "Enter list here", background: .clear, color: .white, fontSize: 22)
        return tf
    }()
    
    let button: UIButton = {
        let btn = UIButton(title: "Add", background: .clear, border: 2, colorBorder: UIColor.white.cgColor, radius: 25)
        btn.addTarget(self, action: #selector(addButton), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainView(tableView)
        setNavBar()
    }
    
}





