//
//  NotificationManagerViewModel.swift
//  Chalkboard
//
//  Created by Israel Manzo on 3/22/23.
//

import UIKit
import UserNotifications

struct NotificationManagerViewModel {
    
    static let instance = NotificationManagerViewModel()
    
    let notification = UNUserNotificationCenter.current()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func scheduleNotification(title: String, subtitle: String, date: Date, isImportant: Bool = false) {
        let content = UNMutableNotificationContent()
        if isImportant {
            content.title = "❗️\(title)"
        } else {
            content.title = title
        }
        content.subtitle = subtitle
        content.sound = .default
        content.badge = 1
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func removeNotificaion() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}
