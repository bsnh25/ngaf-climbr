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
    
    static var headGears : [EquipmentModel] = [
        EquipmentModel(item: EquipmentItem.emptyHG, type: EquipmentType.head, isUnlocked: true),
        EquipmentModel(item: EquipmentItem.climberCrownHG, type: EquipmentType.head, isUnlocked: false),
        EquipmentModel(item: EquipmentItem.cozyCragglerHG, type: EquipmentType.head, isUnlocked: false),
        EquipmentModel(item: EquipmentItem.festiveFollyHG, type: EquipmentType.head, isUnlocked: false),
        EquipmentModel(item: EquipmentItem.trailbazerTamHG, type: EquipmentType.head, isUnlocked: false)
    ]
    
    static var backPacks : [EquipmentModel] = [
        EquipmentModel(item: EquipmentItem.emptyBP, type: EquipmentType.back, isUnlocked: true),
        EquipmentModel(item: EquipmentItem.climbingBP, type: EquipmentType.back, isUnlocked: false),
        EquipmentModel(item: EquipmentItem.cuddlyBP, type: EquipmentType.back, isUnlocked: false),
        EquipmentModel(item: EquipmentItem.duffelBP, type: EquipmentType.back, isUnlocked: false),
        EquipmentModel(item: EquipmentItem.hikingBP, type: EquipmentType.back, isUnlocked: false)
    ]
    
    static var hikingSticks : [EquipmentModel] = [
        EquipmentModel(item: EquipmentItem.emptyS, type: EquipmentType.hand, isUnlocked: true),
        EquipmentModel(item: EquipmentItem.highWizardS, type: EquipmentType.hand, isUnlocked: false),
        EquipmentModel(item: EquipmentItem.iceGripS, type: EquipmentType.hand, isUnlocked: false),
        EquipmentModel(item: EquipmentItem.natureGuideS, type: EquipmentType.hand, isUnlocked: false),
        EquipmentModel(item: EquipmentItem.trekTrooperS, type: EquipmentType.hand, isUnlocked: false)
    ]
    
    static var locations : [EquipmentModel] = [
        EquipmentModel(item: EquipmentItem.jungleJumble, type: EquipmentType.location, isUnlocked: true),
        EquipmentModel(item: EquipmentItem.snowySummit, type: EquipmentType.location, isUnlocked: false)
    ]
}


enum EquipmentType: String {
    case head = "head",
         hand = "hand",
         back = "back",
         location = "location"
}

enum EquipmentItem: String, CaseIterable, Identifiable, Codable {
    var id: EquipmentItem {
        self
    }
    
    case emptyHG
    case climberCrownHG
    case cozyCragglerHG
    case festiveFollyHG
    case trailbazerTamHG
     
    case emptyBP
    case climbingBP
    case cuddlyBP
    case duffelBP
    case hikingBP
    
    case emptyS
    case highWizardS
    case iceGripS
    case natureGuideS
    case trekTrooperS
    
    case jungleJumble
    case snowySummit
    
    var itemName: String{
        switch self {
        case .climberCrownHG:
            "Climber Crown"
        case .cozyCragglerHG:
            "Cozy Craggler"
        case .festiveFollyHG:
            "Festive Folly"
        case .trailbazerTamHG:
            "Trailblazer Tam"
        case .climbingBP:
            "Climbing"
        case .cuddlyBP:
            "Cuddly"
        case .duffelBP:
            "Duffel"
        case .hikingBP:
            "Hiking"
        case .highWizardS:
            "High Wizard"
        case .iceGripS:
            "Ice Grip"
        case .natureGuideS:
            "Nature Guide"
        case .trekTrooperS:
            "Trek Trooper"
        case .jungleJumble:
            "Jungle Jumble"
        case .snowySummit:
            "Snowy Summit"
        case .emptyHG:
            ""
        case .emptyBP:
            ""
        case .emptyS:
            ""
        }
    }
    
    var itemID: Int{
        switch self {
        case .emptyHG:
            0
        case .climberCrownHG:
            1
        case .cozyCragglerHG:
            2
        case .festiveFollyHG:
            3
        case .trailbazerTamHG:
            4
        case .emptyBP:
            0
        case .climbingBP:
            1
        case .cuddlyBP:
            2
        case .duffelBP:
            3
        case .hikingBP:
            4
        case .emptyS:
            0
        case .highWizardS:
            1
        case .iceGripS:
            2
        case .natureGuideS:
            3
        case .trekTrooperS:
            4
        case .jungleJumble:
            0
        case .snowySummit:
            1
        }
    }
    
    var price: Int{
        switch self {
        case .emptyHG:
            0
        case .climberCrownHG:
            80
        case .cozyCragglerHG:
            90
        case .festiveFollyHG:
            100
        case .trailbazerTamHG:
            110
        case .emptyBP:
            0
        case .climbingBP:
            80
        case .cuddlyBP:
            90
        case .duffelBP:
            100
        case .hikingBP:
            110
        case .emptyS:
            0
        case .highWizardS:
            80
        case .iceGripS:
            90
        case .natureGuideS:
            100
        case .trekTrooperS:
            110
        case .jungleJumble:
            140
        case .snowySummit:
            150
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
        case .emptyHG:
            "EmptyHG"
        case .emptyBP:
            "EmptyBP"
        case .emptyS:
            "EmptyS"
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
        case .emptyHG:
            ""
        case .emptyBP:
            ""
        case .emptyS:
            ""
        }
    }
    
    var name: String {
        switch self {
        case .climberCrownHG:
            "Climber Crown"
        case .cozyCragglerHG:
            "Cozy Craggler"
        case .festiveFollyHG:
            "Festive Folly"
        case .trailbazerTamHG:
            "Trailblazer Tam"
        case .climbingBP:
            "Climbing"
        case .cuddlyBP:
            "Cuddly"
        case .duffelBP:
            "Duffel"
        case .hikingBP:
            "Hiking"
        case .highWizardS:
            "High Wizard"
        case .iceGripS:
            "Ice Grip"
        case .natureGuideS:
            "Nature Guide"
        case .trekTrooperS:
            "Trek Trooper"
        case .jungleJumble:
            "Jungle Jumble"
        case .snowySummit:
            "Snowy Summit"
        case .emptyHG:
            "Default Head"
        case .emptyBP:
            "Default Body"
        case .emptyS:
            "Default Stick"
        }
    }
}
