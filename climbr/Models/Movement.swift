//
//  Movement.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Foundation

struct Movement {
    var id: UUID                = UUID()
    var name: ExerciseName
    var type: ExerciseType
    var duration: TimeInterval  = 15
    var preview: String
    var rewardPoint: Int
    
    static var items: [Movement] = [
        Movement(name: .NeckDeepLeft, type: .neck, preview: "", rewardPoint: 5),
        Movement(name: .NeckDeepRight, type: .neck, preview: "", rewardPoint: 5),
        Movement(name: .NeckRotationLeft, type: .neck, preview: "", rewardPoint: 5),
        Movement(name: .NeckRotationRight, type: .neck, preview: "", rewardPoint: 5),
        Movement(name: .NeckExtensionBack, type: .neck, preview: "", rewardPoint: 5),
        Movement(name: .NeckExtensionFront, type: .neck, preview: "", rewardPoint: 5),
    ]
    
    static var setOfMovements: [[Movement]] = [
        /// Set 1
        [
            /// Neck Movement
            Movement(name: .NeckDeepLeft, type: .neck, preview: "", rewardPoint: 5),
            Movement(name: .NeckDeepRight, type: .neck, preview: "", rewardPoint: 5),
            Movement(name: .NeckExtensionBack, type: .neck, preview: "", rewardPoint: 5),
            Movement(name: .NeckExtensionFront, type: .neck, preview: "", rewardPoint: 5),
            
            /// Arm Movement
            Movement(name: .CrossBodyShoulderLeft, type: .arm, preview: "", rewardPoint: 5),
            Movement(name: .CrossBodyShoulderRight, type: .arm, preview: "", rewardPoint: 5),
            
            /// Back Movement
            Movement(name: .UpperBackStretchLeft, type: .back, preview: "", rewardPoint: 5),
            Movement(name: .UpperBackStretchRight, type: .back, preview: "", rewardPoint: 5),
        ],
        
        /// Set 2
        [
            /// Neck Movement
            Movement(name: .NeckRotationLeft, type: .neck, preview: "", rewardPoint: 5),
            Movement(name: .NeckRotationRight, type: .neck, preview: "", rewardPoint: 5),
            Movement(name: .NeckExtensionBack, type: .neck, preview: "", rewardPoint: 5),
            Movement(name: .NeckExtensionFront, type: .neck, preview: "", rewardPoint: 5),
            
            /// Arm Movement
            Movement(name: .FrontShoulderStaticLeft, type: .arm, preview: "", rewardPoint: 5),
            Movement(name: .FrontShoulderStaticRight, type: .arm, preview: "", rewardPoint: 5),
            
            /// Back Movement
            Movement(name: .UpperBackStretchUp, type: .back, preview: "", rewardPoint: 5),
            Movement(name: .UpperBackStretchFront, type: .back, preview: "", rewardPoint: 5),
        ],
        
        /// Set 3
        [
            /// Neck Movement
            Movement(name: .NeckDeepLeft, type: .neck, preview: "", rewardPoint: 5),
            Movement(name: .NeckDeepRight, type: .neck, preview: "", rewardPoint: 5),
            Movement(name: .NeckRotationLeft, type: .neck, preview: "", rewardPoint: 5),
            Movement(name: .NeckRotationRight, type: .neck, preview: "", rewardPoint: 5),
            
            /// Arm Movement
            Movement(name: .TricepStaticLeft, type: .arm, preview: "", rewardPoint: 5),
            Movement(name: .TricepStaticRight, type: .arm, preview: "", rewardPoint: 5),
            
            /// Back Movement
            Movement(name: .LowerBackSpinLeft, type: .back, preview: "", rewardPoint: 5),
            Movement(name: .LowerBackSpinRight, type: .back, preview: "", rewardPoint: 5),
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
}
