//
//  Excercise+CoreDataProperties.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 02/11/24.
//
//

import Foundation
import CoreData


extension Excercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Excercise> {
        return NSFetchRequest<Excercise>(entityName: "Excercise")
    }

    @NSManaged public var duration: Int64
    @NSManaged public var id: UUID?
    @NSManaged public var preview: String?
    @NSManaged public var rewardPoint: Int64
    @NSManaged public var title: String?
    @NSManaged public var type: String?

}

extension Excercise : Identifiable {

}
