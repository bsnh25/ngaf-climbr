//
//  Character+CoreDataProperties.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 18/08/24.
//
//

import Foundation
import CoreData


extension Character {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
    }

    @NSManaged public var backEquipment: String?
    @NSManaged public var handEquipment: String?
    @NSManaged public var headEquipment: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var point: Int64

}

extension Character : Identifiable {

}
