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
            cointEarning.valueLabel.setText("🪙 \(points)")
        }
        
        rewardPointLabel.setText(label)
        
        if let char {
            charService?.updatePoint(character: char, points: points)
            print("Ini point yang di dapat : \(String((charService?.getCharacterData()!.point)!))")
        }
    }
    
    func calculateDurations() {
        var durations: Double = movementList.reduce(0) { partialResult, next in
            return partialResult + next.duration
        }
        
        durations /= 60
        
        guard durations > 0 else {
            self.dummyCharacter.image = char?.gender == .male ? .boyNoCoin : .girlNoCoin
            greetingLabel.setText("Same time, here?")
            rewardPointLabel.setText("\(char?.name ?? "Character") is too tired to find coins.")
            stretchingDurationLabel.setText("You haven’t reduce your sedentary time.")
            return
        }
        
        if let affirmationText = affirmationTexts.randomElement() {
            greetingLabel.setText(affirmationText)
        }
        
        stretchingDurationLabel.setText("\(awardsText) \(String(format: "%.f", durations)) minutes")
    }
    
    func calculateProgress() {
        var armTotal: Int = 0
        var neckTotal: Int = 0
        var backTotal: Int = 0
        
        movementList.forEach { movement in
            if movement.type == .arm && armTotal < 2 {
                armTotal += 1
            }
            if movement.type == .neck && neckTotal < 2 {
                neckTotal += 1
            }
            if movement.type == .back && backTotal < 2{
                backTotal += 1
            }
        }
        
        armProgress.valueLabel.setText("\(armTotal)/2")
        neckProgress.valueLabel.setText("\(neckTotal)/2")
        backProgress.valueLabel.setText("\(backTotal)/2")
        
        if armTotal == 2 {
            armProgress.updateColor(.kResultTwo)
        } else if armTotal == 1 {
            armProgress.updateColor(.kResultOne)
        } else {
            armProgress.updateColor(.red)
        }
        
        if neckTotal == 2 {
            neckProgress.updateColor(.kResultTwo)
        } else if neckTotal == 1 {
            neckProgress.updateColor(.kResultOne)
        } else {
            neckProgress.updateColor(.red)
        }
        
        if backTotal == 2 {
            backProgress.updateColor(.kResultTwo)
        } else if backTotal == 1 {
            backProgress.updateColor(.kResultOne)
        } else {
            backProgress.updateColor(.red)
        }
    }
    
    func getUserData() {
        self.char = charService?.getCharacterData()
        self.dummyCharacter.image = char?.gender == .male ? .maleCoin : .femaleCoin
    }
    
    @objc func goToMainMenu() {
        UserDefaults.standard.set(false, forKey: UserDefaultsKey.kTutorial)
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
