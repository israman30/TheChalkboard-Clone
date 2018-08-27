//
//  Extension+ViewDetail.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 8/27/18.
//  Copyright © 2018 Israel Manzo. All rights reserved.
//

import UIKit

extension DetailVC {
    
    // MARK: - SET NAVBAR
    func setNav(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveDetail))
        
        navigationController?.navigationBar.barTintColor = UIColor.Colors.setNavBarTintColor
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont(name:"Marker Felt", size:25.0)!,
            NSAttributedStringKey.foregroundColor:UIColor.white
        ]
        
        navigationItem.title = "My Chalkboard"
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - SEt DETAIL MAIN VIEW
    func setDetailView(){
        
        view.backgroundColor = UIColor.Colors.setViewBackgroundColor
        
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
}