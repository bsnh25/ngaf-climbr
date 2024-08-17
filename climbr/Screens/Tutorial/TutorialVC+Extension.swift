//
//  TutorialVC+Extension.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 17/08/24.
//

import Foundation

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
        skipTutorialButton.isHidden = true
        skipTutorialButton.title = "Let's Go!"
        tutorialLabel.stringValue = "Everyday, we need to meet a goal of a minimum of four stretching sessions, as per recommended by WHO. Let’s give it a go! Click start session to begin."
        print("title skip : \(skipTutorialButton.title)")
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
                return
            } else if skipTutorialButton.title == "See you" {
                skipTutorialButton.setupTitleForegroundAndFont(title: "See you", foregroundColorText: .white, font: .systemFont(ofSize: 18, weight: .bold))
                skipTutorialButton.action = #selector(actionSeeyou)
                tutorialLabel.stringValue = "Alrighty! I’ll see you around :)"
                return
            } else if skipTutorialButton.title == "Let's Go!" {
                skipTutorialButton.setupTitleForegroundAndFont(title: "Let's Go!", foregroundColorText: .white, font: .systemFont(ofSize: 18, weight: .bold))
                skipTutorialButton.action = #selector(actionLetsGo)
                tutorialLabel.stringValue = "Look at that. We’re progressing! Each session a step closer to a healthier work life. Keep going and let’s conquer all the mountains in the world!"
                return
            }
        }
        
        print("first tutorial status : \(firstTutorial)")
    }
    
    func setCharName(){
        let getUser = userService?.getUserData()
        charLabel.stringValue = "\(getUser?.name ?? "John Doe")"
    }
    
    func updateSelectorButton(){
        firstTutorial = false
    }

}
