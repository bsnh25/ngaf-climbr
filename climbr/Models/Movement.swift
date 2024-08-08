//
//  Movement.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Foundation

struct MovementModel {
    var id: UUID
    var duration: Int64
    var preview: String
    var rewardPoint: Int64
    var title: String
    var type: String
}

enum ExerciseType {
    case neck, arm, back
}
