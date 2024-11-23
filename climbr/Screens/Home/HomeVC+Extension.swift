//
//  HomeVC + Extension.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 14/08/24.
//

import AppKit
import Swinject
import UserNotifications
import SnapKit

extension HomeVC {
    
    @objc
    func actionStore(){
        if let vc = Container.shared.resolve(ShopItemVC.self) {
            vc.delegate = self
            push(to: vc)
            print("go to shop page")
            //            vc.view.setFrameSize(NSSize(width: 400, height: 500))
            //            view.addSubview(vc.view)
            //
            //            vc.view.snp.makeConstraints { make in
            //                make.top.equalTo(settingButton.snp.bottom).offset(20)
            //                make.leading.equalTo(settingButton.snp.leading)
            //            }
            
            if UserDefaults.standard.bool(forKey:UserDefaultsKey.kTutorialShop) == true {
                guard let tutorialVc = Container.shared.resolve(TutorialShopVC.self) else {return}
                if UserDefaults.standard.bool(forKey: UserDefaultsKey.kTutorial) == false {
                    let points = 110
                    if let character {
                        charService.updatePoint(character: character, points: points)
                        print("Ini point gratis : \(String((charService.getCharacterData()!.point)))")
                    }
                }
                push(to: tutorialVc, disablePreviousInteraction: false)
                vc.delegateTutorial = tutorialVc
            }
            
            print("go to shop page")
        }
    }
    
    @objc
    func actionStartSession(){  
        if let vc = Container.shared.resolve(StretchingVC.self) {
            
            if UserDefaults.standard.bool(forKey: UserDefaultsKey.kTutorial) == true {
                vc.setOfMovements = Movement.setOfMovements.first!
            }
            
//            if isShowPopover {
//                popover.close()
//                storeButton.updateColorBox(false)
//                isShowPopover.toggle()
//            }
            
            push(to: vc)
            print("go to stretching session")
        }
    }
    
    @objc
    func actionSetting(){
        guard let settingsVC = Container.shared.resolve(SettingVC.self) else {return}
        settingsVC.preferredContentSize = CGSize(width: 863.34, height: 660.34)
        if isShowPopover {
            popover.close()
            storeButton.updateColorBox(false)
            isShowPopover.toggle()
        }
      self.presentAsSheet(settingsVC)
    }
    
    @objc
    func actionAudio(_ sender: NSButton){
        guard let audio = audioService else {return}
        isSoundTapped.toggle()
      
        if sender.state == .on {
            audio.muteSound()
        } else {
            audio.unmuteSound()
            audio.playBackgroundMusic(fileName: "summer")
        }
    }
    
    func dailyProgress(){
        print("Progress Value : \(progressValue)")
        progressStretch.minValue = 0
        progressStretch.maxValue = 4
        progressStretch.doubleValue = progressValue
    }
    
    
    
    @objc
    func validateYesterday(){
        observeAnimation()
        let date = UserDefaults.standard.object(forKey: UserDefaultsKey.kDateNow) as! Date
        if Calendar.current.isDateInYesterday(date) {
            print("Date param : \(date)")
            print("Date current : \(Calendar.current)")
            UserDefaults.standard.setValue(0, forKey: UserDefaultsKey.kProgressSession)
            UserDefaults.standard.setValue(0, forKey: UserDefaultsKey.kNotificationCount)
            UserDefaults.standard.setValue(Date(), forKey: UserDefaultsKey.kDateNow)
            return
        }
        
    }
    
    func updateProgressData(){
        let progress = UserDefaults.standard.double(forKey: UserDefaultsKey.kProgressSession)
        progressStretch.doubleValue = progress
        progressText.setText("\(Int(progress)) / 4 sessions")
//        arrNotif.popLast()
        character = charService.getCharacterData()
        updatePoint()
    }
    
    
    func observeTimer(){
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(validateYesterday), userInfo: nil, repeats: true)
        
    }
    
    func updatePoint(){
        points.setText(String(character?.point ?? 0))
        points.setAccessibilityValue("\(character?.point ?? 0) coins")
    }
    
    func observeAnimation() {
        ///get notification count and current progress
        let notificationCount = UserDefaults.standard.integer(forKey: UserDefaultsKey.kNotificationCount)
        let progress = UserDefaults.standard.integer(forKey: UserDefaultsKey.kProgressSession)
        let calendar = Calendar.current
        let now = Date()
        
        /// Mendapatkan komponen hari dan waktu saat ini
        let currentDay = calendar.component(.weekday, from: now) - 1
        let currentHour = calendar.component(.hour, from: now)
        let currentMinute = calendar.component(.minute, from: now)
        
        /// State for default walk
        var characterState: Double = 0
        var backgroundState: Double = character?.locationEquipment == .jungleJumble ? 0 : 1
        
        guard let userPreference = charService.getPreferences() else { return }
        /// state 0: walk
        /// state 1: tired/fatigue
        /// state 2: death
        /// state 3...n: walk
        for workingHour in userPreference.workingHours {
            guard workingHour.isEnabled && workingHour.day == currentDay else {
                print("Hari \(workingHour.day) \(workingHour.isEnabled ? "aktif" : "tidak aktif") ")
                continue
            }
            
            let startComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: workingHour.startHour)
            let endComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: workingHour.endHour)
            
            print("Ini start hour \(workingHour.startHour) dan ini end hour \(workingHour.endHour) untuk hari \(workingHour.day)")
            
            guard let startHour = startComponents.hour, let startMinute = startComponents.minute,
                  let endHour = endComponents.hour, let endMinute = endComponents.minute else {
                continue
            }
            
            if (currentHour > startHour || (currentHour == startHour && currentMinute >= startMinute)) &&
                (currentHour < endHour || (currentHour == endHour && currentMinute <= endMinute)) {
                if notificationCount > 0 {
                    characterState = 1
                    backgroundState = character?.locationEquipment == .jungleJumble ? 0 : 1
                } else {
                    characterState = 0
                    backgroundState = character?.locationEquipment == .jungleJumble ? 0 : 1
                }
            } else {
                if progress < 4 {
                    characterState = 4
                    backgroundState = character?.locationEquipment == .jungleJumble ? 6 : 7
                } else if progress >= 4 {
                    characterState = 4
                    backgroundState = character?.locationEquipment == .jungleJumble ? 2 : 3
                }
            }
        }
        
        animationMain?.setInput("WalkingStyle", value: characterState)
        animationMain?.setInput("Background", value: backgroundState)
        print("Ini walking style => \(characterState)")
        print("Ini background state => \(backgroundState)")
    }
    
    func updateCharacter() {
        guard let character else { return }
        
        animationMain!.setInput("Headgear", value: Double(character.headEquipment.itemID))
        
        animationMain!.setInput("Stick", value: Double(character.handEquipment.itemID))
        animationMain!.setInput("Jacket", value: Double(character.handEquipment.itemID))
        animationMain!.setInput("RightThigh", value: Double(character.handEquipment.itemID))
        animationMain!.setInput("LeftThigh", value: Double(character.handEquipment.itemID))
        animationMain!.setInput("RightShin", value: Double(character.handEquipment.itemID))
        animationMain!.setInput("LeftShin", value: Double(character.handEquipment.itemID))
        
        animationMain!.setInput("Backpack", value: Double(character.backEquipment.itemID))
        animationMain!.setInput("Tent", value: Double(character.backEquipment.itemID))
        print()
    }
}

extension HomeVC : ChooseCaraterDelegate {
    func selectedGender(gender: Gender) {
        print("gender adalah : \(gender.rawValue)")
        
        if gender == .male{
            do {
                try animationMain?.configureModel(artboardName: "HomescreenMale")
            }catch{
                print("Error")
            }
        }else{
            do {
                try animationMain?.configureModel(artboardName: "HomescreenFemale")
            }catch{
                print("Error")
            }
        }
        observeAnimation()
    }
    
    func characterDidUpdate() {
        character = self.charService.getCharacterData()
        observeAnimation()
        updatePoint()
        updateCharacter()
    }
}
