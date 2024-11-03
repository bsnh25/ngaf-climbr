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
import Swinject

class TutorialVC: NSViewController {
    let background      = SubtractedView()
    let container       = NSView()
    let character       = NSImageView()
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
    
    var getUser: CharacterModel!
    var charLabel       = CLLabel(fontSize: 28, fontWeight: .bold)
    var tutorialLabel   = CLLabel(fontSize: 24, fontWeight: .bold)
    var bags: Set<AnyCancellable> = []
    var charService: CharacterService = UserManager.shared
    
    var firstTutorial: Bool = true {
        didSet {
            selectorButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(background)
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        
        configureChar()
        configureContainer()
        configureText()
        configureButton()
        selectorButton()
        
        
        NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)
            .sink { [weak self] _ in
                guard let self = self else {return}
                
                DispatchQueue.main.async {
                    self.updateSelectorButton()
                }
            }
            .store(in: &bags)
        
    }
    
    func configureChar(){
        view.addSubview(character)
        
        let padding = view.bounds.width * 0.05
        setCharName()
        
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
        let topPadding = view.bounds.width * 0.1
        let height = view.bounds.height * 0.35
        
        container.snp.makeConstraints { container in
            container.top.equalTo(character.snp.bottom).inset(topPadding)
            container.leading.trailing.equalToSuperview().inset(padding)
            container.height.equalTo(height)
        }
    }
    
    func configureButton(){
        view.addSubview(startTutorialButton)
        view.addSubview(skipTutorialButton)
        
        startTutorialButton.target = self
        skipTutorialButton.target = self
        
        let padding = view.bounds.width * 0.05
        let height = view.bounds.height * 0.1
        let width = view.bounds.width * 0.4
        
        skipTutorialButton.snp.makeConstraints { skip in
            skip.top.equalTo(container.snp.bottom).offset(view.bounds.width * 0.02)
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
    
    func configureText(){
        
        container.addSubview(charLabel)
        container.addSubview(tutorialLabel)
        
        charLabel.textColor = .orange
        tutorialLabel.backgroundColor = .clear
        
        let padding = view.bounds.width * 0.04
        let descPadding = view.bounds.width * 0.02
        
        charLabel.snp.makeConstraints { title in
            title.top.equalTo(container.snp.top).inset(padding)
            title.leading.equalTo(container.snp.leading).inset(padding)
        }
        
        tutorialLabel.snp.makeConstraints { desc in
            desc.top.equalTo(charLabel.snp.bottom).offset(descPadding)
            desc.leading.equalTo(container.snp.leading).inset(padding)
            desc.width.equalTo(1100)
            
        }
        
    }
    
}
