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
        startTutorialButton.removeFromSuperview()
        skipTutorialButton.title = "Interesting"
        firstTutorial = false
        print("first tutorial status : \(firstTutorial)")
    }
    
    @objc
    func actionSkip(){
        startTutorialButton.removeFromSuperview()
        skipTutorialButton.title = "See you"
        firstTutorial = false
        print("See you")
        print("first tutorial status : \(firstTutorial)")
    }
    
    @objc
    func actionSeeyou(){
        print("close pop up - see you")
        pop()
    }
    
    @objc
    func actionWhatIsThat(){
        print("close pop up - letsgo")
//        pop()
        skipTutorialButton.isHidden = true
        skipTutorialButton.title = "What's That?"
        
        let height: CGFloat = 40
        let width: CGFloat = (137 + 50 + 10)
        background.subtract(with: NSRect(x: view.bounds.minX + 70, y: view.bounds.maxY + 40, width: width, height: height))
        
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
        
        let firstText    = NSMutableAttributedString(string: "I also found ", attributes: firstAttr)
        let coinText  = NSAttributedString(string: "50 coins ", attributes: startAttr)
        let midText  = NSAttributedString(string: "while you were stretching. Check out all the cool items available in the shop. Click ", attributes: endAttr)
        let shopText  = NSAttributedString(string: "Shop ", attributes: startAttr)
        let endText  = NSAttributedString(string: "above and start shopping!", attributes: endAttr)
        
        firstText.append(coinText)
        firstText.append(midText)
        firstText.append(shopText)
        firstText.append(endText)
        
        tutorialLabel.attributedStringValue = firstText
    }
    
    @objc
    func actionInterest(){
        print("Hitted Action Interest")
        let height: CGFloat = 150
        let width: CGFloat = 450
        background.subtract(with: NSRect(x: view.bounds.maxX - width - 12, y: 840 - height - 32, width: width, height: height))
        skipTutorialButton.isHidden = true
        skipTutorialButton.title = "What's That?"
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
        
        let firstText    = NSMutableAttributedString(string: "Everyday, we need to meet a goal of stretching every 2 hour as recommended by WHO. Let’s give it a go! Click ", attributes: firstAttr)
        
        let midText  = NSAttributedString(string: "Start Stretch Session ", attributes: startAttr)
        let endText  = NSAttributedString(string: "on top of the screen to begin.", attributes: endAttr)
        
        firstText.append(midText)
        firstText.append(endText)
        
        tutorialLabel.attributedStringValue = firstText
    }
    
    func selectorButton(){
        if firstTutorial {
            startTutorialButton.action = #selector(actionStart)
            skipTutorialButton.action = #selector(actionSkip)
            tutorialLabel.stringValue = "Hello, friend! I’m so excited to work with you. Would you like me to explain how things work around here?"
        } else {
            skipTutorialButton.isHidden = false
            if skipTutorialButton.title == "Interesting" {
                skipTutorialButton.setupTitleForegroundAndFont(title: "Interesting", foregroundColorText: .white, font: .systemFont(ofSize: 18, weight: .bold))
                skipTutorialButton.action = #selector(actionInterest)
                tutorialLabel.stringValue = "It’s actually pretty simple. When you work, I’ll climb. When you stretch, I’ll rest. The more you stretch, I’ll be able to find more coins during my rest."
                
            } else if skipTutorialButton.title == "See you" {
                skipTutorialButton.setupTitleForegroundAndFont(title: "See you", foregroundColorText: .white, font: .systemFont(ofSize: 18, weight: .bold))
                skipTutorialButton.action = #selector(actionSeeyou)
                tutorialLabel.stringValue = "Alrighty! I’ll see you around :)"
                
            } else if skipTutorialButton.title == "What's That?" {
                skipTutorialButton.setupTitleForegroundAndFont(title: "What's That?", foregroundColorText: .white, font: .systemFont(ofSize: 18, weight: .bold))
                skipTutorialButton.action = #selector(actionWhatIsThat)
                tutorialLabel.stringValue = "Look at that. We’re progressing! Each session a step closer to a healthier work life. Don't forget one things..."
                
//                let height: CGFloat = 150
//                let width: CGFloat = 450
//                background.subtract(with: NSRect(x: view.bounds.maxX - width - 12, y: 840 - height - 32, width: width, height: height))
                
                /// New Updated Tutorial
            } else if skipTutorialButton.title == "What's That?" {
                skipTutorialButton.setupTitleForegroundAndFont(title: "What's That?", foregroundColorText: .white, font: .systemFont(ofSize: 18, weight: .bold))
                skipTutorialButton.action = #selector(actionWhatIsThat)
//                tutorialLabel.stringValue = "I also found 50 coins while you were stretching. Check out all the cool items available in the shop. Click Shop above and start shopping!"
                
//                let height: CGFloat = 150
//                let width: CGFloat = 450
//                background.subtract(with: NSRect(x: view.bounds.maxX - width - 12, y: 840 - height - 32, width: width, height: height))
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
            width = view.bounds.width * 0.42
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
