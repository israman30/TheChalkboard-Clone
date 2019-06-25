//
//  ExtensionTaskView.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 8/27/18.
//  Copyright © 2018 Israel Manzo. All rights reserved.
//

import UIKit


extension TaskController {
    
    // MARK: SET NAVBAR
    func setTaskNavBar(){
        navigationController?.navigationBar.barTintColor = UIColor.Colors.setNavBarTintColor
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name:"Marker Felt", size:25.0)!,
            NSAttributedString.Key.foregroundColor:UIColor.white
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - SET TASK MAIN VIEW
    func setMainTaskView(_ tableView: UITableView){
        
        tableView.register(TaskCell.self, forCellReuseIdentifier: CellID.taskCell.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = UIColor.Colors.setViewBackgroundColor

        view.addSubViews(tableView, textField, button)
        
        tableView.layer.cornerRadius = 5
        
        button.setAnchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 140, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width:50, height: 50)
        
        tableView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 200, paddingLeft: 8, paddingBottom: 50, paddingRight: 8)
        
        textField.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 145, paddingLeft: 10, paddingBottom: 0, paddingRight: 8,width: 50, height: 30)
    }
}
