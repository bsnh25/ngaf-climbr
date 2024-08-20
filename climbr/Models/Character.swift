//
//  Character.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Foundation

struct CharacterModel {
    var id: UUID = UUID()
    var name: String
    var gender: Gender
    var point: Int64
    var headEquipment: EquipmentItem = .emptyHG
    var handEquipment: EquipmentItem = .emptyS
    var backEquipment: EquipmentItem = .emptyBP
    
}

enum Gender: String{
    case male = "male" , female = "female"
}
