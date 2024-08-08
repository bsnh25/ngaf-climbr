//
//  User+CoreDataProperties.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 08/08/24.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var point: Int64
    @NSManaged public var character: Character?

}

extension User : Identifiable {

}
