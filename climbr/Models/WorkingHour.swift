//
//  WorkingHour.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 28/10/24.
//

import Foundation

enum Weekday: Int, CaseIterable {
  case sunday
  case monday
  case tuesday
  case wednesday
  case thursday
  case friday
  case saturday
  
  
  var fullName: String {
    switch self {
        
    case .sunday: "Sunday"
    case .monday: "Monday"
    case .tuesday: "Tuesday"
    case .wednesday: "Wednesday"
    case .thursday: "Thursday"
    case .friday: "Friday"
    case .saturday: "Saturday"
    }
  }
  
  var abbreviatedName: String {
    switch self {
      
    case .sunday: "Sun"
    case .monday: "Mon"
    case .tuesday: "Tue"
    case .wednesday: "Wed"
    case .thursday: "Thu"
    case .friday: "Fri"
    case .saturday: "Sat"
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
