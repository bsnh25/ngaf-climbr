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
            return partial + next.rewardPoint
        }
        
        var label: String = "You didn’t earn any coins, but the next round could be yours!"
        
        if points > 0 {
            label = "You earned \(points) coins"
            
            #warning("uhh what's that brother?")
            guard let homeVc = Container.shared.resolve(HomeVC.self) else { return }
            homeVc.updateProgress(UserDefaults.standard.object(forKey: UserDefaultsKey.kDateNow) as! Date)
        }
        
        rewardPointLabel.setText(label)
        
        if let user = userService?.getUserData() {
            userService?.updatePoint(user: user, points: points)
        }
    }
    
    @objc func goToMainMenu() {
        self.pop()
    }
    
    @objc func continueWorking() {
    }
    
//    func updateProgress(){
//        //1. check value sekarang berapa
//        //2. if value kurang dari max value, return 3, else return maxValue
//        //3. kalau kurang, value ditambah 0.25,
//        HomeVC().progressValue = (HomeVC().progressValue < HomeVC().progressStretch.maxValue) ? HomeVC().progressValue+0.25 : HomeVC().progressStretch.maxValue
//    }
}
