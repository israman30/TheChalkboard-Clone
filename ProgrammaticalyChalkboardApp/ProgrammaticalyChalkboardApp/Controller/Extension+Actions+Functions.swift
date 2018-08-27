//
//  Extension+Actions+Functions.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 8/26/18.
//  Copyright © 2018 Israel Manzo. All rights reserved.
//

import UIKit

extension MainVC {
    @objc func addButton(){
        guard let listText = textField.text else {return}
        if !listText.isEmpty {
            let lists = List(title: listText)
            myLists.append(lists)
            selectedListIndex = myLists.count
            tableView.reloadData()
            textField.resignFirstResponder()
            persistLisToDefaults.persistListToDefaults()
            textField.text = ""
        } else {
            let alert = UIAlertController(title: "Error 4☠️4!", message: "Not list entered found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
}
