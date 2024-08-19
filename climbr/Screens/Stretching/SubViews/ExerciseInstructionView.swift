//
//  ExerciseInstructionView.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 16/08/24.
//

import Cocoa

class ExerciseInstructionView: NSView {
    let imageView = NSImageView()
    let label = CLLabel(fontSize: 24, fontWeight: .semibold)
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        addSubview(imageView)
        addSubview(label)
        
        wantsLayer = true
        layer?.backgroundColor = .black.copy(alpha: 0.6)
        translatesAutoresizingMaskIntoConstraints = false
        
        label.setText("Fit yourself to this shape so we can see you better")
        label.alignment = .center
        label.textColor = .white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = .upperBodyOutline
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.imageScaling = .scaleProportionallyUpOrDown
        imageView.image?.size = NSSize(width: 720, height: 720)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
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
