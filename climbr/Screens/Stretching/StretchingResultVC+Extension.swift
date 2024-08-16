//
//  StretchingResultVC+Extension.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 11/08/24.
//

import Foundation
import Swinject

extension StretchingResultVC {
    func calculatePoints(){
        let points = movementList.reduce(0) { partial, next in
            return partial + next.rewardPoint
        }
        
        var label: String = "You didn’t earn any coins, but the next round could be yours!"
        
        if points > 0 {
            label = "You earned \(points) coins"
            updateProgress()
        }
        
        rewardPointLabel.setText(label)
        
        if let user = userService?.getUserData() {
            userService?.updatePoint(user: user, points: points)
        }
    }
    
    @objc func goToMainMenu() {
        self.pop()
//        if calculatePoints() > 0 {
//            guard let homeVc = Container.shared.resolve(HomeVC.self) else {return}
//            updateProgress()
////            homeVc.dailyProgress()
//            homeVc.progressText.stringValue = "Dari Main Menu"
//        }
    }
    
    @objc func continueWorking() {
        self.view.window?.miniaturize(self)
    }
    
    func updateProgress(){
        var progress = UserDefaults.standard.double(forKey: UserDefaultsKey.kProgressSession)
        if progress < 4.0 {
            progress += 1.0
            UserDefaults.standard.set(progress, forKey: UserDefaultsKey.kProgressSession)
        }
        UserDefaults.standard.set(Date(), forKey: UserDefaultsKey.kDateNow)
    }
}
