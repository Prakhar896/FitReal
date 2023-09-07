//
//  FitRealApp.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 6/9/23.
//

import SwiftUI
import UserNotifications
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound, .badge]) { result, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        UserDefaults.standard.set(true, forKey: "ShowNewActivityScreen")
        UserDefaults.standard.set(false, forKey: "NextWorkoutActivated")
        let identifier = response.notification.request.identifier
        print("Notification with ID '\(identifier)' was received.")
        completionHandler()
    }
}

@main
struct FitRealApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .preferredColorScheme(.dark)
        }
    }
}
