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
        
        // Unwrap working hours
        guard let startWorkingHour = reminder.startWorkingHour, let endWorkingHour = reminder.endWorkingHour else {
            print("Invalid working hours")
            return
        }
        
        var currentReminderTime = startWorkingHour
//        print("Ini start working hour : \(currentReminderTime)")
//        print("Ini end working hour : \(reminder.endWorkingHour)")
        
        //MARK: Steps Send Notification
        /// 0. Make sure start working not above end working hour
        /// 1. Calculate the time interval from now to the current reminder time
        /// 2. If the interval is positive, it means the reminder is in the future
        /// 3. Regist trigger base on time Interval on the future
        /// 4. Create the request with a unique identifier
        /// 5. Schedule the notification
        /// 6. Move to the next reminder time by adding the reminder interval
        
        while currentReminderTime <= endWorkingHour {
            let timeInterval = currentReminderTime.timeIntervalSinceNow
//            print("Ini time interval now : \(timeInterval)")
            if timeInterval > 0 {
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error scheduling notification: \(error)")
                        return
                    }
                }
//                print("success set schedule")
            }
            currentReminderTime = currentReminderTime.addingTimeInterval(TimeInterval(reminder.reminderInterval))
//            print("Ini time interval 2 : \(currentReminderTime)")
        }

    }
    
//        func scheduleNotification(reminder: UserPreferences) {
//            //MARK: TODO
//        }
}
