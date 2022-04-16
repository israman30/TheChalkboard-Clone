//
//  DataController.swift
//  Chalkboard
//
//  Created by Israel Manzo on 4/14/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "Chalkboard")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load Core Date: \(error.localizedDescription)")
            }
        }
    }
    
}
