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
    func actionLetsGo(){
        print("close pop up - letsgo")
        pop()
    }
    
    @objc
    func actionInterest(){
        print("Hitted Action Interest")
        let height: CGFloat = 150
        let width: CGFloat = 450
        background.subtract(with: NSRect(x: view.bounds.maxX - width - 12, y: 840 - height - 32, width: width, height: height))
        skipTutorialButton.isHidden = true
        skipTutorialButton.title = "Let's Go!"
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
        
        let firstText    = NSMutableAttributedString(string: "Everyday, we need to meet a goal of a minimum of four stretching sessions, as per recommended by WHO. Let’s give it a go! Click ", attributes: firstAttr)
        
        let midText  = NSAttributedString(string: "START SESSION ", attributes: startAttr)
        let endText  = NSAttributedString(string: "to begin.", attributes: endAttr)
        
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
                
            } else if skipTutorialButton.title == "Let's Go!" {
                skipTutorialButton.setupTitleForegroundAndFont(title: "Let's Go!", foregroundColorText: .white, font: .systemFont(ofSize: 18, weight: .bold))
                skipTutorialButton.action = #selector(actionLetsGo)
                tutorialLabel.stringValue = "Look at that. We’re progressing! Each session a step closer to a healthier work life. Keep going and let’s conquer all the mountains in the world!"
                
                let height: CGFloat = 150
                let width: CGFloat = 450
                background.subtract(with: NSRect(x: view.bounds.maxX - width - 12, y: 840 - height - 32, width: width, height: height))
            }
        }
        
        print("first tutorial status : \(firstTutorial)")
    }
    
    func setCharName(){
        var height: CGFloat = 0
        var width: CGFloat = 0
        
        getUser = charService?.getCharacterData()
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
