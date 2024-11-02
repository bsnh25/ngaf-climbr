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
    let calendar = Calendar.current
    
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE"
    
    var components = DateComponents()
    components.weekday = self.rawValue
    
    let date = Calendar.current.date(from: components)!
    
    return formatter.string(from: date)
  }
  
  var abbreviatedName: String {
    let calendar = Calendar.current
    
    let formatter = DateFormatter()
    formatter.dateFormat = "E"
    
    var components = DateComponents()
    components.weekday = self.rawValue
    
    let date = Calendar.current.date(from: components)!
    
    return formatter.string(from: date)
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
