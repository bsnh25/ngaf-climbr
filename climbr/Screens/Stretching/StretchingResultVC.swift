//
//  StretchingResultVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 11/08/24.
//

import AppKit

class StretchingResultVC: NSViewController {
    
    let greetingLabel           = CLLabel(fontSize: 36, fontWeight: .heavy)
    let stretchingDurationLabel = CLLabel(fontSize: 28, fontWeight: .bold)
    let rewardPointLabel        = CLLabel(fontSize: 28, fontWeight: .bold)
    let resultStack             = NSStackView()
    
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
    var charService: CharacterService?
    
    
    init(charService: CharacterService?) {
        super.init(nibName: nil, bundle: nil)
        
        self.charService = charService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureResultUI()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        self.calculatePoints()
        self.calculateDurations()
    }
    
    override func viewWillAppear() {
        self.getUserData()
    }
    
    private func configureVC() {
        view.wantsLayer             = true
        view.layer?.backgroundColor = NSColor.kGreen.cgColor
    }
    
    private func configureResultUI() {
        
        let views                   = [greetingLabel, stretchingDurationLabel, characterView, rewardPointLabel]
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        resultStack.setViews(views, in: .center)
        resultStack.orientation     = .vertical
        resultStack.spacing         = 24
        
        resultStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(resultStack)
        
        /// Label
        greetingLabel.setText("Great Job!")
        greetingLabel.setTextColor(.white)
        
        stretchingDurationLabel.setText("\(awardsText) 0 minutes")
        stretchingDurationLabel.setTextColor(.white)
        
        rewardPointLabel.setText("+100 points")
        rewardPointLabel.setTextColor(.white)
        
        /// Character
        configureCharacter()
        
        /// Button
        configureButton()
        
        NSLayoutConstraint.activate([
            resultStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
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
        stack.spacing               = 10
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
