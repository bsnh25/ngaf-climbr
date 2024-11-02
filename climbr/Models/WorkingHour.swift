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
  
  var fullName: String {
    switch self {
      
    case .monday: "Monday"
    case .tuesday: "Tuesday"
    case .wednesday: "Wednesday"
    case .thursday: "Thursday"
    case .friday: "Friday"
    case .saturday: "Saturday"
    case .sunday: "Sunday"
    }
  }
  
  var abbreviatedName: String {
    switch self {
      
    case .monday: "Mon"
    case .tuesday: "Tue"
    case .wednesday: "Wed"
    case .thursday: "Thu"
    case .friday: "Fri"
    case .saturday: "Sat"
    case .sunday: "Sun"
    }
  }
}

struct WorkingHour: Codable, Hashable {
  var startHour: Date
  var endHour: Date
  var day: Int
  var isEnabled: Bool = false
  
  static func ==(lhs: WorkingHour, rhs: WorkingHour) -> Bool {
    lhs.day == rhs.day
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(day)
  }
}
