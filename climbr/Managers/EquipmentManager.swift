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
    
    func getEquipments(equipmentType: EquipmentType) -> [Equipment] {
        
        var predicate: NSPredicate? = nil
        
        predicate = NSPredicate(format: "type == %@", equipmentType.rawValue)
        var request: NSFetchRequest<Equipment> = Equipment.fetchRequest()
        request.predicate = predicate
        
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Error fetching user preference entries: \(error.localizedDescription)")
            return []
        }
    }
    
    func purchaseEquipment(data: Equipment, userPoint: Int) {
        
    }
    
    //MARK: TODO 
}
