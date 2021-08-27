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
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCellView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCellView() {
        
        let stackView = UIStackView(arrangedSubviews: [cellLabel, dateLabel])
        stackView.axis = .vertical
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
}



