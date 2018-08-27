//
//  Cells.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 12/26/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    var items: Items? {
        didSet {
            guard let title = items?.title,
                  let date = items?.date else { return }
            
            cellLabel.text = title
            dateLabel.text = date
        }
    }
    
    let cellLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCellView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCellView(){
        
        [cellLabel, dateLabel].forEach { addSubview($0) }
        
        cellLabel.setAnchor(top: topAnchor, left: leftAnchor, bottom: dateLabel.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        
        dateLabel.setAnchor(top: cellLabel.topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 40, paddingLeft: 15, paddingBottom: 0, paddingRight: 0)
    }
}



