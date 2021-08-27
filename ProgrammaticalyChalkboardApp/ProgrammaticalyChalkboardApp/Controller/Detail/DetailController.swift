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
    
//    var selectedTask: Items?
//
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        if #available(iOS 13.4, *) {
            dp.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        return dp
    }()
//
//    let detailPersistDefaults = Model.shared
//
//    // MARK: - User Notifications identifier for notification request
//    let uidString = UUID().uuidString
    
    let detailViewModel = DetailViewModel()
    
    let textView: UITextView = {
        let tf = UITextView()
        tf.backgroundColor = .black
        tf.font = .preferredFont(forTextStyle: .title3)
        tf.adjustsFontForContentSizeCategory = true
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
        if let customFont = UIFont(name: "Marker Felt", size: 18) {
            label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont)
            label.adjustsFontForContentSizeCategory = true
        }
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDetailView()
        setNav()
        createDatePicker()
        
        guard let title = detailViewModel.selectedTask?.title,
              let detail = detailViewModel.selectedTask?.detail,
              let date = detailViewModel.selectedTask?.date else {return}
        
        titleDetailLabel.text = title
        textView.text = detail
        dateLabel.text = date
        
    }
    
}


