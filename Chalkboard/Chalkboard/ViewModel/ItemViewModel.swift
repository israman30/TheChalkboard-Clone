//
//  ItemViewModel.swift
//  Chalkboard
//
//  Created by Israel Manzo on 3/14/23.
//

import Foundation
import CoreData

class ItemViewModel: ObservableObject {
    
    var context: NSManagedObjectContext?
    @Published var addedItem = ""
    @Published var date = Date()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        return formatter
    }
    
    init(context: NSManagedObjectContext? = nil) {
        self.context = context
    }
    
    func add() {
        let newTask = Task(context: context!)
        newTask.id = UUID()
        newTask.name = addedItem
        newTask.timestamp = dateFormatter.string(from: date)
        save()
        close()
    }
    
    private func save() {
        do {
            try context!.save()
        } catch {
            print("Error saving task in db: \(error.localizedDescription)")
        }
    }
    
    func close() {
        self.addedItem = ""
    }
}
