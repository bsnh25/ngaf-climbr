//
//  NotificationManager.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import Foundation
import UserNotifications

class NotificationManager: NotificationService {
    
    static let instance = NotificationManager()
    
    let center = UNUserNotificationCenter.current()
    
    func askUserPermission() {
        center.requestAuthorization(options: [.alert,.badge,.sound]) { (success, err) in
            (err == nil) ? print("success request \(success)") : print("Notification Err : \(String(describing: err?.localizedDescription))")
        }
    }
    
    func sendNotification(title: String, body: String, reminder: UserPreferences) {
        //MARK: TODO
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.badge = 1 as NSNumber
        
        // Determine the working hours range
        guard let startWorkingHour = reminder.startWorkingHour, let endWorkingHour = reminder.endWorkingHour else {
            print("Invalid working hours")
            return
        }
        
        var currentReminderTime = startWorkingHour
//        print("Ini start working hour : \(currentReminderTime)")
//        print("Ini end working hour : \(reminder.endWorkingHour)")
        
        while currentReminderTime <= endWorkingHour {
            
            // Calculate the time interval from now to the current reminder time
            let timeInterval = currentReminderTime.timeIntervalSinceNow
            print("Ini time interval 1 : \(timeInterval)")
            
            // If the interval is positive, it means the reminder is in the future
            if timeInterval > 0 {
    //            print("Hitted if else")
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
                
                // Create the request with a unique identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                // Schedule the notification
                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error scheduling notification: \(error)")
                        return
                    }
                }
                print("set schedule")
            }
            
            // Move to the next reminder time by adding the reminder interval
            currentReminderTime = currentReminderTime.addingTimeInterval(TimeInterval(reminder.reminderInterval))
            print("Ini time interval 2 : \(currentReminderTime)")
        }

    }
    
//        func scheduleNotification(reminder: UserPreferences) {
//            //MARK: TODO
//        }
}
