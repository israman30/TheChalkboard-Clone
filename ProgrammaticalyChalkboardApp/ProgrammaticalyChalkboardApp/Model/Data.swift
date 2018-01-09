//
//  Data.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 12/8/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import Foundation
import UIKit

// MARK: - CLASS MODEL PERSIST DATA
class Model {
    static let shared = Model()
    
    private init(){}
    
    let key = "persisted-List"
    
    // Sub.MARK: - Archive data on user default persist
    func persistListToDefaults(){
        let data = NSKeyedArchiver.archivedData(withRootObject: myLists)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    // Sub.MARK: - Load data from user defaults
    func loadPersistedListFromDefaults(){
        if let data = UserDefaults.standard.object(forKey: key) as? Data {
            let peps = NSKeyedUnarchiver.unarchiveObject(with: data) as! [List]
            myLists = peps
        }
    }
}

var myLists = [List]()

var selectedListIndex: Int!

// MARK: - CLASS LIST - ITEMS - DETAIL
// Sub.MARK: - NSObject and NSCoding to convert data on an object & code data to defaults
class List: NSObject, NSCoding {
    
    private struct keys {
        static let titles = "titles"
        static let items = "items"
    }
    
    var title: String
    var items = [Items]()
    
    init(title: String) {
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        // TODO
        title = aDecoder.decodeObject(forKey: keys.titles) as! String
        items = aDecoder.decodeObject(forKey: keys.items) as! [Items]
    }
    func encode(with aCoder: NSCoder) {
        // TODO
        aCoder.encode(title, forKey: keys.titles)
        aCoder.encode(items, forKey: keys.items)
    }
}

class Items: NSObject, NSCoding {
    
    private struct Keys {
        static let title = "title"
        static let detail = "detail"
        static let date = "date"
    }
    
    var title: String
    var detail = "detail"
    var date: String
    init(title: String, detail: String, date: String) {
        self.title = title
        self.detail = detail
        self.date = date
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // TODO
        self.init(
            title: aDecoder.decodeObject(forKey: Keys.title) as! String,
            detail: aDecoder.decodeObject(forKey: Keys.detail) as! String,
            date: aDecoder.decodeObject(forKey: Keys.date) as! String
        )
    }
    func encode(with aCoder: NSCoder) {
        // TODO
        aCoder.encode(title, forKey: Keys.title)
        aCoder.encode(detail, forKey: Keys.detail)
        aCoder.encode(date, forKey: Keys.date)
    }
}

/*
 // BASE CLASS CONTROLLER
 
 var myLists = [List]()
 
 var selectedListIndex: Int!
 
 class List {
 var title: String
 var items = [Items]()
 init(title: String) {
 self.title = title
 }
 }
 
 class Items {
 var title: String
 var detail = "detail"
 var date: String
 init(title: String, detail: String, date: String) {
 self.title = title
 self.detail = detail
 self.date = date
 }
 }
 */
