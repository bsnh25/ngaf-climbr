//
//  StretchingResultVC+Extension.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 11/08/24.
//

import Foundation

extension StretchingResultVC {
    func calculatePoints() {
        let points = movementList.reduce(0) { partial, next in
            return partial + next.rewardPoint
        }
        
        var label: String = "You didn’t earn any coins, but the next round could be yours!"
        
        if points > 0 {
            label = "You earned \(points) coins"
        }
        
        rewardPointLabel.setText(label)
    }
    
    @objc func goToMainMenu() {
        self.pop()
    }
    
    @objc func continueWorking() {
    }
}
