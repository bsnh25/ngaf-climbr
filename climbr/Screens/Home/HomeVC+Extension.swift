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
    }
    
    
    func observeTimer(){
        //gaperlu sedetik sekali , ganti aja per di notification center menjadi .calendarChange
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(validateYesterday), userInfo: nil, repeats: true)
    }
}

