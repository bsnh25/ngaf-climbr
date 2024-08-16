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
    
    func getEquipments(equipmentType: EquipmentType) -> [EquipmentModel] {
        
        var predicate: NSPredicate? = nil
        
        predicate = NSPredicate(format: "type == %@", equipmentType.hashValue)
        let request: NSFetchRequest<Equipment> = Equipment.fetchRequest()
        request.predicate = predicate
        
        do {
            guard let container = container else {return []}
            let equipmentArr = try container.fetch(request)
            return convertToEquipmentModel(for: equipmentArr)
        } catch {
            print("Error fetching user preference entries: \(error.localizedDescription)")
            return []
        }
    }
    
    func purchaseEquipment(data: EquipmentModel) {
        guard let container = container else {return}
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

}
