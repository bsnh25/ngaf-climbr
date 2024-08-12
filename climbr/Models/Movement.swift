//
//  Movement.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Foundation

struct Movement {
    var id: UUID                = UUID()
    var title: String
    var type: ExerciseType
    var duration: TimeInterval  = 15
    var preview: String
    var rewardPoint: Int
    
    static var items: [Movement] = [
        Movement(title: "Neck Rotation Left", type: .neck, preview: "", rewardPoint: 5),
        Movement(title: "Neck Rotation Right", type: .neck, preview: "", rewardPoint: 5),
        Movement(title: "Neck Deep Left", type: .neck, preview: "", rewardPoint: 5),
        Movement(title: "Neck Deep Right", type: .neck, preview: "", rewardPoint: 5),
        Movement(title: "Neck Extension Back", type: .neck, preview: "", rewardPoint: 5),
        Movement(title: "Neck Extension Front", type: .neck, preview: "", rewardPoint: 5),
    ]
}

enum ExerciseType {
    case neck, arm, back
}

enum ExerciseName: String, CaseIterable {
    case CrossBodyShoulderLeft = "Cross Body Shoulder Left"
    case CrossBodyShoulderRight = "Cross Body Shoulder Right"
    case FrontShoulderStaticLeft = "Front Shoulder Static Left"
    case FrontShoulderStaticRight = "Front Shoulder Static Right"
    case LowerBackSpinLeft = "Lower Back Spin Left"
    case LowerBackSpinRight = "Lower Back Spin Right"
    case NeckDeepLeft = "Neck Deep Left"
    case NeckDeepRight = "Neck Deep Right"
    case NeckExtensionBack = "Neck Extension Back"
    case NeckExtensionFront = "Neck Extension Front"
    case NeckRotationLeft = "Neck Rotation Left"
    case NeckRotationRight = "Neck Rotation Right"
    case TricepStaticLeft = "Tricep Static Left"
    case TricepStaticRight = "Tricep Static Right"
    case UpperBackStretchFront = "Upper Back Stretch Front"
    case UpperBackStretchLeft = "Upper Back Stretch Left"
    case UpperBackStretchRight = "Upper Back Stretch Right"
    case UpperBackStretchUp = "Upper Back Stretch Up"
    case Still = "Still"
}
