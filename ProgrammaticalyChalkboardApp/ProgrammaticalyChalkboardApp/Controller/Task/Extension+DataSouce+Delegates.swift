//
//  Extension+DataSouce+Delegates.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 8/27/18.
//  Copyright © 2018 Israel Manzo. All rights reserved.
//

import UIKit

extension TaskVC:UITableViewDelegate, UITableViewDataSource {
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
