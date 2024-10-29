//
//  StreakManager.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 28/10/24.
//

import Foundation
import CoreData

class StreakManager: StreakService {
  let container : NSManagedObjectContext?
  
  init(controller: PersistenceController?){
    self.container = controller?.container.viewContext
  }
  
  func getStreakHistory() -> [Streak] {
    guard let container else { return [] }
    
    let request: NSFetchRequest<StreakEntity> = StreakEntity.fetchRequest()
    
    do {
      let items = try container.fetch(request)
      
      return items.map {
        Streak(
          date: $0.date!,
          completedSession: Int($0.completedSession),
          collectedEquipmentId: Int($0.collectedEquipmentId)
        )
      }
    } catch {
      print("Error fetching streak data: \(error.localizedDescription)")
      return []
    }
  }
  
  func saveStreak(_ data: Streak) {
    guard let container else { return }
    
    let streak: StreakEntity = StreakEntity(context: container)
    
    streak.date = data.date
    streak.completedSession = Int16(data.completedSession)
    streak.collectedEquipmentId = Int16(data.collectedEquipmentId)
    
    do {
      let items = try container.save()
    } catch {
      print("Error storing streak \(error.localizedDescription)")
    }
  }
  
}
