//
//  ExtensionTaskView.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 8/27/18.
//  Copyright © 2018 Israel Manzo. All rights reserved.
//

import UIKit


extension TaskVC {
    
    // MARK: SET NAVBAR
    func setTaskNavBar(){
        navigationController?.navigationBar.barTintColor = UIColor.Colors.setNavBarTintColor
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont(name:"Marker Felt", size:25.0)!,
            NSAttributedStringKey.foregroundColor:UIColor.white
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - SET TASK MAIN VIEW
    func setMainTaskView(){
        
        view.backgroundColor = UIColor.Colors.setViewBackgroundColor
        view.addSubview(tableView)
        view.addSubview(textField)
        view.addSubview(button)
        
        tableView.layer.cornerRadius = 5
        
        button.setAnchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 140, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width:50, height: 50)
        
        tableView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 200, paddingLeft: 8, paddingBottom: 50, paddingRight: 8)
        
        textField.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 145, paddingLeft: 10, paddingBottom: 0, paddingRight: 8,width: 50, height: 30)
    }
}