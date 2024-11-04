//
//  StreakService.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 28/10/24.
//

import Foundation

protocol StreakService {
  func getStreakHistory() -> [Streak]
  func saveStreak(_ data: Streak)
}
