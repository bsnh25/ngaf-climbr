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
