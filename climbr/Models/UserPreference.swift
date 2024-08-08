//
//  UserPreference.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Foundation

struct UserPreferenceModel {
    var id: UUID
    var endWorkingHour: Date
    var launchAtLogin: Bool
    var reminderInterval: Int64
    var startWorkingHour: Date
}
