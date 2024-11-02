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

struct WorkingHour: Codable, Hashable {
    var startHour: Date
    var endHour: Date
    var day: Int
  
  static func ==(lhs: WorkingHour, rhs: WorkingHour) -> Bool {
    lhs.day == rhs.day
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(day)
  }
}
