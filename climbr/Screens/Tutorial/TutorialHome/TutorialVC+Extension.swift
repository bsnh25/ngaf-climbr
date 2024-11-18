//
//  TutorialVC+Extension.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 17/08/24.
//

import Foundation
import Swinject
import AppKit

extension TutorialVC {
    
    @objc
    func actionStart(){
        startTutorialButton.title = "Nice!"
        firstTutorial = false
        print("first tutorial status : \(firstTutorial)")
    }
    
    @objc
    func actionNice(){
        print("Hitted Action Nice")
        let height: CGFloat = 150
        let width: CGFloat = 450
        background.subtract(with: NSRect(x: view.bounds.maxX - width - 12, y: 840 - height - 32, width: width, height: height))
        startTutorialButton.isHidden = true
        startTutorialButton.title = "Healthier everyday!"
        let firstAttr: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 24, weight: .bold)
        ]
        
        let startAttr: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 24, weight: .black),
            NSAttributedString.Key.foregroundColor: NSColor.cButton
        ]
        
        let endAttr : [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 24, weight: .bold)
        ]
        
        let firstText    = NSMutableAttributedString(string: "Everyday, we need to meet a goal of stretching every 2 hour as recommended by experts. Let’s give it a go! Click ", attributes: firstAttr)
        
        let midText  = NSAttributedString(string: "Start Stretch Session ", attributes: startAttr)
        let endText  = NSAttributedString(string: "on top of the screen to begin.", attributes: endAttr)
        
        firstText.append(midText)
        firstText.append(endText)
        
        tutorialLabel.attributedStringValue = firstText
    }
    
    @objc
    func actionSoundsNice(){
        print("Hitted Action Sounds Nice!")
        startTutorialButton.isHidden = true
        startTutorialButton.title = "Sounds nice!"
        
        let height: CGFloat = 60
        let width: CGFloat = (137 + 50 + 10 + 20)
        background.subtract(with: NSRect(x: view.bounds.minX + 70, y: view.bounds.maxY - 95, width: width, height: height))
        
        let firstAttr: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 24, weight: .bold)
        ]
        
        let startAttr: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 24, weight: .black),
            NSAttributedString.Key.foregroundColor: NSColor.cButton
        ]
        
        let endAttr : [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 24, weight: .bold)
        ]
        
        let firstText    = NSMutableAttributedString(string: "OH WOW! I also found ", attributes: firstAttr)
        let coinText  = NSAttributedString(string: "some coins ", attributes: startAttr)
        let midText  = NSAttributedString(string: "whilst you were stretching. How about we spend some of it to commorate our first day working together? Click ", attributes: endAttr)
        let shopText  = NSAttributedString(string: "Shop ", attributes: startAttr)
        let endText  = NSAttributedString(string: "above and start shopping!", attributes: endAttr)
        
        firstText.append(coinText)
        firstText.append(midText)
        firstText.append(shopText)
        firstText.append(endText)
        
        tutorialLabel.attributedStringValue = firstText
    }
    
    @objc
    func actionMidway(){
        print("Hitted Action Midway")
        startTutorialButton.title = "Oh dear..."
        startTutorialButton.isHidden = false
        background.subtract(with: .zero)
        
        let firstAttr: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 24, weight: .bold)
        ]
        
        let startAttr: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 24, weight: .black),
            NSAttributedString.Key.foregroundColor: NSColor.cButton
        ]
        
        let endAttr : [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 24, weight: .bold)
        ]
        
        let firstText    = NSMutableAttributedString(string: "But I guess, if you are too preoccupied on working and don’t stretch with me, I would be stuck in a ", attributes: firstAttr)
        let midText  = NSAttributedString(string: "midway camp. ", attributes: startAttr)
        let midJourneyText  = NSAttributedString(string: "Don’t fret! We can always continue climbing the next day.", attributes: endAttr)
        
        firstText.append(midText)
        firstText.append(midJourneyText)
        
        tutorialLabel.attributedStringValue = firstText
        firstTutorial = false
    }
    
    @objc
    func actionOhDear(){
        print("Hitted Action Oh dear!")
        startTutorialButton.isHidden = false
        startTutorialButton.title = "See you on top!"
        background.subtract(with: .zero)
        let firstAttr: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 24, weight: .bold)
        ]
        
        let startAttr: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 24, weight: .black),
            NSAttributedString.Key.foregroundColor: NSColor.cButton
        ]
        
        let endAttr : [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 24, weight: .bold)
        ]
        
        let firstText    = NSMutableAttributedString(string: "That’s all! You’re a natural at this. Don’t forget to stretch ", attributes: firstAttr)
        let midText  = NSAttributedString(string: "at least 4 times a day ", attributes: startAttr)
        let endText  = NSAttributedString(string: "to conquer this mountain today whilst you advance your career. See you on top!", attributes: endAttr)
        
        firstText.append(midText)
        firstText.append(endText)
        
        tutorialLabel.attributedStringValue = firstText
        firstTutorial = false
    }
    
    @objc
    func actionSeeyou(){
        print("close pop up - see you")
        firstTutorial = false
        UserDefaults.standard.set(false, forKey: UserDefaultsKey.kTutorial)
        pop()
        
        print("Value of user default tutorial: \(UserDefaults.standard.bool(forKey: UserDefaultsKey.kTutorial))")
        print("Value of user default tutorial shop: \(UserDefaults.standard.bool(forKey: UserDefaultsKey.kTutorialShop))")
        print("Value of firstTutorial: \(firstTutorial)")
    }
    
    func selectorButton(){
        if firstTutorial {
            startTutorialButton.action = #selector(actionStart)
            tutorialLabel.stringValue = "Hello, friend! I’m so excited to work with you. Would you like me to explain how things work around here?"
            
        } else {
            
            if startTutorialButton.title == "Nice!" {
                startTutorialButton.setupTitleForegroundAndFont(title: "Nice!", foregroundColorText: .white, font: .systemFont(ofSize: 18, weight: .bold))
                startTutorialButton.action = #selector(actionNice)
                tutorialLabel.stringValue = "It’s actually pretty simple. When you work, I’ll climb. When you stretch, I’ll rest. The more you stretch, I’ll be able to find more coins during my rest."
                
            } else if startTutorialButton.title == "Healthier everyday!" {
                
                let width: CGFloat = 450
                background.subtract(with: NSRect(x: view.bounds.maxX - width - 12, y: view.bounds.maxY * 0.865, width: width, height: 25))
                
                startTutorialButton.isHidden = false
                startTutorialButton.setupTitleForegroundAndFont(title: "Healthier everyday!", foregroundColorText: .white, font: .systemFont(ofSize: 18, weight: .bold))
                startTutorialButton.action = #selector(actionSoundsNice)
                tutorialLabel.stringValue = "Look at that. We’re progressing! Each session a step closer to a healthier work life."
                
            } else if startTutorialButton.title == "Sounds nice!" {
                background.subtract(with: .zero)
                startTutorialButton.isHidden = false
                startTutorialButton.setupTitleForegroundAndFont(title: "Sounds nice!", foregroundColorText: .white, font: .systemFont(ofSize: 18, weight: .bold))
                
                let firstAttr: [NSAttributedString.Key: Any] = [
                    .font: NSFont.systemFont(ofSize: 24, weight: .bold)
                ]
                
                let startAttr: [NSAttributedString.Key: Any] = [
                    .font: NSFont.systemFont(ofSize: 24, weight: .black),
                    NSAttributedString.Key.foregroundColor: NSColor.cButton
                ]
                
                let endAttr : [NSAttributedString.Key: Any] = [
                    .font: NSFont.systemFont(ofSize: 24, weight: .bold)
                ]
                
                let firstText    = NSMutableAttributedString(string: "Oh! I would love to see the ", attributes: firstAttr)
                let peakText  = NSAttributedString(string: "mountain peak ", attributes: startAttr)
                let midText  = NSAttributedString(string: "and camp there! ", attributes: endAttr)
                let tnCText  = NSAttributedString(string: "If you stretch a minimum of 4 times a day, ", attributes: startAttr)
                let endText  = NSAttributedString(string: "I can camp there.", attributes: endAttr)
                
                firstText.append(peakText)
                firstText.append(midText)
                firstText.append(tnCText)
                firstText.append(endText)
//                overviewFinish.image = NSImage(resource: getUser.gender == .male ? .malechar1 : .femalePeak)
                overviewFinish.image = NSImage(resource: .femalePeak)
                tutorialLabel.attributedStringValue = firstText
                startTutorialButton.action = #selector(actionMidway)
                
            } else if startTutorialButton.title == "Oh dear..." {
                background.subtract(with: .zero)
                startTutorialButton.setupTitleForegroundAndFont(title: "Oh dear...", foregroundColorText: .white, font: .systemFont(ofSize: 18, weight: .bold))
//                overviewFinish.image = NSImage(resource: getUser.gender == .male ? .malechar1 : .femaleMidway)
                overviewFinish.image = NSImage(resource: .femaleMidway)
                startTutorialButton.action = #selector(actionOhDear)

            } else if startTutorialButton.title == "See you on top!" {
                background.subtract(with: .zero)
                overviewFinish.removeFromSuperview()
                startTutorialButton.setupTitleForegroundAndFont(title: "See you on top!", foregroundColorText: .white, font: .systemFont(ofSize: 18, weight: .bold))
                startTutorialButton.action = #selector(actionSeeyou)
            }
        }
        
        print("first tutorial status : \(firstTutorial)")
    }
    
    func setCharName(){
        var height: CGFloat = 0
        var width: CGFloat = 0
        
        getUser = charService.getCharacterData()
        charLabel.stringValue = "\(getUser?.name ?? "John Doe")"
        
        if getUser?.gender == .male {
            character.image = NSImage(resource: .boyHalf)
            height = view.bounds.height * 0.82
            width = view.bounds.width * 0.48
        } else {
            character.image = NSImage(resource: .femaleHalf)
            height = view.bounds.height * 0.74
            width = view.bounds.width * 0.64
        }
        
        character.image?.size = CGSize(width: width, height: height)
        
        print("Height char : \(height)")
        print("Width char : \(width)")
    }
    
    func updateSelectorButton(){
        firstTutorial = false
    }
    
}
