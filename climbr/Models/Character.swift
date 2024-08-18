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
    var headEquipment: EquipmentItem = .climberCrownHG
    var handEquipment: EquipmentItem = .climbingBP
    var backEquipment: EquipmentItem = .climbingBP
}

enum Gender: String{
    case male = "male" , female = "female"
}
