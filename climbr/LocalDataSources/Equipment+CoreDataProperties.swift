//
//  Equipment+CoreDataProperties.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 08/08/24.
//
//

import Foundation
import CoreData


extension Equipment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Equipment> {
        return NSFetchRequest<Equipment>(entityName: "Equipment")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var type: String?
    @NSManaged public var riveAsset: String?
    @NSManaged public var isUnlocked: Bool
    @NSManaged public var price: Int64
    @NSManaged public var charactersWithBackEquipment: NSSet?
    @NSManaged public var charactersWithHeadEquipment: NSSet?
    @NSManaged public var charactersWithHandEquipment: NSSet?

}

// MARK: Generated accessors for charactersWithBackEquipment
extension Equipment {

    @objc(addCharactersWithBackEquipmentObject:)
    @NSManaged public func addToCharactersWithBackEquipment(_ value: Character)

    @objc(removeCharactersWithBackEquipmentObject:)
    @NSManaged public func removeFromCharactersWithBackEquipment(_ value: Character)

    @objc(addCharactersWithBackEquipment:)
    @NSManaged public func addToCharactersWithBackEquipment(_ values: NSSet)

    @objc(removeCharactersWithBackEquipment:)
    @NSManaged public func removeFromCharactersWithBackEquipment(_ values: NSSet)

}

// MARK: Generated accessors for charactersWithHeadEquipment
extension Equipment {

    @objc(addCharactersWithHeadEquipmentObject:)
    @NSManaged public func addToCharactersWithHeadEquipment(_ value: Character)

    @objc(removeCharactersWithHeadEquipmentObject:)
    @NSManaged public func removeFromCharactersWithHeadEquipment(_ value: Character)

    @objc(addCharactersWithHeadEquipment:)
    @NSManaged public func addToCharactersWithHeadEquipment(_ values: NSSet)

    @objc(removeCharactersWithHeadEquipment:)
    @NSManaged public func removeFromCharactersWithHeadEquipment(_ values: NSSet)

}

// MARK: Generated accessors for charactersWithHandEquipment
extension Equipment {

    @objc(addCharactersWithHandEquipmentObject:)
    @NSManaged public func addToCharactersWithHandEquipment(_ value: Character)

    @objc(removeCharactersWithHandEquipmentObject:)
    @NSManaged public func removeFromCharactersWithHandEquipment(_ value: Character)

    @objc(addCharactersWithHandEquipment:)
    @NSManaged public func addToCharactersWithHandEquipment(_ values: NSSet)

    @objc(removeCharactersWithHandEquipment:)
    @NSManaged public func removeFromCharactersWithHandEquipment(_ values: NSSet)

}

extension Equipment : Identifiable {

}
