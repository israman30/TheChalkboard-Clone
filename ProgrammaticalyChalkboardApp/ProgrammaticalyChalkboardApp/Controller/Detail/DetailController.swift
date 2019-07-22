//
//  DetailVC.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 12/8/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit
import UserNotifications

class DetailController: UIViewController {
    
    var selectedTask: Items?
    
    var datePicker = UIDatePicker()
    
    let detailPersistDefaults = Model.shared
    
    // MARK: - User Notifications identifier for notification request
    let uidString = UUID().uuidString
    
    let textView: UITextView = {
        let tf = UITextView()
        tf.backgroundColor = .black
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.textColor = .white
        return tf
    }()
    
    let titleDetailLabel: UILabel = {
        let label = UILabel(text: "Detail of task label", fontName: "Marker Felt", fontSize: 25, color: .white, aligment: .center)
        return label
    }()
    
    let useTheForceLabel: UILabel = {
        let label = UILabel(text: "Use the Force!", fontName: "Marker Felt", fontSize: 30, color: .white, aligment: .center)
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
        
        guard let title = selectedTask?.title,
              let detail = selectedTask?.detail,
              let date = selectedTask?.date else {return}
        
        titleDetailLabel.text = title
        textView.text = detail
        dateLabel.text = date
    }
    
}


