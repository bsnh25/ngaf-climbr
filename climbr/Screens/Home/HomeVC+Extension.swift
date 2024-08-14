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
        let settingsVC = SettingVC()
        settingsVC.preferredContentSize = CGSize(width: 412, height: 358)
        self.presentAsModalWindow(settingsVC)
    }

    @objc
    func actionAudio(){
        guard let audio = audioService else {return}
        isSoundTapped.toggle()
        if isSoundTapped{
            audio.muteSound()
            audioButton.image = NSImage(systemSymbolName: "speaker.slash", accessibilityDescription: "Music Muted")
            return
        } else {
            audio.unmuteSound()
            audioButton.image = NSImage(systemSymbolName: "speaker.wave.2", accessibilityDescription: "Music Muted")
            return
        }
    }
    
    func dailyProgress(){
        progressStretch.minValue = 0
        progressStretch.maxValue = 1
        progressStretch.doubleValue = 0.25 / progressStretch.maxValue // value progress
//        progressStretch.observedProgress = Progress.
    }
}
