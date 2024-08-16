//
//  ExerciseInstructionVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 16/08/24.
//

import Cocoa

class ExerciseInstructionVC: NSViewController {
    
    let icon             = CLSFSymbol(
        symbolName: "person.crop.square.badge.camera",
        description: "Exercise Instruction"
    )
    let instructionLabel = CLLabel(fontSize: 24, fontWeight: .semibold)
    let ctaLabel         = CLLabel(fontSize: 24, fontWeight: .regular)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.kDarkGray.cgColor.copy(alpha: 0.9)
        
        configure()
        setupClickGesture()
    }
    
    private func configure() {
        let stack = NSStackView(views: [icon, instructionLabel, ctaLabel])
        
        stack.orientation   = .vertical
        stack.spacing       = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        icon.setConfiguration(size: 60, weight: .bold)
        icon.contentTintColor = .white
        
        instructionLabel.setText("Make sure you’re visible from head to waist for a better experience")
        instructionLabel.setTextColor(.white)
        
        ctaLabel.setText("Click anywhere to start")
        ctaLabel.setTextColor(.white.withAlphaComponent(0.8))
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setupClickGesture() {
        let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(handleClick))
        
        view.addGestureRecognizer(clickGesture)
    }
    
    @objc private func handleClick(_ sender: NSClickGestureRecognizer) {
        self.pop()
    }
    
}
