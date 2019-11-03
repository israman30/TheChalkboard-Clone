//
//  EmptyTableViewMessageView.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 11/3/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

/*
 =================== EMPTY TABLE VIEW MESSAGE ==================
 ===============================================================
*/

extension UITableView {

    // MARK: - TABLE VIEW EMPTY MESSAGE DISPLAY FUNCTION
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

    // MARK: - RESTORE/RELOAD TABLE VIEW FOR ROW ADDED
    func reloadTable() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
