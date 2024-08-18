//
//  NotificationManager.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import Foundation
import UserNotifications

class NotificationManager: NotificationService {
    
    static let shared = NotificationManager()
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func askUserPermission() {
        notificationCenter.requestAuthorization(options: [.alert,.badge,.sound]) { (success, err) in
            (err == nil) ? print("success request \(success)") : print("Notification Err : \(String(describing: err?.localizedDescription))")
        }
    }
    
    func sendNotification(title: String, body: String, reminder: UserPreferenceModel) {
        notificationCenter.removeAllDeliveredNotifications()
        notificationCenter.removeAllPendingNotificationRequests()
        
        //MARK: Setup Notification Messsage
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.badge = 1 as NSNumber
        
        
        //MARK: Logic Reminder

        let start = stride(
            from: reminder.startWorkingHour,
            to: reminder.endWorkingHour,
            by: Date.Stride(reminder.reminderInterval * 60)).filter { $0 > Date() }
        
        start.forEach { reminder in
            let rangeTime = Calendar.current.dateComponents([.hour, .minute], from: reminder)
            let trigger = UNCalendarNotificationTrigger(dateMatching: rangeTime, repeats: true)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            print("reminder : \(reminder)")
            print("request : \(request.trigger.debugDescription)")
            notificationCenter.add(request){ error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                }
            }
            
        }
    }
    
    
}
