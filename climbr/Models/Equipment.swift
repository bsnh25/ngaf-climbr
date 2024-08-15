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

enum HeadGear: String, CaseIterable, Identifiable{
    var id: HeadGear{
        self
    }
    
    case climbingBP
    case cuddlyBP
    case duffelBP
    case hikingBP
    
    var value: Int{
        switch self {
        case .climbingBP:
            0
        case .cuddlyBP:
            1
        case .duffelBP:
            2
        case .hikingBP:
            3
        }
    }
        
    var harga: Int{
        switch self {
        case .climbingBP:
            80
        case .cuddlyBP:
            80
        case .duffelBP:
            80
        case .hikingBP:
            80
        }
    }
        
    var imageBP: String {
        switch self {
        case .climbingBP:
            "ClimbingBP"
        case .cuddlyBP:
            "CuddlyBP"
        case .duffelBP:
            "DuffelBP"
        case .hikingBP:
            "HikingBP"
        }
    }
    
    var imageTent: String{
        switch self {
        case .climbingBP:
            "ClimbingT"
        case .cuddlyBP:
            "CuddlyT"
        case .duffelBP:
            "DuffelT"
        case .hikingBP:
            "HikingT"
        }
    }
}

enum Backpack: String, CaseIterable, Identifiable{
    var id: Backpack{
        self
    }
    
    case climbingBP
    case cuddlyBP
    case duffelBP
    case hikingBP
    
    var value: Int{
        switch self {
        case .climbingBP:
            0
        case .cuddlyBP:
            1
        case .duffelBP:
            2
        case .hikingBP:
            3
        }
    }
        
    var harga: Int{
        switch self {
        case .climbingBP:
            80
        case .cuddlyBP:
            80
        case .duffelBP:
            80
        case .hikingBP:
            80
        }
    }
        
    var imageBP: String {
        switch self {
        case .climbingBP:
            "ClimbingBP"
        case .cuddlyBP:
            "CuddlyBP"
        case .duffelBP:
            "DuffelBP"
        case .hikingBP:
            "HikingBP"
        }
    }
    
    var imageTent: String{
        switch self {
        case .climbingBP:
            "ClimbingT"
        case .cuddlyBP:
            "CuddlyT"
        case .duffelBP:
            "DuffelT"
        case .hikingBP:
            "HikingT"
        }
    }
}

enum HikingStick: String, CaseIterable, Identifiable{
    var id: HikingStick{
        self
    }
    
    case climbingBP
    case cuddlyBP
    case duffelBP
    case hikingBP
    
    var value: Int{
        switch self {
        case .climbingBP:
            0
        case .cuddlyBP:
            1
        case .duffelBP:
            2
        case .hikingBP:
            3
        }
    }
        
    var harga: Int{
        switch self {
        case .climbingBP:
            80
        case .cuddlyBP:
            80
        case .duffelBP:
            80
        case .hikingBP:
            80
        }
    }
        
    var imageBP: String {
        switch self {
        case .climbingBP:
            "ClimbingBP"
        case .cuddlyBP:
            "CuddlyBP"
        case .duffelBP:
            "DuffelBP"
        case .hikingBP:
            "HikingBP"
        }
    }
    
    var imageTent: String{
        switch self {
        case .climbingBP:
            "ClimbingT"
        case .cuddlyBP:
            "CuddlyT"
        case .duffelBP:
            "DuffelT"
        case .hikingBP:
            "HikingT"
        }
    }
}


enum Location: String, CaseIterable, Identifiable{
    var id: Location{
        self
    }
    
    case climbingBP
    case cuddlyBP
    case duffelBP
    case hikingBP
    
    var value: Int{
        switch self {
        case .climbingBP:
            0
        case .cuddlyBP:
            1
        case .duffelBP:
            2
        case .hikingBP:
            3
        }
    }
        
    var harga: Int{
        switch self {
        case .climbingBP:
            80
        case .cuddlyBP:
            80
        case .duffelBP:
            80
        case .hikingBP:
            80
        }
    }
        
    var imageBP: String {
        switch self {
        case .climbingBP:
            "ClimbingBP"
        case .cuddlyBP:
            "CuddlyBP"
        case .duffelBP:
            "DuffelBP"
        case .hikingBP:
            "HikingBP"
        }
    }
    
    var imageTent: String{
        switch self {
        case .climbingBP:
            "ClimbingT"
        case .cuddlyBP:
            "CuddlyT"
        case .duffelBP:
            "DuffelT"
        case .hikingBP:
            "HikingT"
        }
    }
}
