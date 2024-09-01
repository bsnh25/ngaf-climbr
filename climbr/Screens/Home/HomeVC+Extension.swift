//
//  HomeVC + Extension.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 14/08/24.
//

import AppKit
import Swinject
import UserNotifications

extension HomeVC {
    
    @objc
    func actionStore(){
        if let vc = Container.shared.resolve(ShopItemVC.self) {
            vc.delegate = self
            push(to: vc)
            print("go to stretching shop")
        }
    }
    
    @objc
    func actionStartSession(){
        if let vc = Container.shared.resolve(StretchingVC.self) {
            
            let isTutorial = UserDefaults.standard.bool(forKey: UserDefaultsKey.kTutorial)
            
            if isTutorial {
                vc.setOfMovements = Movement.setOfMovements.first!
            }
            
            push(to: vc)
            print("go to stretching session")
        }
    }
    
    @objc
    func actionSetting(){
        guard let settingsVC = Container.shared.resolve(SettingVC.self) else {return}
        settingsVC.preferredContentSize = CGSize(width: 412, height: 358)
        self.presentAsModalWindow(settingsVC)
    }
    
    @objc
    func actionAudio(){
        guard let audio = audioService else {return}
        isSoundTapped.toggle()
        if isSoundTapped{
            audio.muteSound()
            audioButton.image = NSImage(systemSymbolName: "speaker.slash", accessibilityDescription: "Music Muted")?.withSymbolConfiguration(NSImage.SymbolConfiguration(hierarchicalColor: .black.withAlphaComponent(0.5)))
            return
        } else {
            audio.unmuteSound()
            audioButton.image = NSImage(systemSymbolName: "speaker.wave.2", accessibilityDescription: "Music Muted")?.withSymbolConfiguration(NSImage.SymbolConfiguration(hierarchicalColor: .black.withAlphaComponent(0.5)))
            return
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
        character = charService?.getCharacterData()
        updatePoint()
    }
    
    
    func observeTimer(){
        //gaperlu sedetik sekali , ganti aja per di notification center menjadi .calendarChange
//        observeNotif()
//        checkInRange()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(validateYesterday), userInfo: nil, repeats: true)
        
    }
    
    func updatePoint(){
        points.setText(String(character?.point ?? 0))
    }
    
    func observeNotif(){
//        UNUserNotificationCenter.current().getDeliveredNotifications { notif in
//            guard var identifier = notif.first?.request.identifier else {return}
//            self.arrNotif.append(identifier)
//            print("Ini identifier yang masuk : \(identifier)")
//        }
        
        let progress = UserDefaults.standard.integer(forKey: UserDefaultsKey.kProgressSession)
        let notificationCount = UserDefaults.standard.integer(forKey: UserDefaultsKey.kNotificationCount)
        print("Notif count:", notificationCount)
        print("Progress count:", progress)
        
//        if count == progress {
//            animationMain?.setInput("WalkingStyle", value: 0.0)
//        } else if count - progress <= 2 {
//            animationMain?.setInput("WalkingStyle", value: 1.0)
//        } else {
//            animationMain?.setInput("WalkingStyle", value: 2.0)
//        }
        
        /// Notification count state
        /// - state = notificationCount - progress
        /// 
        /// state 0: walk
        /// state 1: tired/fatigue
        /// state 2: death
        /// state 3...n: walk
        let state = notificationCount - progress
        
        /// State for default walk
        var characterState: Double = 0
        var backgroundState: Double = character?.locationEquipment == .jungleJumble ? 0 : 1
        
        /// State for tored
        if state == 1 || state == 2 {
            characterState = 1
            backgroundState = character?.locationEquipment == .jungleJumble ? 0 : 1
        } else if state == 3 {
            /// State for collapsed
            characterState = 2
            backgroundState = character?.locationEquipment == .jungleJumble ? 4 : 5
        } else {
            
            /// State for out of working hours
            let prefs = charService?.getPreferences()
            let startWorkingHour = prefs?.startWorkingHour ?? .now
            let endWorkingHour = prefs?.endWorkingHour ?? .now
            
            if Date.now >= startWorkingHour && Date.now <= endWorkingHour && progress == 4 {
                characterState = 3
                backgroundState = character?.locationEquipment == .jungleJumble ? 2 : 3
            } else {
                /// State for default walk
                characterState = 0
                backgroundState = character?.locationEquipment == .jungleJumble ? 0 : 1
            }
        }
        
        animationMain?.setInput("WalkingStyle", value: characterState)
        animationMain?.setInput("Background", value: backgroundState)
    }
    
//    func checkInRange(){
//        let calendar = Calendar.current
//        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
//        if let date = calendar.date(from: components) {
//            if let char = Container.shared.resolve(CharacterService.self) {
//                guard let getPreference = char.getPreferences() else {return}
//                guard let start = getPreference.startWorkingHour else {return}
//                guard let end = getPreference.endWorkingHour else {return}
//                
//                print("start : \(start)")
//                print("date : \(date)")
//                print("end : \(end)")
//
//                if date > start && date < end {
//                    showCharSakit()
//                } else {
//                    UserDefaults.standard.integer(forKey: UserDefaultsKey.kProgressSession) == 4 ? animationMain?.setInput("WalkingStyle", value: 3.0) : animationMain?.setInput("WalkingStyle", value: 2.0)
//                }
//            }
//        }
//    }
    
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
 
        animationMain!.setInput("Background", value: Double(character.locationEquipment.itemID))

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
    }
    
    func characterDidUpdate() {
        character = self.charService?.getCharacterData()
        updatePoint()
        updateCharacter()
    }
}
