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
    var preview: ExerciseVideo
    var thumbnail: NSImage
    var rewardPoint: Int
    
    static var setOfMovements: [[Movement]] = [
        /// Set 1
        [
            /// Neck Movement
            Movement(name: .NeckDeepLeft, type: .neck, preview: .thumbnailNeckDeepLeft, thumbnail: .thumbnailNeckDeepLeft, rewardPoint: 5),
            Movement(name: .NeckDeepRight, type: .neck, preview: .thumbnailNeckDeepRight, thumbnail: .thumbnailNeckDeepRight, rewardPoint: 5),
            Movement(name: .NeckExtensionBack, type: .neck, preview: .thumbnailNeckExtensionBack, thumbnail: .thumbnailNeckExtensionBack, rewardPoint: 5),
            Movement(name: .NeckExtensionFront, type: .neck, preview: .thumbnailNeckExtensionFront, thumbnail: .thumbnailNeckExtensionFront, rewardPoint: 5),
            
            /// Arm Movement
            Movement(name: .CrossBodyShoulderLeft, type: .arm, preview: .thumbnailCrossBodyShoudlerLeft, thumbnail: .thumbnailCrossBodyShoudlerLeft, rewardPoint: 5),
            Movement(name: .CrossBodyShoulderRight, type: .arm, preview: .thumbnailCrossBodyShoudlerRight, thumbnail: .thumbnailCrossBodyShoudlerRight, rewardPoint: 5),
            
            /// Back Movement
            Movement(name: .UpperBackStretchLeft, type: .back, preview: .thumbnailUpperBackStretchLeft, thumbnail: .thumbnailUpperBackStretchLeft, rewardPoint: 5),
            Movement(name: .UpperBackStretchRight, type: .back, preview: .thumbnailUpperBackStretchRight, thumbnail: .thumbnailUpperBackStretchRight, rewardPoint: 5),
        ],
        
        /// Set 2
        [
            /// Neck Movement
            Movement(name: .NeckRotationLeft, type: .neck, preview: .thumbnailNeckRotationLeft, thumbnail: .thumbnailNeckRotationLeft, rewardPoint: 5),
            Movement(name: .NeckRotationRight, type: .neck, preview: .thumbnailNeckRotationRight, thumbnail: .thumbnailNeckRotationRight, rewardPoint: 5),
            Movement(name: .NeckExtensionBack, type: .neck, preview: .thumbnailNeckExtensionBack, thumbnail: .thumbnailNeckExtensionBack, rewardPoint: 5),
            Movement(name: .NeckExtensionFront, type: .neck, preview: .thumbnailNeckExtensionFront, thumbnail: .thumbnailNeckExtensionFront, rewardPoint: 5),
            
            /// Arm Movement
            Movement(name: .FrontShoulderStaticLeft, type: .arm, preview: .thumbnailFrontShoulderStaticLeft, thumbnail: .thumbnailFrontShoulderStaticLeft, rewardPoint: 5),
            Movement(name: .FrontShoulderStaticRight, type: .arm, preview: .thumbnailFrontShoulderStaticRight, thumbnail: .thumbnailFrontShoulderStaticRight, rewardPoint: 5),
            
            /// Back Movement
            Movement(name: .UpperBackStretchUp, type: .back, preview: .thumbnailUpperBackStretchUp, thumbnail: .thumbnailUpperBackStretchUp, rewardPoint: 5),
            Movement(name: .UpperBackStretchFront, type: .back, preview: .thumbnailUpperBackStretchFront, thumbnail: .thumbnailUpperBackStretchFront, rewardPoint: 5),
        ],
        
        /// Set 3
        [
            /// Neck Movement
            Movement(name: .NeckDeepLeft, type: .neck, preview: .thumbnailNeckDeepLeft, thumbnail: .thumbnailNeckDeepLeft, rewardPoint: 5),
            Movement(name: .NeckDeepRight, type: .neck, preview: .thumbnailNeckDeepRight, thumbnail: .thumbnailNeckDeepRight, rewardPoint: 5),
            Movement(name: .NeckRotationLeft, type: .neck, preview: .thumbnailNeckRotationLeft, thumbnail: .thumbnailNeckRotationLeft, rewardPoint: 5),
            Movement(name: .NeckRotationRight, type: .neck, preview: .thumbnailNeckRotationRight, thumbnail: .thumbnailNeckRotationRight, rewardPoint: 5),
            
            /// Arm Movement
            Movement(name: .TricepStaticLeft, type: .arm, preview: .thumbnailTricepStaticLeft, thumbnail: .thumbnailTricepStaticLeft, rewardPoint: 5),
            Movement(name: .TricepStaticRight, type: .arm, preview: .thumbnailTricepStaticRight, thumbnail: .thumbnailTricepStaticRight, rewardPoint: 5),
            
            /// Back Movement
            Movement(name: .LowerBackSpinLeft, type: .back, preview: .thumbnailLowerBackSpinLeft, thumbnail: .thumbnailLowerBackSpinLeft, rewardPoint: 5),
            Movement(name: .LowerBackSpinRight, type: .back, preview: .thumbnailLowerBackSpinRight, thumbnail: .thumbnailLowerBackSpinRight, rewardPoint: 5),
        ],
        
        [
            /// Neck Movement
            Movement(name: .NeckDeepRight, type: .neck, preview: .thumbnailNeckDeepRight, thumbnail: .thumbnailNeckDeepRight, rewardPoint: 5),
            Movement(name: .NeckDeepLeft, type: .neck, preview: .thumbnailNeckDeepLeft, thumbnail: .thumbnailNeckDeepLeft, rewardPoint: 5),
            
            /// Arm Movement
            Movement(name: .FrontShoulderStaticRight, type: .arm, preview: .thumbnailFrontShoulderStaticRight, thumbnail: .thumbnailFrontShoulderStaticRight, rewardPoint: 5),
            Movement(name: .FrontShoulderStaticLeft, type: .arm, preview: .thumbnailFrontShoulderStaticLeft, thumbnail: .thumbnailFrontShoulderStaticLeft, rewardPoint: 5),
            
            /// Back Movement
            Movement(name: .LowerBackSpinRight, type: .back, preview: .thumbnailLowerBackSpinRight, thumbnail: .thumbnailLowerBackSpinRight, rewardPoint: 5),
            Movement(name: .LowerBackSpinLeft, type: .back, preview: .thumbnailLowerBackSpinLeft, thumbnail: .thumbnailLowerBackSpinLeft, rewardPoint: 5),
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

enum ExerciseVideo: String {
    case thumbnailCrossBodyShoudlerLeft = "crossBodyShoulder-Left"
    case thumbnailCrossBodyShoudlerRight = "crossBodyShoulder-Right"
    case thumbnailFrontShoulderStaticLeft = "frontShoulderStatic-Left"
    case thumbnailFrontShoulderStaticRight = "frontShoulderStatic-Right"
    case thumbnailLowerBackSpinLeft = "lowerBackSpin-Left"
    case thumbnailLowerBackSpinRight = "lowerBackSpin-Right"
    case thumbnailNeckDeepLeft = "neckDeep-Left"
    case thumbnailNeckDeepRight = "neckDeep-Right"
    case thumbnailNeckExtensionBack = "neckExtension-Back"
    case thumbnailNeckExtensionFront = "neckExtension-Front"
    case thumbnailNeckRotationLeft = "neckRotation-Left"
    case thumbnailNeckRotationRight = "neckRotation-Right"
    case thumbnailTricepStaticLeft = "tricepStatic-Left"
    case thumbnailTricepStaticRight = "tricepStatic-Right"
    case thumbnailUpperBackStretchFront = "upperBackStretch-Front"
    case thumbnailUpperBackStretchLeft = "upperBackStretch-Left"
    case thumbnailUpperBackStretchRight = "upperBackStretch-Right"
    case thumbnailUpperBackStretchUp = "upperBackStretch-Up"
}
