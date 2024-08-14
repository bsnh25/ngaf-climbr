//
//  ModelFixV1+Label.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 09/08/24.
//

extension ModelFixV2{
    
    enum Label: String, CaseIterable{
        case crossBodyShoulderLeft = "Cross Body Shoulder Left"
        case crossBodyShoulderRight = "Cross Body Shoulder Right"
        case frontShoulderStaticLeft = "Front Shoulder Static Left"
        case frontShoulderStaticRight = "Front Shoulder Static Right"
        case lowerBackSpinLeft = "Lower Back Spin Left"
        case lowerBackSpinRight = "Lower Back Spin Right"
        case neckDeepLeft = "Neck Deep Left"
        case neckDeepRight = "Neck Deep Right"
        case neckExtensionBack = "Neck Extension Back"
        case neckExtensionFront = "Neck Extension Front"
        case neckRotationLeft = "Neck Rotation Left"
        case neckRotationRight = "Neck Rotation Right"
        case still = "Still"
        case tricepStaticLeft = "Tricep Static Left"
        case tricepStaticRight = "Tricep Static Right"
        case upperBackStretchFront = "Upper Back Stretch Front"
        case upperBackStretchLeft = "Upper Back Stretch Left"
        case upperBackStretchRight = "Upper Back Stretch Right"
        case upperBackStretchUp = "Upper Back Stretch Up"
        
        init(_ string: String){
            guard let label = Label(rawValue: string) else{
                let typeName = String(reflecting: Label.self)
                fatalError("Add the `\(string)` label to the `\(typeName)` type.")
            }
            
            self = label
        }
    }
}
