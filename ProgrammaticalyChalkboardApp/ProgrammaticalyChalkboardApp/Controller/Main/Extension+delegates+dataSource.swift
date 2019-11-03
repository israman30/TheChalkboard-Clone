//
//  Extension+delegates+dataSource.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 8/26/18.
//  Copyright © 2018 Israel Manzo. All rights reserved.
//

import UIKit
import Foundation

extension UITableView {

    func setEmptyTableMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 25)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
/*
  =================== DELEGATES & DATA SOURCE ===================
  ===============================================================
 */

// MARK: - TableView Data Source Functions
extension MainController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myLists.count == 0 ?
            tableView.setEmptyTableMessage("No event added yet") :
            tableView.restore()
        return myLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.mainCell.rawValue) as? MyCell
        cell?.list = myLists[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskController = TaskController()
        taskController.selectedList = myLists[indexPath.row]
        navigationController?.pushViewController(taskController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myLists.remove(at: indexPath.row)
            let defaults = UserDefaults.standard
            tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
            defaults.removeObject(forKey: "title")
            defaults.synchronize()
            persistLisToDefaults.persistListToDefaults()
        } else {
            tableView.reloadData()
        }
    }
}
