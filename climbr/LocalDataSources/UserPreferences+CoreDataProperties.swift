//
//  UserPreferences+CoreDataProperties.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 08/08/24.
//
//

import Foundation
import CoreData


extension UserPreferences {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserPreferences> {
        return NSFetchRequest<UserPreferences>(entityName: "UserPreferences")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var reminderInterval: Int64
    @NSManaged public var startWorkingHour: Date?
    @NSManaged public var endWorkingHour: Date?
    @NSManaged public var launchAtLogin: Bool

}

extension UserPreferences : Identifiable {

}
