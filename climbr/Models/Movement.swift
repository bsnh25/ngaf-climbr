//
//  Movement.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Cocoa

struct Movement {
    var id: UUID = UUID()
    var name: ExerciseName
    var type: ExerciseType
    var duration: TimeInterval = 15
    var preview: NSImage
    var thumbnail: NSImage
    var rewardPoint: Int
    
    static var setOfMovements: [[Movement]] = [
        /// Set 1
        [
            /// Neck Movement
            Movement(name: .NeckDeepLeft, type: .neck, preview: .neckDeepLeft, thumbnail: .neckDeepLeft, rewardPoint: 5),
            Movement(name: .NeckDeepRight, type: .neck, preview: .neckDeepRight, thumbnail: .neckDeepRight, rewardPoint: 5),
            Movement(name: .NeckExtensionBack, type: .neck, preview: .neckExtensionBack, thumbnail: .neckExtensionBack, rewardPoint: 5),
            Movement(name: .NeckExtensionFront, type: .neck, preview: .neckExtensionFront, thumbnail: .neckExtensionFront, rewardPoint: 5),
            
            /// Arm Movement
            Movement(name: .CrossBodyShoulderLeft, type: .arm, preview: .crossBodyShoulderLeft, thumbnail: .crossBodyShoulderLeft, rewardPoint: 5),
            Movement(name: .CrossBodyShoulderRight, type: .arm, preview: .crossBodyShoulderRight, thumbnail: .crossBodyShoulderRight, rewardPoint: 5),
            
            /// Back Movement
            Movement(name: .UpperBackStretchLeft, type: .back, preview: .upperBackStrechLeft, thumbnail: .upperBackStrechLeft, rewardPoint: 5),
            Movement(name: .UpperBackStretchRight, type: .back, preview: .upperBackStretchRight, thumbnail: .upperBackStretchRight, rewardPoint: 5),
        ],
        
        /// Set 2
        [
            /// Neck Movement
            Movement(name: .NeckRotationLeft, type: .neck, preview: .neckRotationLeft, thumbnail: .neckRotationLeft, rewardPoint: 5),
            Movement(name: .NeckRotationRight, type: .neck, preview: .neckRotationRight, thumbnail: .neckRotationRight, rewardPoint: 5),
            Movement(name: .NeckExtensionBack, type: .neck, preview: .neckExtensionBack, thumbnail: .neckExtensionBack, rewardPoint: 5),
            Movement(name: .NeckExtensionFront, type: .neck, preview: .neckExtensionFront, thumbnail: .neckExtensionFront, rewardPoint: 5),
            
            /// Arm Movement
            Movement(name: .FrontShoulderStaticLeft, type: .arm, preview: .frontShoulderStaticLeft, thumbnail: .frontShoulderStaticLeft, rewardPoint: 5),
            Movement(name: .FrontShoulderStaticRight, type: .arm, preview: .frontShoulderStaticRight, thumbnail: .frontShoulderStaticRight, rewardPoint: 5),
            
            /// Back Movement
            Movement(name: .UpperBackStretchUp, type: .back, preview: .upperBackStretchUp, thumbnail: .upperBackStretchUp, rewardPoint: 5),
            Movement(name: .UpperBackStretchFront, type: .back, preview: .upperBackStretchFront, thumbnail: .upperBackStretchFront, rewardPoint: 5),
        ],
        
        /// Set 3
        [
            /// Neck Movement
            Movement(name: .NeckDeepLeft, type: .neck, preview: .neckDeepLeft, thumbnail: .neckDeepLeft, rewardPoint: 5),
            Movement(name: .NeckDeepRight, type: .neck, preview: .neckDeepRight, thumbnail: .neckDeepRight, rewardPoint: 5),
            Movement(name: .NeckRotationLeft, type: .neck, preview: .neckRotationLeft, thumbnail: .neckRotationLeft, rewardPoint: 5),
            Movement(name: .NeckRotationRight, type: .neck, preview: .neckRotationRight, thumbnail: .neckRotationRight, rewardPoint: 5),
            
            /// Arm Movement
            Movement(name: .TricepStaticLeft, type: .arm, preview: .tricepStaticLeft, thumbnail: .tricepStaticLeft, rewardPoint: 5),
            Movement(name: .TricepStaticRight, type: .arm, preview: .tricepStaticRight, thumbnail: .tricepStaticRight, rewardPoint: 5),
            
            /// Back Movement
            Movement(name: .LowerBackSpinLeft, type: .back, preview: .lowerBackSpinLeft, thumbnail: .lowerBackSpinLeft, rewardPoint: 5),
            Movement(name: .LowerBackSpinRight, type: .back, preview: .lowerBackSpinRight, thumbnail: .lowerBackSpinRight, rewardPoint: 5),
        ],
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
    case Negative = "negative"
}
