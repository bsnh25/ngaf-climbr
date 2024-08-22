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
            UserDefaults.standard.setValue(Date(), forKey: UserDefaultsKey.kDateNow)
            return
        }
        
    }
    
    func updateProgressData(){
        let progress = UserDefaults.standard.double(forKey: UserDefaultsKey.kProgressSession)
        progressStretch.doubleValue = progress
        progressText.setText("\(Int(progress)) / 4 sessions")
        arrNotif.popLast()
        updatePoint()
    }
    
    
    func observeTimer(){
        //gaperlu sedetik sekali , ganti aja per di notification center menjadi .calendarChange
        observeNotif()
        checkInRange()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(validateYesterday), userInfo: nil, repeats: true)
    }
    
    func updatePoint(){
        if let pointChar = charService?.getCharacterData() {
            points.setText(String(pointChar.point))
        } else {
            points.setText("0")
        }
    }
    
    func observeNotif(){
        UNUserNotificationCenter.current().getDeliveredNotifications { notif in
            guard var identifier = notif.first?.request.identifier else {return}
            self.arrNotif.append(identifier)
            print("Ini identifier yang masuk : \(identifier)")
        }
    }
    
    func showCharSakit(){
        let totalSakit = arrNotif.count
        print("total notif \(totalSakit)")
        switch totalSakit {
        case 0:
            print("ganti walking")
            animationMain?.setInput("WalkingStyle", value: 0.0)
        case 1:
            print("ganti lemas")
            animationMain?.setInput("WalkingStyle", value: 1.0)
        default:
            print("ganti jatuh")
            animationMain?.setInput("WalkingStyle", value: 2.0)
        }
    }
    
    func checkInRange(){
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        if let date = calendar.date(from: components) {
            if let char = Container.shared.resolve(CharacterService.self) {
                guard let getPreference = char.getPreferences() else {return}
                guard let start = getPreference.startWorkingHour else {return}
                guard let end = getPreference.endWorkingHour else {return}
                
                print("start : \(start)")
                print("date : \(date)")
                print("end : \(end)")
                
                if date > start && date < end {
                    showCharSakit()
                } else {
                    UserDefaults.standard.integer(forKey: UserDefaultsKey.kProgressSession) == 4 ? animationMain?.setInput("WalkingStyle", value: 3.0) : animationMain?.setInput("WalkingStyle", value: 2.0)
                }
            }
        }
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
}
