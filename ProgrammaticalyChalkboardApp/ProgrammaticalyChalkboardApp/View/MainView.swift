//
//  MainView.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 8/26/18.
//  Copyright © 2018 Israel Manzo. All rights reserved.
//

import UIKit

extension MainVC {
    
    func setNavBar(){
        navigationController?.navigationBar.barTintColor = UIColor.Colors.setNavBarTintColor
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont(name:"Marker Felt", size:25.0)!,
            NSAttributedStringKey.foregroundColor:UIColor.white
        ]
        
        navigationItem.title = "Add a List"
    }
    
    func setMainView(_ tableView: UITableView){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyCell.self, forCellReuseIdentifier: cell)
        
        tableView.layer.cornerRadius = 5
        
        view.backgroundColor = UIColor.Colors.setViewBackgroundColor

        [tableView, myLabel, textField, button].forEach { view.addSubview($0) }
        
        button.setAnchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 140, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width:50, height: 50)
        
        textField.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 155, paddingLeft: 10, paddingBottom: 0, paddingRight: 8,width: 50, height: 30)
        
        myLabel.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 110, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 40)
        
        tableView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 200, paddingLeft: 8, paddingBottom: 50, paddingRight: 8)
    }

}
