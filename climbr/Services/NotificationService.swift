//
//  NotificationService.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import Foundation

protocol NotificationService {
    func askUserPermission()
    func sendNotification(date: Date, title: String, body: String)
    func scheduleNotification(reminder: UserPreferences)
}
