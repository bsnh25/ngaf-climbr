//
//  Movement+CoreDataProperties.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 08/08/24.
//
//

import Foundation
import CoreData


extension Movement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movement> {
        return NSFetchRequest<Movement>(entityName: "Movement")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var duration: Int64
    @NSManaged public var preview: String?
    @NSManaged public var rewardPoint: Int64
    @NSManaged public var type: String?

}

extension Movement : Identifiable {

}
