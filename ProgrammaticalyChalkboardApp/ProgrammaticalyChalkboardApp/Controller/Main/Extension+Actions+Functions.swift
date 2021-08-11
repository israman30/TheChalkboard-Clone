//
//  Extension+Actions+Functions.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 8/26/18.
//  Copyright © 2018 Israel Manzo. All rights reserved.
//

import UIKit

/*
  =================== MAIN CONTROLLER EXTENSION - METHODS ===================
 - Add button execute action when user add a new Title list - index.
 - AlertController extension is used to prevent user tap in a empty TextField.
  ============================================================================
 */

extension MainController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Add list function with db and re-set textField - if input textField is empty, alert user.
    @objc func addButton(){
        mainViewModel.add(tableView: tableView, textField: textField, vc: self)
    }
    
    // MARK: - Keyboard dismiss when user touches any where out of the input textField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Passing data from Main to Task Controller using indexPath for each title list
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let taskViewController = segue.destination as! TaskController
        guard let index = tableView.indexPathForSelectedRow?.row else { return }
        taskViewController.taskViewModel.selectedList = myLists[index]
    }
    
}


