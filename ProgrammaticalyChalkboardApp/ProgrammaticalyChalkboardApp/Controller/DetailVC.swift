//
//  DetailVC.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 12/8/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit

let detailNavBarTintColor = UIColor(red: 76/255, green: 79/255, blue: 76/255, alpha: 1)

let detailBackGroundColor = UIColor(red: 41/255, green: 45/255, blue: 41/255, alpha: 1)

class DetailVC: UIViewController {
    
    var selectedTask: Items?
    
    var datePicker = UIDatePicker()
    
    let detailPersistDefaults = Model.shared
    
    let textView: UITextView = {
        let tf = UITextView()
        tf.backgroundColor = .black
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.textColor = .white
        return tf
    }()
    
    let titleDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "Detail of task label"
        label.font = UIFont(name: "Marker Felt", size: 25.0)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let useTheForceLabel: UILabel = {
        let label = UILabel()
        label.text = "Use the Force!"
        label.font = UIFont(name: "Marker Felt", size: 30.0)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let dateLabel: UITextField = {
        let label = UITextField()
        label.placeholder = "Date Here"
        label.font = UIFont(name: "Marker Felt", size: 18.0)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDetailView()
        setNav()
        createDatePicker()
        
        guard let title = selectedTask?.title else {return}
        titleDetailLabel.text = title
        guard let detail = selectedTask?.detail else {return}
        textView.text = detail
        guard let date = selectedTask?.date else {return}
        dateLabel.text = date
    }
    
    func createDatePicker(){
        datePicker.datePickerMode = .dateAndTime
        datePicker.setValue(UIColor.white, forKey: "textColor")
        datePicker.backgroundColor = .black
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.barTintColor = .black
        
        let doneTapped = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(barButtonDoneTapped))
        toolBar.setItems([doneTapped], animated: true)
        doneTapped.tintColor = .white
        
        dateLabel.inputAccessoryView = toolBar
        dateLabel.inputView = datePicker
    }
    
    @objc func barButtonDoneTapped(){
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        dateLabel.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    // MARK: - SET NAVBAR
    func setNav(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveDetail))
        
        navigationController?.navigationBar.barTintColor = detailNavBarTintColor
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont(name:"Marker Felt", size:25.0)!,
            NSAttributedStringKey.foregroundColor:UIColor.white
        ]
        
        navigationItem.title = "My Chalkboard"
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - BAR ITEM ACTION - SAVING INPUT
    @objc func saveDetail(){
        guard let detail = textView.text else {return}
        guard let dateDetail = dateLabel.text else {return}
        
        if !detail.isEmpty || !dateDetail.isEmpty {
            selectedTask?.detail = detail
            selectedTask?.date = dateDetail
            detailPersistDefaults.persistListToDefaults()
            savingDataDetailAlertMsg()
        } else {
            let alert = UIAlertController(title: "☠️", message: "Enter a description please", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    // Sub.MARK: - Saving info alarm message function
    func savingDataDetailAlertMsg(){
        let alert = UIAlertController(title: "Bingo..👍", message: "You details are saved succesfully!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - SEt DETAIL MAIN VIEW
    func setDetailView(){
        
        view.backgroundColor = detailBackGroundColor
        
        view.addSubview(textView)
        view.addSubview(useTheForceLabel)
        view.addSubview(titleDetailLabel)
        view.addSubview(dateLabel)
        
        textView.layer.cornerRadius = 8
        
        dateLabel.setAnchor(top: titleDetailLabel.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 35, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        
        titleDetailLabel.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 120, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        
        useTheForceLabel.setAnchor(top: textView.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 350, paddingLeft: 50, paddingBottom: 50, paddingRight: 50)

        textView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 200, paddingLeft: 8, paddingBottom: 250, paddingRight: 8, width: 200, height: 400)
    }
    
    // MARK: Keyboard dismiss when touch outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}
