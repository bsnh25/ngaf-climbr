//
//  Equipment.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Foundation

struct EquipmentModel {
    var id: Int
    var image: String
    var imageCompanion: String
    var isUnlocked: Bool
    var name: String
    var price: Int
//    var riveAsset: String
    var type: EquipmentType
}

enum EquipmentType {
    case head, hand, back, location
}

var headGearItems : [EquipmentModel] = [
    EquipmentModel(id: 0, image: HeadGear.climberCrownHG.imageBP, imageCompanion: HeadGear.climberCrownHG.imageNeck, isUnlocked: true, name: HeadGear.climberCrownHG.rawValue, price: HeadGear.climberCrownHG.harga, type: .head),
    EquipmentModel(id: 1, image: HeadGear.cozyCragglerHG.imageBP, imageCompanion: HeadGear.cozyCragglerHG.imageNeck, isUnlocked: false, name: HeadGear.cozyCragglerHG.rawValue, price: HeadGear.cozyCragglerHG.harga, type: .head),
    EquipmentModel(id: 2, image: HeadGear.festiveFollyHG.imageBP, imageCompanion: HeadGear.festiveFollyHG.imageNeck, isUnlocked: false, name: HeadGear.festiveFollyHG.rawValue, price: HeadGear.festiveFollyHG.harga, type: .head),
    EquipmentModel(id: 3, image: HeadGear.trailbazerTamHG.imageBP, imageCompanion: HeadGear.trailbazerTamHG.imageNeck, isUnlocked: false, name: HeadGear.trailbazerTamHG.rawValue, price: HeadGear.trailbazerTamHG.harga, type: .head),
]

var BackpackItems : [EquipmentModel] = [
    EquipmentModel(id: 0, image: Backpack.climbingBP.imageBP, imageCompanion: Backpack.climbingBP.imageTent, isUnlocked: true, name: Backpack.climbingBP.rawValue, price: Backpack.climbingBP.harga, type: .head),
    EquipmentModel(id: 1, image: Backpack.cuddlyBP.imageBP, imageCompanion: Backpack.cuddlyBP.imageTent, isUnlocked: false, name: Backpack.cuddlyBP.rawValue, price: Backpack.cuddlyBP.harga, type: .head),
    EquipmentModel(id: 2, image: Backpack.duffelBP.imageBP, imageCompanion: Backpack.duffelBP.imageTent, isUnlocked: false, name: Backpack.duffelBP.rawValue, price: Backpack.duffelBP.harga, type: .head),
    EquipmentModel(id: 3, image: Backpack.hikingBP.imageBP, imageCompanion: Backpack.hikingBP.imageTent, isUnlocked: false, name: Backpack.hikingBP.rawValue, price: Backpack.hikingBP.harga, type: .head),
]

var HikingStickItems : [EquipmentModel] = [
    EquipmentModel(id: 0, image: HikingStick.highWizardS.imageS, imageCompanion: HikingStick.highWizardS.imageSecondary, isUnlocked: true, name: HikingStick.highWizardS.rawValue, price: HikingStick.highWizardS.harga, type: .head),
    EquipmentModel(id: 1, image: HikingStick.iceGripS.imageS, imageCompanion: HikingStick.iceGripS.imageSecondary, isUnlocked: false, name: HikingStick.iceGripS.rawValue, price: HikingStick.iceGripS.harga, type: .head),
    EquipmentModel(id: 2, image: HikingStick.natureGuideS.imageS, imageCompanion: HikingStick.natureGuideS.imageSecondary, isUnlocked: false, name: HikingStick.natureGuideS.rawValue, price: HikingStick.natureGuideS.harga, type: .head),
    EquipmentModel(id: 3, image: HikingStick.trekTrooperS.imageS, imageCompanion: HikingStick.trekTrooperS.imageSecondary, isUnlocked: false, name: HikingStick.trekTrooperS.rawValue, price: HikingStick.trekTrooperS.harga, type: .head),
]

var LocationsItems : [EquipmentModel] = [
    EquipmentModel(id: 0, image: Location.jungleJumble.image, imageCompanion: Location.jungleJumble.imageSecondary, isUnlocked: true, name: Location.jungleJumble.rawValue, price: Location.jungleJumble.harga, type: .head),
    EquipmentModel(id: 1, image: Location.snowySummit.image, imageCompanion: Location.snowySummit.imageSecondary, isUnlocked: false, name: Location.snowySummit.rawValue, price: Location.snowySummit.harga, type: .head)
]

enum HeadGear: String, CaseIterable, Identifiable{
    var id: HeadGear{
        self
    }
    
    case climberCrownHG
    case cozyCragglerHG
    case festiveFollyHG
    case trailbazerTamHG
    
    var value: Int{
        switch self {
        case .climberCrownHG:
            0
        case .cozyCragglerHG:
            1
        case .festiveFollyHG:
            2
        case .trailbazerTamHG:
            3
        }
    }
        
    var harga: Int{
        switch self {
        case .climberCrownHG:
            80
        case .cozyCragglerHG:
            80
        case .festiveFollyHG:
            80
        case .trailbazerTamHG:
            80
        }
    }
        
    var imageBP: String {
        switch self {
        case .climberCrownHG:
            "ClimberCrownHG"
        case .cozyCragglerHG:
            "CozyCragglerHG"
        case .festiveFollyHG:
            "FestiveFollyHG"
        case .trailbazerTamHG:
            "TrailblazerTamHG"
        }
    }
    
    var imageNeck: String{
        switch self {
        case .climberCrownHG:
            "ClimberCrownN"
        case .cozyCragglerHG:
            "CozyCragglerN"
        case .festiveFollyHG:
            "FestiveFollyN"
        case .trailbazerTamHG:
            "TrailblazerTamN"
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
    
    case highWizardS
    case iceGripS
    case natureGuideS
    case trekTrooperS
    
    var value: Int{
        switch self {
        case .highWizardS:
            0
        case .iceGripS:
            1
        case .natureGuideS:
            2
        case .trekTrooperS:
            3
        }
    }
        
    var harga: Int{
        switch self {
        case .highWizardS:
            80
        case .iceGripS:
            80
        case .natureGuideS:
            80
        case .trekTrooperS:
            80
        }
    }
        
    var imageS: String {
        switch self {
        case .highWizardS:
            "HighWizardS"
        case .iceGripS:
            "IceGripS"
        case .natureGuideS:
            "NatureGuideS"
        case .trekTrooperS:
            "TrekTrooperS"
        }
    }
    
    var imageSecondary: String{
        switch self {
        case .highWizardS:
            ""
        case .iceGripS:
            ""
        case .natureGuideS:
            ""
        case .trekTrooperS:
            ""
        }
    }
}

enum Location: String, CaseIterable, Identifiable{
    var id: Location{
        self
    }
    
    case jungleJumble
    case snowySummit
    
    var value: Int{
        switch self {
        case .jungleJumble:
            0
        case .snowySummit:
            1
        }
    }
        
    var harga: Int{
        switch self {
        case .jungleJumble:
            80
        case .snowySummit:
            80
        }
    }
        
    var image: String {
        switch self {
        case .jungleJumble:
            "JungleJumble"
        case .snowySummit:
            "SnowySummit"
        }
    }
    
    var imageSecondary: String{
        switch self {
        case .jungleJumble:
            ""
        case .snowySummit:
            ""
        }
    }
}
