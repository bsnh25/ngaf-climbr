//
//  StretchingResultVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 11/08/24.
//

import Cocoa

class StretchingResultVC: NSViewController {
    
    let greetingLabel           = CLLabel(fontSize: 26, fontWeight: .bold)
    let stretchingSubLabel      = CLLabel(fontSize: 17, fontWeight: .regular)
    let stretchingDurationLabel = CLLabel(fontSize: 26, fontWeight: .bold)
    let rewardPointLabel        = CLLabel(fontSize: 26, fontWeight: .bold)
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureResultUI()
        configureButton()
    }
    
    private func configureVC() {
        view.wantsLayer             = true
        view.layer?.backgroundColor = .white
    }
    
    private func configureResultUI() {
        let stretchingStack         = NSStackView(views: [stretchingSubLabel, stretchingDurationLabel])
        stretchingStack.orientation = .vertical
        stretchingStack.spacing     = 10
        
        let views                   = [greetingLabel, stretchingStack, dummyCharacter, rewardPointLabel]
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let resultStack             = NSStackView(views: views)
        resultStack.orientation     = .vertical
        resultStack.spacing         = 24
        
        resultStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(resultStack)
        
        /// Label
        greetingLabel.setText("Great Job!")
        stretchingSubLabel.setText("You’ve reduced your sedentary time by")
        stretchingDurationLabel.setText("5 minutes")
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
        
        NSLayoutConstraint.activate([
            stack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            continueWorkingButton.heightAnchor.constraint(equalToConstant: 48),
            mainMenuButton.heightAnchor.constraint(equalToConstant: 48),
        ])
        
    }
    
}
