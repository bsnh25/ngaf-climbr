//
//  StretchingResultVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 11/08/24.
//

import AppKit
import SnapKit

class StretchingResultVC: NSViewController {
    
    let neckProgress            = ProgressUserView(valueProgress: "0/2", typeStretch: "Neck")
    let armProgress             = ProgressUserView(valueProgress: "0/2", typeStretch: "Shoulder")
    let backProgress            = ProgressUserView(valueProgress: "0/2", typeStretch: "Lower Back")
    let cointEarning            = ProgressUserView(valueProgress: "🪙 0", typeStretch: "Coins")
    let greetingLabel           = CLLabel(fontSize: 36, fontWeight: .heavy)
    let stretchingDurationLabel = CLLabel(fontSize: 28, fontWeight: .bold)
    let rewardPointLabel        = CLLabel(fontSize: 28, fontWeight: .bold)
    let resultStack             = NSStackView()
    let progressStack             = NSStackView()
    
    let affirmationTexts: [String]  = [
        "Wow! That’s a power move!",
        "Great Job! Unlocked a new energy boost!",
        "Fantastic! Your body thanks you!",
        "Cool! Gained extra endurance coins!",
        "You did it! Bonus coins for self-care!"
    ]
    let awardsText              = "You’ve reduced your sedentary time by"
    
    let characterView          = NSView()
    let dummyCharacter         = NSImageView()
    
    let continueWorkingButton   = CLTextButtonV2(
        title: "Continue Working",
        backgroundColor: .white,
        foregroundColorText: .black,
        fontText: .boldSystemFont(ofSize: 16)
    )
    let mainMenuButton          = CLTextButtonV2(
        title: "Go To Main Menu",
        backgroundColor: .cButton,
        foregroundColorText: .white,
        fontText: .boldSystemFont(ofSize: 16)
    )
    
    let padding: CGFloat        = 64
    var char: CharacterModel?
    
    var movementList: [Movement] = []
    
    /// Dependencies
    var charService: CharacterService = UserManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureResultUI()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        self.calculatePoints()
        self.calculateDurations()
        self.calculateProgress()
    }
    
    override func viewWillAppear() {
        self.getUserData()
    }
    
    private func configureVC() {
        view.wantsLayer             = true
        view.layer?.backgroundColor = NSColor.kGreen.cgColor
    }
    
    private func configureResultUI() {
        /// old:  greeting, subgreeting, charView, rewardPoint
        /// new: greeting, charView, progressView
//        let views                   = [greetingLabel, stretchingDurationLabel, characterView, rewardPointLabel]
        
        let views = [greetingLabel, characterView, progressStack]
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        resultStack.setViews(views, in: .center)
        resultStack.orientation     = .vertical
        resultStack.spacing         = 24
        resultStack.distribution    = .fillEqually
        resultStack.wantsLayer = true
//        resultStack.layer?.borderColor = .black
//        resultStack.layer?.borderWidth = 1
        
        resultStack.translatesAutoresizingMaskIntoConstraints = false
        
        let viewsProgress = [neckProgress, armProgress, backProgress, cointEarning]
        progressStack.setViews(viewsProgress, in: .center)
        progressStack.orientation = .horizontal
        progressStack.spacing = 28
                
        view.addSubview(resultStack)
        
        ///coint setup
        cointEarning.updateColor(.gray)
        
        /// Label
        greetingLabel.setText("Great Job!")
        greetingLabel.setTextColor(.white)
        greetingLabel.alignment = .center
        
        greetingLabel.setAccessibilityElement(true)
        neckProgress.setAccessibilityElement(true)
        armProgress.setAccessibilityElement(true)
        backProgress.setAccessibilityElement(true)
        cointEarning.setAccessibilityElement(true)
        
        neckProgress.setAccessibilityTitle("Neck Progress Section")
        neckProgress.setAccessibilityRole(.group)
        
        armProgress.setAccessibilityTitle("Arm Progress Section")
        armProgress.setAccessibilityRole(.group)
        
        backProgress.setAccessibilityTitle("Back Progress Section")
        backProgress.setAccessibilityRole(.group)
        
        cointEarning.setAccessibilityTitle("Coin Result Section")
        cointEarning.setAccessibilityRole(.group)
        
        stretchingDurationLabel.setText("\(awardsText) 0 minutes")
        stretchingDurationLabel.setTextColor(.white)
        
        rewardPointLabel.setText("+100 points")
        rewardPointLabel.setTextColor(.white)
        
        /// Character
        configureCharacter()
        
        /// Button
        configureButton()

        resultStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.bounds.height / 10)
            make.bottom.equalToSuperview().inset(view.bounds.height / 10)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        greetingLabel.snp.makeConstraints { make in
            make.width.equalTo(811)
            make.top.equalTo(resultStack.snp.top).inset(104)
        }
    }
    
    private func configureCharacter() {
        characterView.wantsLayer                = true
        characterView.layer?.backgroundColor    = .clear
        
        dummyCharacter.translatesAutoresizingMaskIntoConstraints = false
        
        characterView.addSubview(dummyCharacter)
        
        NSLayoutConstraint.activate([
            characterView.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            characterView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            dummyCharacter.centerXAnchor.constraint(equalTo: characterView.centerXAnchor),
            dummyCharacter.centerYAnchor.constraint(equalTo: characterView.centerYAnchor),
        ])
    }
    
    private func configureButton() {
        let stack = NSStackView(views: [continueWorkingButton, mainMenuButton])
        
        continueWorkingButton.translatesAutoresizingMaskIntoConstraints     = false
        mainMenuButton.translatesAutoresizingMaskIntoConstraints            = false
        stack.translatesAutoresizingMaskIntoConstraints                     = false
        stack.orientation           = .horizontal
        stack.spacing               = 32
        stack.distribution    = .fillEqually
        
        resultStack.addArrangedSubview(stack)
        
        mainMenuButton.target = self
        mainMenuButton.action = #selector(goToMainMenu)
        
        continueWorkingButton.target = self
        continueWorkingButton.action = #selector(continueWorking)
        
        NSLayoutConstraint.activate([
            stack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            continueWorkingButton.heightAnchor.constraint(equalToConstant: 48),
            mainMenuButton.heightAnchor.constraint(equalToConstant: 48),
        ])
        
    }
    
}
