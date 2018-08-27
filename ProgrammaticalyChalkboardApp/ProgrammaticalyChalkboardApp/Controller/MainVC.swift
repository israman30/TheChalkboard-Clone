//
//  ViewController.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 12/1/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var selectedIndex: Int?
    
    let persistLisToDefaults = Model.shared
    
    var cell = "cell"
    
    let tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    let myLabel: UILabel = {
        let label = UILabel ()
        label.text = "My Chalkboard"
        label.font = UIFont(name: "Marker Felt", size: 30.0)
        label.textColor = .white
        label.textAlignment = .center
        return label
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
        btn.addTarget(self, action: #selector(addButton), for: .touchUpInside)
        return btn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMainView()
        setNavBar()
        tableView.register(MyCell.self, forCellReuseIdentifier: cell)
        
    }
    
    // MARK: - Keyboard dismiss 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setNavBar(){
        navigationController?.navigationBar.barTintColor = UIColor.Colors.setNavBarTintColor
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont(name:"Marker Felt", size:25.0)!,
            NSAttributedStringKey.foregroundColor:UIColor.white
        ]
        
        navigationItem.title = "Add a List"
    }
    
    private func setMainView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.layer.cornerRadius = 5
    
        view.backgroundColor = UIColor.Colors.setViewBackgroundColor
        view.addSubview(tableView)
        view.addSubview(myLabel)
        view.addSubview(textField)
        view.addSubview(button)
        
        button.setAnchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 140, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width:50, height: 50)
        
        textField.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 155, paddingLeft: 10, paddingBottom: 0, paddingRight: 8,width: 50, height: 30)
        
        myLabel.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 110, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 40)
        
        tableView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 200, paddingLeft: 8, paddingBottom: 50, paddingRight: 8)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let taskViewController = segue.destination as! TaskVC
        taskViewController.selectedList = myLists[(tableView.indexPathForSelectedRow?.row)!]
    }
}







