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
        
        var label: String = "\(char?.name ?? "Character") is too tired to find coins."
        
        if points > 0 {
            label = "While resting, \(char?.name ?? "Character") found \(points) coins!"
            updateProgress()
        }
        
        rewardPointLabel.setText(label)
        
        if let char {
            charService?.updatePoint(character: char, points: points)
        }
    }
    
    func calculateDurations() {
        var durations: Double = movementList.reduce(0) { partialResult, next in
            return partialResult + next.duration
        }
        
        durations /= 60
        
        guard durations > 0 else {
            greetingLabel.setText("Same time, here?")
            stretchingDurationLabel.setText("\(char?.name ?? "Character") is too tired to find coins.")
            rewardPointLabel.setText("You haven’t reduce your sedentary time.")
            return
        }
        
        if let affirmationText = affirmationTexts.randomElement() {
            greetingLabel.setText(affirmationText)
        }
        
        stretchingDurationLabel.setText("\(awardsText) \(String(format: "%.f", durations)) minutes")
    }
    
    func getUserData() {
        self.char = charService?.getCharacterData()
    }
    
    func calculateDurations() {
        var durations: Double = movementList.reduce(0) { partialResult, next in
            return partialResult + next.duration
        }
        
        durations /= 60
        
        if let affirmationText = affirmationTexts.randomElement() {
            greetingLabel.setText(affirmationText)
        }
        
        stretchingDurationLabel.setText("\(awardsText) \(String(format: "%.f", durations)) minutes")
    }
    
    @objc func goToMainMenu() {
        self.pop()
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
        print("Update Last Stretching Date : \(String(describing: UserDefaults.standard.object(forKey: UserDefaultsKey.kDateNow)))")
        print("Update Progress Stretching : \(UserDefaults.standard.double(forKey: UserDefaultsKey.kProgressSession))")
    }
}
