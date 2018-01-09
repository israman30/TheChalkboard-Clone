//
//  TaskVC.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 12/8/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit

let setBackgroundColor = UIColor(red: 41/255, green: 45/255, blue: 41/255, alpha: 1)

let taskNavBarTintColor = UIColor(red: 76/255, green: 79/255, blue: 76/255, alpha: 1)

class TaskVC:UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
    // MARK: ADD ITEM ACTION FUNCTION
    @objc func addButtonTask(){
        guard let taskText = textField.text else {return}
        
        if !taskText.isEmpty {
            let addItem = Items(title: taskText, detail: "", date: "")
            selectedList.items.append(addItem)
            tableView.reloadData()
            textField.resignFirstResponder()
            persistTaskDefault.persistListToDefaults()
            textField.text = ""
        } else {
            let alert = UIAlertController(title: "Error 4☠️4!", message: "Not task entered found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMainTaskView()
        setTaskNavBar()
        
        tableView.register(TaskCell.self, forCellReuseIdentifier: cell)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: Keyboard dismiss when touch outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: SET NAVBAR
    func setTaskNavBar(){
        navigationController?.navigationBar.barTintColor = taskNavBarTintColor
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont(name:"Marker Felt", size:25.0)!,
            NSAttributedStringKey.foregroundColor:UIColor.white
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - SET TASK MAIN VIEW
    func setMainTaskView(){
        
        let backGroundColor = setBackgroundColor
        
        view.backgroundColor = backGroundColor
        view.addSubview(tableView)
        view.addSubview(textField)
        view.addSubview(button)
        
        tableView.layer.cornerRadius = 5
        
        button.setAnchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 140, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width:50, height: 50)
        
        tableView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 200, paddingLeft: 8, paddingBottom: 50, paddingRight: 8)
        
        textField.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 145, paddingLeft: 10, paddingBottom: 0, paddingRight: 8,width: 50, height: 30)
    }
    
    // MARK: - DATA SOURCE & DELEGATE FUNCTIONS 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedList.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cell) as! TaskCell
        
        let task = selectedList.items[indexPath.row].title
        let date = selectedList.items[indexPath.row].date
        cell.cellLabel.text = task
        cell.dateLabel.text = date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailVC()
        detail.selectedTask = selectedList.items[indexPath.row]
        navigationController?.pushViewController(detail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            selectedList.items.remove(at: indexPath.row)
            let defaults = UserDefaults.standard
            tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
            defaults.removeObject(forKey: "detail")
            defaults.removeObject(forKey: "title")
            defaults.removeObject(forKey: "date")
            defaults.synchronize()
            persistTaskDefault.persistListToDefaults()
        } else {
            tableView.reloadData()
        }
    }
}









