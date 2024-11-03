//
//  UserPreference.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Foundation

struct UserPreferenceModel: Codable {
    var launchAtLogin: Bool = false
    var isFlexibleWorkHour: Bool = false
    var reminderInterval: Int
    var workingHours: [WorkingHour]
}
