//
//  Extension+DataSouce+Delegates.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 8/27/18.
//  Copyright © 2018 Israel Manzo. All rights reserved.
//

import UIKit

extension TaskController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - DATA SOURCE & DELEGATE FUNCTIONS
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedList.items.count == 0 ?
            tableView.setEmptyTableMessage("No task added yet...") :
            tableView.restore()
        return selectedList.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.taskCell.rawValue) as! TaskCell
        cell.items = selectedList.items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailController()
        detail.selectedTask = selectedList.items[indexPath.row]
        navigationController?.pushViewController(detail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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




