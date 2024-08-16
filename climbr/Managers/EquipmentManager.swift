//
//  EquipmentManager.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import Foundation
import CoreData

class EquipmentManager: EquipmentService {
    let container = NSPersistentContainer(name: "ClimbrDataSource")
    
    init() {
        container.loadPersistentStores { success, err in
            guard let error = err else {return}
            print("Err Load Equipment : \(error.localizedDescription)")
        }
    }
    
    func getEquipments(equipmentType: EquipmentType) -> [EquipmentModel] {
        
        var predicate: NSPredicate? = nil
        
        predicate = NSPredicate(format: "type == %@", equipmentType.hashValue)
        var request: NSFetchRequest<Equipment> = Equipment.fetchRequest()
        request.predicate = predicate
        
        do {
            let equipmentArr = try container.viewContext.fetch(request)
            return convertToEquipmentModel(for: equipmentArr)
        } catch {
            print("Error fetching user preference entries: \(error.localizedDescription)")
            return []
        }
    }
    
    func purchaseEquipment(data: Equipment, userPoint: Int) {
        guard let equipment = fetchEquipment(byID: data.id, context: container.viewContext) else {
             print("No equipment found with ID \(data.id)")
             return
         }
        
        do {
            equipment.isUnlocked = false
            try container.viewContext.save()
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
    
    func fetchEquipment(byID id: Int64, context: NSManagedObjectContext) -> Equipment? {
        let fetchRequest: NSFetchRequest<Equipment> = Equipment.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let result = try context.fetch(fetchRequest)
            return result.first
        } catch {
            print("Failed to fetch equipment: \(error)")
            return nil
        }
    }

}
