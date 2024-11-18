//
//  TutorialShopVC+Extension.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 18/11/24.
//

import Foundation
import Swinject
import AppKit

extension TutorialShopVC {
    
    @objc
    func actionSeeyou(){
        print("close pop up - see you")
        firstShopTutorial = false
        pop()
    }
    
    func selectorButton(){
        if firstShopTutorial {
            let height: CGFloat = 95
            let width: CGFloat = 95
            print("Ini bounds X = \(view.bounds.maxX)")
            print("Ini bounds Y = \(view.bounds.maxY)")
            background.subtract(with: NSRect(x: view.bounds.maxX * 0.3, y: (view.bounds.maxY * 0.95), width: width, height: height))
            tutorialLabel.stringValue = "This hat looks quite nice. How about we try that one on?"
        }
        
        print("first tutorial status : \(firstShopTutorial)")
    }
    
    func setCharName(){
        var height: CGFloat = 0
        var width: CGFloat = 0
        
        getUser = charService.getCharacterData()
        charLabel.stringValue = "\(getUser?.name ?? "John Doe")"
        
        if getUser?.gender == .male {
            character.image = NSImage(resource: .boyHalf)
            height = view.bounds.height * 0.59
            width = view.bounds.width * 0.51
        } else {
            character.image = NSImage(resource: .femaleHalf)
            height = view.bounds.height * 0.59
            width = view.bounds.width * 0.51
        }
        
        character.image?.size = CGSize(width: width, height: height)
        
        print("Shop Height char : \(height)")
        print("Shop Width char : \(width)")
    }
    
    func updateSelectorButton(){
        firstShopTutorial = false
    }
    
}


extension TutorialShopVC: TutorialShopProtocol {
    
    func didTutorialShopUpdate() {
        if tutorialLabel.stringValue == "This hat looks quite nice. How about we try that one on?" {
            let height: CGFloat = 120
            let width: CGFloat = 320
            background.subtract(with: NSRect(x: view.bounds.maxX * 0.03, y: (view.bounds.maxY * 0.7), width: width, height: height))
  
            let firstText    = NSMutableAttributedString(string: "This one is excellent! Just my style, let’s get this one! Go ahead and click ", attributes: firstAttr)
            let midText  = NSAttributedString(string: "Purchase.", attributes: startAttr)
            firstText.append(midText)
            
            tutorialLabel.attributedStringValue = firstText
            
        } else if tutorialLabel.stringValue == "This one is excellent! Just my style, let’s get this one! Go ahead and click Purchase."{
            let firstText    = NSMutableAttributedString(string: "Magnificent! Let’s get back to hiking. Click the ", attributes: firstAttr)
            let midText  = NSAttributedString(string: "􁉈 button.", attributes: startAttr)
            firstText.append(midText)
            tutorialLabel.attributedStringValue = firstText
            background.subtract(with: .zero)
        }
    }
    
}
