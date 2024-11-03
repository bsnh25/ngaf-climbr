//
//  NotificationService.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import Foundation

protocol NotificationService {
//    func askUserPermission()
//    func sendNotification(title: String, body: String, reminder: UserPreferenceModel)
//    func scheduleNotification(reminder: UserPreferences)
    
    func startOverlayScheduler(userPreference: UserPreferenceModel)
}
