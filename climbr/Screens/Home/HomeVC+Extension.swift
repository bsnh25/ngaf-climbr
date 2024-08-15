//
//  HomeVC + Extension.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 14/08/24.
//

import AppKit
import Swinject

extension HomeVC {
    
    @objc
    func actionStore(){
        print("go to shop")
    }
    
    @objc
    func actionStartSession(){
        if let vc = Container.shared.resolve(StretchingVC.self) {
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
    
//    func updateProgress(_ now: Date){
//        
//        let progress = UserDefaults.standard.integer(forKey: UserDefaultsKey.kProgressSession)
//        guard let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: now) else {return}
//        
//        if now < Calendar.current.startOfDay(for: tomorrow){
//            
//            switch progress {
//            case 0, 1, 2, 3:
//                self.progressValue += 1
//                self.progressStretch.increment(by: 1)
//                break
//            default:
//                self.progressValue = 4
//                break
//            }
//            
//            textA.setText("\(Int(progressValue)) / 4 sessions")
//            
//            
//            UserDefaults.standard.setValue(self.progressValue, forKey: UserDefaultsKey.kProgressSession)
//            
//        } else {
//            progressValue = 0
//            textA.setText("0 / 4 sessions")
//            progressStretch.doubleValue = progressValue
//            UserDefaults.standard.setValue(Date(), forKey: UserDefaultsKey.kDateNow)
//        }
//        
//        UserDefaults.standard.setValue(Date(), forKey: UserDefaultsKey.kDateNow)
//        print("Session : \(self.textA.stringValue)")
//        print("Progress Value : \(progressValue)")
//        
//    }
    
    func validateYesterday(_ date: Date){
        if Calendar.current.isDateInYesterday(date) {
            print("Date param : \(date)")
            print("Date current : \(Calendar.current)")
            UserDefaults.standard.setValue(0, forKey: UserDefaultsKey.kProgressSession)
        }
    }
    
    func updateProgressData(){
        let progress = UserDefaults.standard.double(forKey: UserDefaultsKey.kProgressSession)
        progressStretch.doubleValue = progress
        progressText.setText("\(Int(progress)) / 4 sessions")
    }
}

