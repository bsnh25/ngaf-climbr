//
//  WorkingHour.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 28/10/24.
//

import Foundation

enum Weekday: Int, CaseIterable {
  case monday
  case tuesday
  case wednesday
  case thursday
  case friday
  case saturday
  case sunday
}

struct WorkingHour: Codable{
    var isEnabled: Bool
    var startHour: Date
    var endHour: Date
    var day: Int
}
