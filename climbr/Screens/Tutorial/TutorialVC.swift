//
//  TutorialVC.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 17/08/24.
//

import Cocoa
import AppKit
import SnapKit
import Combine

class TutorialVC: NSViewController {
    
    let container = NSView()
    let character = NSImageView()
    let startTutorialButton = CLTextButtonV2(
        title: "Yes, please!",
        backgroundColor: .cButton,
        foregroundColorText: .white,
        fontText: .systemFont(ofSize: 18, weight: .bold)
    )
    let skipTutorialButton = CLTextButtonV2(
        title: "I'll learn on my own",
        backgroundColor: .cButton,
        foregroundColorText: .white,
        fontText: .systemFont(ofSize: 18, weight: .bold)
    )
    var bags: Set<AnyCancellable> = []
    
    //    @Published var firstTutorial: Bool = UserDefaults.standard.bool(forKey: UserDefaultsKey.kfirstTutorial)
    @Published var firstTutorial: Bool = true {
        didSet {
            selectorButton()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.backgroundColor = .clear
        
        configureChar()
        configureContainer()
        configureButton()
        selectorButton()
        
    }
    
    func configureChar(){
        view.addSubview(character)
        
        let padding = view.bounds.width * 0.15
        let height = view.bounds.height * 0.55
        let width = view.bounds.width * 0.3
        
        character.image = NSImage(resource: .boyHalf)
        character.image?.size = CGSize(width: width, height: height)
        
        character.snp.makeConstraints { char in
            char.leading.equalToSuperview().inset(padding)
            char.centerY.equalToSuperview()
        }
    }
    
    func configureContainer(){
        view.addSubview(container)
        container.wantsLayer = true
        container.layer?.backgroundColor = .white
        container.layer?.borderColor = .black.copy(alpha: 0.8)
        container.layer?.borderWidth = 3
        container.layer?.cornerRadius = 10
        
        let padding = view.bounds.width * 0.05
        let height = view.bounds.height * 0.35
        
        container.snp.makeConstraints { container in
            container.top.equalTo(character.snp.bottom).inset(padding)
            container.leading.trailing.equalToSuperview().inset(padding)
            container.height.equalTo(height)
        }
    }
    
    func configureButton(){
        view.addSubview(startTutorialButton)
        view.addSubview(skipTutorialButton)
        
        //        startTutorialButton.stringValue = ""
        startTutorialButton.target = self
        
        //        skipTutorialButton.stringValue = ""
        skipTutorialButton.target = self
        //        skipTutorialButton.action = #selector(actionSkip)
        
        let padding = view.bounds.width * 0.05
        let height = view.bounds.height * 0.1
        let width = view.bounds.width * 0.4
        
        skipTutorialButton.snp.makeConstraints { skip in
            skip.top.equalTo(container.snp.bottom).offset(padding)
            skip.trailing.equalToSuperview().inset(padding)
            skip.height.equalTo(height)
            skip.width.equalTo(width)
        }
        
        startTutorialButton.snp.makeConstraints { start in
            start.top.equalTo(skipTutorialButton.snp.top)
            start.trailing.equalTo(skipTutorialButton.snp.leading).inset(-padding)
            start.height.equalTo(height)
            start.width.equalTo(width)
        }
    }
    
    @objc
    func actionStart(){
        startTutorialButton.removeFromSuperview()
        skipTutorialButton.title = "Interesting"
//        skipTutorialButton.setupTitleForegroundAndFont(title: "Interesting", foregroundColorText: .white, font: .systemFont(ofSize: 18, weight: .bold))
        firstTutorial = false
//        print("label : \(skipTutorialButton.foregroundColorText.accessibilityName)")
        print("first tutorial status : \(firstTutorial)")
    }
    
    @objc
    func actionSkip(){
        startTutorialButton.removeFromSuperview()
//        skipTutorialButton.setupTitleForegroundAndFont(title: "See you", foregroundColorText: .white, font: .systemFont(ofSize: 18, weight: .bold))
        skipTutorialButton.title = "See you"
        firstTutorial = false
        print("See you")
        print("first tutorial status : \(firstTutorial)")
    }
    
    @objc
    func actionSeeyou(){
        print("close pop up - see you")
    }

    @objc
    func actionLetsGo(){
        print("close pop up - letsgo")
    }
    
    @objc
    func actionInterest(){
//        skipTutorialButton.isHidden = true
        skipTutorialButton.title = "Let's Go!"
        firstTutorial = false
        print("let's go")
        print("action : \(skipTutorialButton.action)")
        
    }
    
    func selectorButton(){
        if firstTutorial {
            startTutorialButton.action = #selector(actionStart)
            skipTutorialButton.action = #selector(actionSkip)
        } else {
            skipTutorialButton.isHidden = false
            if skipTutorialButton.title == "Interesting" {
                skipTutorialButton.setupTitleForegroundAndFont(title: "Interesting", foregroundColorText: .white, font: .systemFont(ofSize: 18, weight: .bold))
                skipTutorialButton.action = #selector(actionInterest)
//                skipTutorialButton.isHidden = true
                return
            } else if skipTutorialButton.title == "See you" {
                skipTutorialButton.setupTitleForegroundAndFont(title: "See you", foregroundColorText: .white, font: .systemFont(ofSize: 18, weight: .bold))
                skipTutorialButton.action = #selector(actionSeeyou)
                return
            } else if skipTutorialButton.title == "Let's Go!" {
                skipTutorialButton.setupTitleForegroundAndFont(title: "Let's Go!", foregroundColorText: .white, font: .systemFont(ofSize: 18, weight: .bold))
                skipTutorialButton.action = #selector(actionLetsGo)
                return
            }
        }
        
        print("first tutorial status : \(firstTutorial)")
    }
    
}

#Preview(traits: .defaultLayout, body: {
    TutorialVC()
})
