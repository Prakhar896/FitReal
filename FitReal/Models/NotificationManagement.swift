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
        content.sound = .default
        
        let components = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second, .nanosecond], from: triggerDatetime)
        let dateBasedTrigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: dateBasedTrigger)
        
        center.add(request) { error in
            if let error = error {
                print("NOTIFICATION ADD ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    static func newPostNotification(triggerDatetime: Date) -> Notification {
        return Notification(id: UUID().uuidString, title: "⚠️ Post a workout FitReal! ⚠️", body: "Working out? Tap here to post a FitReal to share your workout with your friends!", triggerDatetime: triggerDatetime)
    }
}
