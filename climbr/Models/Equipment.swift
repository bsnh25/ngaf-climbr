//
//  Equipment.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Foundation

struct EquipmentModel {
    var item: EquipmentItem
    var type: EquipmentType
    var isUnlocked: Bool
}

var headGears : [EquipmentModel] = [
    EquipmentModel(item: EquipmentItem.climberCrownHG, type: EquipmentType.head, isUnlocked: false),
    EquipmentModel(item: EquipmentItem.cozyCragglerHG, type: EquipmentType.head, isUnlocked: false),
    EquipmentModel(item: EquipmentItem.festiveFollyHG, type: EquipmentType.head, isUnlocked: false),
    EquipmentModel(item: EquipmentItem.trailbazerTamHG, type: EquipmentType.head, isUnlocked: false)
]

var backPacks : [EquipmentModel] = [
    EquipmentModel(item: EquipmentItem.climbingBP, type: EquipmentType.back, isUnlocked: false),
    EquipmentModel(item: EquipmentItem.cuddlyBP, type: EquipmentType.back, isUnlocked: false),
    EquipmentModel(item: EquipmentItem.duffelBP, type: EquipmentType.back, isUnlocked: false),
    EquipmentModel(item: EquipmentItem.hikingBP, type: EquipmentType.back, isUnlocked: false)
]

var hikingSticks : [EquipmentModel] = [
    EquipmentModel(item: EquipmentItem.highWizardS, type: EquipmentType.hand, isUnlocked: false),
    EquipmentModel(item: EquipmentItem.iceGripS, type: EquipmentType.hand, isUnlocked: false),
    EquipmentModel(item: EquipmentItem.natureGuideS, type: EquipmentType.hand, isUnlocked: false),
    EquipmentModel(item: EquipmentItem.trekTrooperS, type: EquipmentType.hand, isUnlocked: false)
]

var locations : [EquipmentModel] = [
    EquipmentModel(item: EquipmentItem.jungleJumble, type: EquipmentType.location, isUnlocked: true),
    EquipmentModel(item: EquipmentItem.snowySummit, type: EquipmentType.location, isUnlocked: false)
]

enum EquipmentType {
    case head, hand, back, location
}

enum EquipmentItem: String, CaseIterable, Identifiable {
    var id: EquipmentItem {
        self
    }
    
    case climberCrownHG
    case cozyCragglerHG
    case festiveFollyHG
    case trailbazerTamHG
    
    case climbingBP
    case cuddlyBP
    case duffelBP
    case hikingBP
    
    case highWizardS
    case iceGripS
    case natureGuideS
    case trekTrooperS
    
    case jungleJumble
    case snowySummit
    
    var itemID: Int{
        switch self {
        case .climberCrownHG:
            0
        case .cozyCragglerHG:
            1
        case .festiveFollyHG:
            2
        case .trailbazerTamHG:
            3
        case .climbingBP:
            4
        case .cuddlyBP:
            5
        case .duffelBP:
            6
        case .hikingBP:
            7
        case .highWizardS:
            8
        case .iceGripS:
            9
        case .natureGuideS:
            10
        case .trekTrooperS:
            11
        case .jungleJumble:
            12
        case .snowySummit:
            13
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
        case .climbingBP:
            80
        case .cuddlyBP:
            80
        case .duffelBP:
            80
        case .hikingBP:
            80
        case .highWizardS:
            80
        case .iceGripS:
            80
        case .natureGuideS:
            80
        case .trekTrooperS:
            80
        case .jungleJumble:
            80
        case .snowySummit:
            80
        }
    }
    
    var image: String {
        switch self {
        case .climberCrownHG:
            "ClimberCrownHG"
        case .cozyCragglerHG:
            "CozyCragglerHG"
        case .festiveFollyHG:
            "FestiveFollyHG"
        case .trailbazerTamHG:
            "TrailblazerTamHG"
        case .climbingBP:
            "ClimbingBP"
        case .cuddlyBP:
            "CuddlyBP"
        case .duffelBP:
            "DuffelBP"
        case .hikingBP:
            "HikingBP"
        case .highWizardS:
            "HighWizardS"
        case .iceGripS:
            "IceGripS"
        case .natureGuideS:
            "NatureGuideS"
        case .trekTrooperS:
            "TrekTrooperS"
        case .jungleJumble:
            "JungleJumble"
        case .snowySummit:
            "SnowySummit"
        }
    }
    
    var secondaryImage: String {
        switch self {
        case .climberCrownHG:
            "ClimberCrownN"
        case .cozyCragglerHG:
            "CozyCragglerN"
        case .festiveFollyHG:
            "FestiveFollyN"
        case .trailbazerTamHG:
            "TrailblazerTamN"
        case .climbingBP:
            "ClimbingT"
        case .cuddlyBP:
            "CuddlyT"
        case .duffelBP:
            "DuffelT"
        case .hikingBP:
            "HikingT"
        case .highWizardS:
            ""
        case .iceGripS:
            ""
        case .natureGuideS:
            ""
        case .trekTrooperS:
            ""
        case .jungleJumble:
            ""
        case .snowySummit:
            ""
        }
    }
}
