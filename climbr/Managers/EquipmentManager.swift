//
//  EquipmentManager.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import Foundation
import CoreData

class EquipmentManager: EquipmentService {
    
    let container : NSManagedObjectContext?
    
    init(controller: PersistenceController?){
        self.container = controller?.container.viewContext
    }
    
    func seedDatabase() {
        guard let container else { return }
        
        var items: [EquipmentModel] = []
        items.append(contentsOf: EquipmentModel.headGears)
        items.append(contentsOf: EquipmentModel.backPacks)
        items.append(contentsOf: EquipmentModel.hikingSticks)
        items.append(contentsOf: EquipmentModel.locations)
        
        items.forEach { equipment in
            let data = Equipment(context: container)
            data.id         = Int64(equipment.item.itemID)
            data.type       = equipment.type.rawValue
            data.name       = equipment.item.rawValue
            data.isUnlocked = equipment.isUnlocked
            data.image      = equipment.item.image
            data.price      = Int64(equipment.item.price)
        }
        
        do {
            try container.save()
            print("Success")
        } catch {
            print("Error: ", error.localizedDescription)
        }
    }
    
    func getEquipments(equipmentType: EquipmentType) -> [EquipmentModel] {
        
        let predicate: NSPredicate = NSPredicate(format: "type == %@", equipmentType.rawValue)
        
        let request: NSFetchRequest<Equipment> = Equipment.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        request.predicate = predicate
        
        do {
            guard let container = container else { return [] }
            
            let items = try container.fetch(request)
            
            return convertToEquipmentModel(for: items)
        } catch {
            print("Error fetching user preference entries: \(error.localizedDescription)")
            return []
        }
    }
    
    func purchaseEquipment(data: EquipmentModel) {
        guard let container = container else { return }
        
        guard let equipment = fetchEquipment(byID: data.item.rawValue , context: container) else {
            print("No equipment found with ID \(data.item.itemID)")
             return
         }
        
        do {
            equipment.isUnlocked = true
            try container.save()
        } catch {
            print("Error when purchase")
        }
        
    }
    
    
    func convertToEquipmentModel(for equipment: [Equipment]) -> [EquipmentModel] {
        return equipment.compactMap { equipment in
            guard let typeString = equipment.type,
                  let type = EquipmentType(rawValue: typeString),
                  let item = EquipmentItem(rawValue: equipment.name ?? "") else {
                return nil
            }
            
            return EquipmentModel(item: item, type: type, isUnlocked: equipment.isUnlocked)
        }
    }
    
    
    func fetchEquipment(byID name: String, context: NSManagedObjectContext) -> Equipment? {
        let fetchRequest: NSFetchRequest<Equipment> = Equipment.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name as String)
        
        do {
            let result = try context.fetch(fetchRequest)
            return result.first
        } catch {
            print("Failed to fetch equipment: \(error)")
            return nil
        }
    }
    
//    func updateCurrentItem(head: EquipmentItem, hand: EquipmentItem, back: EquipmentItem, location: EquipmentItem){
//        self.currentHead = head
//        self.currentHand = hand
//        self.currentBack = back
//        self.currentLocation = location
//    }

}
