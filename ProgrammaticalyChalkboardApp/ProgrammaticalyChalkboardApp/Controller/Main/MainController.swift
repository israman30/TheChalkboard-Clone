//
//  ViewController.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 12/1/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    var selectedIndex: Int?
    
    let persistLisToDefaults = Model.shared
    
    var cell = "cell"
    
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
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Tap list here", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
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
        setMainView(tableView)
        setNavBar()
    }
    
}





