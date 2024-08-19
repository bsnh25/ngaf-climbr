//
//  ExerciseInstructionVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 16/08/24.
//

import Cocoa

class ExerciseInstructionView: NSView {
    let imageView = NSImageView()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        wantsLayer = true
        layer?.backgroundColor = .black.copy(alpha: 0.8)
        translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = .upperBodyOutline
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.imageScaling = .scaleProportionallyUpOrDown
        imageView.image?.size = NSSize(width: 720, height: 720)
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hide() {
        /// Make sure the layer is exist
        guard let layer     = self.layer else { return }
        
        /// Create CAPropertyAnimation based on keypath
        ///
        /// Then set the inital value, final value, and duration
        let animation       = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = layer.opacity
        animation.toValue   = 0.0
        animation.duration  = 0.3
        
        /// Set the layer property to final value
        layer.opacity       = 0.0
        
        /// Add animation to layer
        layer.add(animation, forKey: "opacity")
    }
    
    func unhide() {
        /// Make sure the layer is exist
        guard let layer     = self.layer else { return }
        
        /// Create CAPropertyAnimation based on keypath
        ///
        /// Then set the inital value, final value, and duration
        let animation       = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = layer.opacity
        animation.toValue   = 1.0
        animation.duration  = 0.3
        
        /// Set the layer property to final value
        layer.opacity       = 1.0
        
        /// Add animation to layer
        layer.add(animation, forKey: "opacity")
    }
}

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
