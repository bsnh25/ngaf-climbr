//
//  Equipment.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Foundation

struct EquipmentModel {
    var id: UUID
    var image: String
    var isUnlocked: Bool
    var name: String
    var price: Int64
    var riveAsset: String
    var type: String
}

enum EquipmentType {
    case head, hand, back
}
