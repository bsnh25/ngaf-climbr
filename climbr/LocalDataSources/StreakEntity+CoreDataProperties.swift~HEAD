//
//  StreakEntity+CoreDataProperties.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 28/10/24.
//
//

import Foundation
import CoreData


extension StreakEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StreakEntity> {
        return NSFetchRequest<StreakEntity>(entityName: "StreakEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var completedSession: Int16
    @NSManaged public var collectedEquipmentId: Int16

}

extension StreakEntity : Identifiable {

}
