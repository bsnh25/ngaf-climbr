//
//  TutorialShop.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 18/11/24.
//

import Cocoa
import AppKit
import SnapKit
import Combine
import Swinject

protocol TutorialShopProtocol: AnyObject {
    func didTutorialShopUpdate()
}

class TutorialShopVC: NSViewController {
    let background      = SubtractedView()
    let container       = NSView()
    let character       = NSImageView()
    let startTutorialButton = CLTextButtonV2(
        title: "Yes, please!",
        backgroundColor: .cButton,
        foregroundColorText: .white,
        fontText: .systemFont(ofSize: 18, weight: .bold)
    )
    let firstAttr: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: 24, weight: .bold)
    ]
    
    let startAttr: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: 24, weight: .black),
        NSAttributedString.Key.foregroundColor: NSColor.cButton
    ]
    
    var getUser: CharacterModel!
    var charLabel       = CLLabel(fontSize: 28, fontWeight: .bold)
    var tutorialLabel   = CLLabel(fontSize: 24, fontWeight: .bold)
    var bags: Set<AnyCancellable> = []
    var charService: CharacterService = UserManager.shared
    
    var firstShopTutorial: Bool = true {
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
            char.centerY.equalToSuperview().offset(view.bounds.height * 0.2)
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
        let height = view.bounds.height * 0.3
        
        container.snp.makeConstraints { container in
            container.top.equalTo(character.snp.bottom).inset(topPadding)
            container.leading.trailing.equalToSuperview().inset(padding)
            container.height.equalTo(height)
            container.bottom.equalToSuperview().inset(padding)
        }
    }
    
    func configureText(){
        
        container.addSubview(charLabel)
        container.addSubview(tutorialLabel)
        
        charLabel.textColor = .orange
        tutorialLabel.backgroundColor = .clear
        
        let padding = view.bounds.width * 0.04
        let descPadding = view.bounds.width * 0.04
        
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
