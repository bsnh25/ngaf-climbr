//
//  WorkingHour.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 28/10/24.
//

import Foundation

enum Day: String, Codable{
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

struct WorkingHour{
    var isEnabled: Bool
    var startHour: Date
    var endHour: Date
    var day: Day
}
