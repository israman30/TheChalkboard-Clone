//
//  UserNotifications+Ext.swift
//  ProgrammaticalyChalkboardApp
//
//  Created by Israel Manzo on 6/13/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit
import UserNotifications

extension DetailController {
    
    func notifications(for date: Date){
        // 1. Ask for permission
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // If user no give permissions, let it know go to user settings
            if let error = error {
                print("Error", error)
                return
            }
        }
        guard let subtitle = selectedTask?.title,
            let body = selectedTask?.detail else { return }
        // 2. Add a content
        let content = UNMutableNotificationContent()
        content.title = "Chalkboard Reminder"
        content.subtitle = subtitle
        content.body = body
        
        // 3. Create a trigger
        let dateComponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        // 4. Create a request
        
        let request = UNNotificationRequest(identifier: uidString, content: content, trigger: trigger)
        center.removeAllPendingNotificationRequests()
        
        // 5. Register the request
        center.add(request) { (error) in
            // check error
            if let error = error { print("Error getting a badge",error) }
        }
    }
}
