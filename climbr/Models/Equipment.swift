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
    var price: Int
//    var riveAsset: String
    var type: EquipmentType
}

enum EquipmentType {
    case head, hand, back, location
}

enum Headgear: String, CaseIterable, Identifiable, Codable{
    var id: Headgear{
        self
    }
    
    case asset0
    case asset1
    case asset2
    case asset3
    case asset4
    case asset5
    
    var value: Int {
        switch self {
        case .asset0:
            0
        case .asset1:
            1
        case .asset2:
            2
        case .asset3:
            3
        case .asset4:
            4
        case .asset5:
            5
        }
    }
        
    var harga: Int {
        switch self {
        case .asset0:
            0
        case .asset1:
            150
        case .asset2:
            150
        case .asset3:
            170
        case .asset4:
            170
        case .asset5:
            170
        }
    }
        
    var image: String {
        switch self {
        case .asset0:
            "A"
        case .asset1:
            "B"
        case .asset2:
            "C"
        case .asset3:
            "C"
        case .asset4:
            "D"
        case .asset5:
            "E"
        }
    }
}

enum Backpack: String, CaseIterable, Identifiable, Codable{
    var id: Backpack{
        self
    }
    
    case asset0
    case asset1
    case asset2
    case asset3
    case asset4
    case asset5
    
    var value: Int {
        switch self {
        case .asset0:
            0
        case .asset1:
            1
        case .asset2:
            2
        case .asset3:
            3
        case .asset4:
            4
        case .asset5:
            5
        }
    }
        
    var harga: Int {
        switch self {
        case .asset0:
            0
        case .asset1:
            150
        case .asset2:
            150
        case .asset3:
            170
        case .asset4:
            170
        case .asset5:
            170
        }
    }
        
    var image: String {
        switch self {
        case .asset0:
            "A"
        case .asset1:
            "B"
        case .asset2:
            "C"
        case .asset3:
            "C"
        case .asset4:
            "D"
        case .asset5:
            "E"
        }
    }
}

enum HikingStick: String, CaseIterable, Identifiable, Codable{
    var id: HikingStick{
        self
    }
    
    case asset0
    case asset1
    case asset2
    case asset3
    case asset4
    
    var value: Int {
        switch self {
        case .asset0:
            0
        case .asset1:
            1
        case .asset2:
            2
        case .asset3:
            3
        case .asset4:
            4
        }
    }
        
    var harga: Int {
        switch self {
        case .asset0:
            0
        case .asset1:
            150
        case .asset2:
            150
        case .asset3:
            170
        case .asset4:
            170
        }
    }
        
    var image: String {
        switch self {
        case .asset0:
            "A"
        case .asset1:
            "B"
        case .asset2:
            "C"
        case .asset3:
            "C"
        case .asset4:
            "D"
        }
    }
}

enum Location: String, CaseIterable, Identifiable, Codable{
    var id: Location{
        self
    }
    
    case asset0
    case asset1
    case asset2
    case asset3
    
    var value: Int {
        switch self {
        case .asset0:
            0
        case .asset1:
            1
        case .asset2:
            2
        case .asset3:
            3
        }
    }
        
    var harga: Int {
        switch self {
        case .asset0:
            0
        case .asset1:
            150
        case .asset2:
            150
        case .asset3:
            170
        }
    }
        
    var image: String {
        switch self {
        case .asset0:
            "A"
        case .asset1:
            "B"
        case .asset2:
            "C"
        case .asset3:
            "C"
        }
    }
}
