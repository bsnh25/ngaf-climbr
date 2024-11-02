//
//  Equipment+CoreDataProperties.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 16/08/24.
//
//

import Foundation
import CoreData


extension Equipment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Equipment> {
        return NSFetchRequest<Equipment>(entityName: "Equipment")
    }

    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var isUnlocked: Bool
    @NSManaged public var name: String?
    @NSManaged public var price: Int64
    @NSManaged public var type: String?

}

extension Equipment : Identifiable {

}
