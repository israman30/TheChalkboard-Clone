//
//  ExtensionView.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 12/1/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit

/*
 ================= UILabel Custom extension =====================
 - This method is called at Detail Controller
 ================================================================
 */

extension UILabel {
    
    convenience init(text string: String, fontName: String, fontSize: CGFloat, color: UIColor, aligment: NSTextAlignment) {
        self.init()
        text = string
        font = UIFont(name: fontName, size: fontSize)
        textColor = color
        textAlignment = aligment
    }
}

/*
 ================= UITexField Custom extension ==================
 - This method is called at List & Task Controller
 ================================================================
 */

extension UITextField {
    
    convenience init(placeholder: String, background: UIColor, color: UIColor, fontSize: CGFloat, alignment: NSTextAlignment = .natural) {
        self.init()
        let attributes = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        attributedPlaceholder = attributes
        backgroundColor = background
        textColor = color
        font = UIFont.systemFont(ofSize: fontSize)
        
        if let customFont = UIFont(name: "Apple SD Gothic Neo Light", size: 22) {
            font = UIFontMetrics(forTextStyle: .caption1).scaledFont(for: customFont)
        }
        adjustsFontForContentSizeCategory = true
        textAlignment = alignment
    }
}

/*
  ================= UIButton Custom extension =================
  - This method is called at List & Task Controller
  =============================================================
 */

extension UIButton {
    
    convenience init(title: String, background: UIColor, border: CGFloat, colorBorder: CGColor, radius: CGFloat) {
        self.init()
        setTitle(title, for: .normal)
        titleLabel?.font = .preferredFont(forTextStyle: .title3)
        titleLabel?.adjustsFontForContentSizeCategory = true
        backgroundColor = background
        layer.borderWidth = border
        layer.borderColor = colorBorder
        layer.cornerRadius = radius
    }
}

/*
 ================= UIView addSubviews extension ==================
 - This method is called when view is loading
 =================================================================
 */
extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

/*
 ================= UIColor Custom extension ==================
 - This method is called to set custom colors on List, Task & Detail Controller
 =============================================================
 */
extension UIColor {
    struct Colors {
        static var setNavBarTintColor: UIColor {
            return UIColor(red: 76/255, green: 79/255, blue: 76/255, alpha: 1)
        }
        
        static var setViewBackgroundColor: UIColor {
            return UIColor(red: 41/255, green: 45/255, blue: 41/255, alpha: 1)
        }
    }
}


/*
  =================== LAYOUT EXTENSION ====================
  - This extension have methods that help to set the layout using anchor constraint.
  - These methods can be used any where in the application.
  =========================================================
 */
extension UIView {
    
    func setCellShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 1.0
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.cornerRadius = 4
    }
    
    func setAnchor(width: CGFloat, height: CGFloat) {
        self.setAnchor(top: nil,
                       left: nil,
                       bottom: nil,
                       right: nil,
                       paddingTop: 0,
                       paddingLeft: 0,
                       paddingBottom: 0,
                       paddingRight: 0,
                       width: width,
                       height: height)
    }
    
    func setAnchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?,
                   bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,
                   paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat,
                   paddingRight: CGFloat, width: CGFloat = 0, height: CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leftAnchor
        }
        return leftAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        return bottomAnchor
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.rightAnchor
        }
        return rightAnchor
    }
    
}
