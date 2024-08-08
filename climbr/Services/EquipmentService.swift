//
//  EquipmentService.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import Foundation

protocol EquipmentService {
    func getEquipments(equipmentType: EquipmentType) -> [Equipment]
    func purchaseEquipment(data: Equipment, userPoint: Int)
}
