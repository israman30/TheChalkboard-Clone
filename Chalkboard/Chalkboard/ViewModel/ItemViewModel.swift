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
    @Published var titleItem = ""
    @Published var addedItem = ""
    @Published var isPriority = false
    @Published var isHigh = false
    @Published var isMedium = false
    @Published var isLow = false
    @Published var date = Date()
    let notification: NotificationManagerViewModel = .instance
    
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
        newTask.title = titleItem
        newTask.name = addedItem
        newTask.isPriority = isPriority
        newTask.isHigh = isHigh
        newTask.isMedium = isMedium
        newTask.isLow = isLow
        newTask.timestamp = dateFormatter.string(from: date)
        save()
        close()
    }
    
    private func save() {
        do {
            try context!.save()
            self.notification.scheduleNotification(title: titleItem, subtitle: addedItem, date: date, isImportant: isPriority)
        } catch {
            print("Error saving task in db: \(error.localizedDescription)")
        }
    }
    
    func close() {
        self.addedItem = ""
    }
}
