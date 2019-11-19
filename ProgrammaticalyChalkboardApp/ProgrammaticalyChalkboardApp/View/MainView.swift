//
//  MainView.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 8/26/18.
//  Copyright © 2018 Israel Manzo. All rights reserved.
//

import UIKit

extension MainController {
    
    func setNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor.Colors.setNavBarTintColor
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name:"Marker Felt", size:25.0)!,
            NSAttributedString.Key.foregroundColor:UIColor.white
        ]
        navigationItem.title = "Add a List"
    }
    
    // MARK: - Setting Custom TableView method
    func setMainView(_ tableView: UITableView) {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyCell.self, forCellReuseIdentifier: CellID.mainCell.rawValue)
        
        tableView.layer.cornerRadius = 5
        
        view.backgroundColor = UIColor.Colors.setViewBackgroundColor

        view.addSubViews(tableView, myLabel, textField, button)
        
        button.setAnchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 140, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width:50, height: 50)
        
        textField.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 155, paddingLeft: 10, paddingBottom: 0, paddingRight: 8,width: 0, height: 30)
        
        myLabel.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 110, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        
        tableView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 200, paddingLeft: 8, paddingBottom: 50, paddingRight: 8)
    }

}
