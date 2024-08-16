//
//  StretchingResultVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 11/08/24.
//

import Cocoa

class StretchingResultVC: NSViewController {
    
    let greetingLabel           = CLLabel(fontSize: 36, fontWeight: .heavy)
    let stretchingDurationLabel = CLLabel(fontSize: 28, fontWeight: .bold)
    let rewardPointLabel        = CLLabel(fontSize: 28, fontWeight: .bold)
    
    let awardsText              = "You’ve reduced your sedentary time by"
    
    let dummyCharacter          = NSView()
    
    let continueWorkingButton   = CLTextButtonV2(
        title: "Continue Working",
        borderColor: .black,
        font: .boldSystemFont(ofSize: 16)
    )
    let mainMenuButton          = CLTextButtonV2(
        title: "Go To Main Menu",
        backgroundColor: .black,
        foregroundColorText: .white,
        fontText: .boldSystemFont(ofSize: 16)
    )
    
    let padding: CGFloat        = 64
    
    var movementList: [Movement] = []
    
    /// Dependencies
    var userService: UserService?
    
    
    init(userService: UserService?) {
        super.init(nibName: nil, bundle: nil)
        
        self.userService = userService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureResultUI()
        configureButton()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        self.calculatePoints()
    }
    
    private func configureVC() {
        view.wantsLayer             = true
        view.layer?.backgroundColor = .white
    }
    
    private func configureResultUI() {
        
        let views                   = [greetingLabel, stretchingDurationLabel, dummyCharacter, rewardPointLabel]
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let resultStack             = NSStackView(views: views)
        resultStack.orientation     = .vertical
        resultStack.spacing         = 24
        
        resultStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(resultStack)
        
        /// Label
        greetingLabel.setText("Great Job!")
        stretchingDurationLabel.setText("\(awardsText) 0 minutes")
        rewardPointLabel.setText("+100 points")
        
        /// Character
        configureCharacter()
        
        NSLayoutConstraint.activate([
            resultStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            resultStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            resultStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureCharacter() {
        dummyCharacter.wantsLayer = true
        dummyCharacter.layer?.backgroundColor   = NSColor.systemGray.cgColor
        
        NSLayoutConstraint.activate([
            dummyCharacter.widthAnchor.constraint(equalToConstant: 200),
            dummyCharacter.heightAnchor.constraint(equalToConstant: 350),
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
        
        view.addSubview(stack)
        
        mainMenuButton.target = self
        mainMenuButton.action = #selector(goToMainMenu)
        
        continueWorkingButton.target = self
        continueWorkingButton.action = #selector(continueWorking)
        
        NSLayoutConstraint.activate([
            stack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            continueWorkingButton.heightAnchor.constraint(equalToConstant: 48),
            mainMenuButton.heightAnchor.constraint(equalToConstant: 48),
        ])
        
    }
    
}
