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
        
//        armProgress.typeLabel.setAccessibilityTitle("Arm Progress Result")
        armProgress.typeLabel.setAccessibilityTitle("Progress result section of exercise")
        armProgress.valueLabel.setAccessibilityLabel("Your arm progress is \(armTotal) out of 2")
        
//        neckProgress.typeLabel.setAccessibilityTitle("Neck Progress Result")
        neckProgress.typeLabel.setAccessibilityTitle("Progress result section of exercise")
        neckProgress.valueLabel.setAccessibilityLabel("Your neck progress is \(neckTotal) out of 2")
        
//        backProgress.typeLabel.setAccessibilityTitle("Back Progress Result")
        backProgress.typeLabel.setAccessibilityTitle("Progress result section of exercise")
        backProgress.valueLabel.setAccessibilityLabel("Your back progress is \(backTotal) out of 2")
        
        cointEarning.typeLabel.setAccessibilityTitle("Coin Earning Result")
        cointEarning.valueLabel.setAccessibilityLabel("Your coin earning is ")
        
        /// jangan lupa update greeting message
        if armTotal == 2 {
            armProgress.updateColor(.kResultTwo)
        } else if armTotal == 1 {
            armProgress.updateColor(.kResultOne)
        } else if armTotal == 0 {
            armProgress.updateColor(.red)
            greetingLabel.setText("You missed your \(armProgress.typeLabel.stringValue) movement! Let’s try to finish the whole sequence next time")
        }
        
        if neckTotal == 2 {
            neckProgress.updateColor(.kResultTwo)
        } else if neckTotal == 1 {
            neckProgress.updateColor(.kResultOne)
        } else if neckTotal == 0 {
            neckProgress.updateColor(.red)
            greetingLabel.setText("You missed your \(neckProgress.typeLabel.stringValue) movement! Let’s try to finish the whole sequence next time")
        }
        
        if backTotal == 2 {
            backProgress.updateColor(.kResultTwo)
        } else if backTotal == 1 {
            backProgress.updateColor(.kResultOne)
        } else if backTotal == 0{
            backProgress.updateColor(.red)
            greetingLabel.setText("You missed your \(backProgress.typeLabel.stringValue) movement! Let’s try to finish the whole sequence next time")
        }
        
        /// check progress left
        var progress: Int = 0
        
        if armTotal == 2 && neckTotal == 2 && backTotal == 2 {
            DispatchQueue.main.async {
                self.updateProgress()
                progress = Int(UserDefaults.standard.double(forKey: UserDefaultsKey.kProgressSession))
                self.greetingLabel.setText("\(progress < 4 ? "You did a great stretching session! Only \(progress) more to go to hit your daily goal!" : "Fantastic! You hit your daily goal! Keep your streak going!")")
            }
            armProgress.updateColor(.kResultTwo)
            neckProgress.updateColor(.kResultTwo)
            backProgress.updateColor(.kResultTwo)
            
        } else if (armTotal ==  1 || neckTotal ==  1 || backTotal == 1) && (armTotal > 0 && neckTotal > 0 && backTotal > 0) {
            DispatchQueue.main.async {
                self.updateProgress()
                progress = Int(UserDefaults.standard.double(forKey: UserDefaultsKey.kProgressSession))
                self.greetingLabel.setText("\(progress < 4 ? "You almost missed your streak! Let’s try to finish the whole sequence next time" : "Great! You hit your daily goal! Don't forget to finish the whole sequence next time")")
            }
            
        } else if armTotal == 0 && neckTotal == 0 && backTotal == 0 {
            armProgress.updateColor(.red)
            neckProgress.updateColor(.red)
            backProgress.updateColor(.red)
            greetingLabel.setText("You didn't do any stretching! So you didn't get any coins")
            
        } else if (armTotal == 0 && neckTotal == 0) || (armTotal == 0 && backTotal == 0) || (neckTotal == 0 && backTotal == 0){
            greetingLabel.setText("You missed two type of movements! Let’s try to finish the whole sequence next time")
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
