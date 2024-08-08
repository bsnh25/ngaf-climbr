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
    @NSManaged public var reminder_interval: Int64
    @NSManaged public var start_working_hour: Date?
    @NSManaged public var end_working_hour: Date?
    @NSManaged public var launch_at_login: Bool

}

extension UserPreferences : Identifiable {

}
