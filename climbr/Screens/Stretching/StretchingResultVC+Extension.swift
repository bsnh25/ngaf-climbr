//
//  StretchingResultVC+Extension.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 11/08/24.
//

import Foundation
import Swinject

extension StretchingResultVC {
    func calculatePoints() {
        let points = movementList.reduce(0) { partial, next in
            return partial + next.duration
        }
        
        var label: String = "You didn’t earn any coins, but the next round could be yours!"
        
        if !points.isZero {
            label = "You earned \(points) coins"
            guard let homeVc = Container.shared.resolve(HomeVC.self) else {return}
            homeVc.updateProgress(UserDefaults.standard.object(forKey: "kDateNow") as! Date)
        }
        
        rewardPointLabel.setText(label)
    }
    
    @objc func goToMainMenu() {
        self.pop()
        UserDefaults.standard.setValue(false, forKey: "kStretch")
    }
    
    @objc func continueWorking() {
        UserDefaults.standard.setValue(false, forKey: "kStretch")
    }
    
//    func updateProgress(){
//        //1. check value sekarang berapa
//        //2. if value kurang dari max value, return 3, else return maxValue
//        //3. kalau kurang, value ditambah 0.25,
//        HomeVC().progressValue = (HomeVC().progressValue < HomeVC().progressStretch.maxValue) ? HomeVC().progressValue+0.25 : HomeVC().progressStretch.maxValue
//    }
}
