//
//  DetailVC.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 12/8/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit

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
        
        guard let title = selectedTask?.title,
              let detail = selectedTask?.detail,
              let date = selectedTask?.date else {return}
        
        titleDetailLabel.text = title
        textView.text = detail
        dateLabel.text = date
    }
    
}


