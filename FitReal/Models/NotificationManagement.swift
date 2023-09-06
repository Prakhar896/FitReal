//
//  NotificationManagement.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 7/9/23.
//

import Foundation
import UserNotifications

struct Notification: Codable {
    var id: String
    var title: String
    var body: String
    var triggerDatetime: Date
    
    func add() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        let components = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: triggerDatetime)
        let dateBasedTrigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: dateBasedTrigger)
        
        center.add(request) { error in
            if let error = error {
                print("NOTIFICATION ADD ERROR: \(error.localizedDescription)")
            }
        }
    }
}
