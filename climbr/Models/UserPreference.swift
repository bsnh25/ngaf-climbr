//
//  UserPreference.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Foundation

struct UserPreferenceModel: Codable {
    var id: UUID
    var launchAtLogin: Bool
    var reminderInterval: Int64
    var workingHours: [WorkingHour]
}
