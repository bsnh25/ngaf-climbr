//
//  MovementStateView.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 12/08/24.
//

import AppKit

class MovementStateView: NSView {
    let label      = CLLabel(fontSize: 16, fontWeight: .bold)

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints          = false
        label.translatesAutoresizingMaskIntoConstraints    = false
        
        label.setText("Position Incorrect")
        label.backgroundColor  = .clear
        label.textColor        = .black
        
        addSubview(label)
        wantsLayer                = true
        layer?.backgroundColor    = .white
        layer?.cornerRadius       = 10
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func setLabel(_ text: String) { label.setText(text) }
    
    func setForegroundColor(_ color: NSColor) { label.setTextColor(color) }
    
    func setBackgroundColor(_ color: NSColor) {
        /// Make sure the layer is exist
        guard let layer         = self.layer else { return }
        
        /// Create CAPropertyAnimation based on keypath
        ///
        /// Then set the inital value, final value, and duration
        let animation           = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue     = layer.backgroundColor
        animation.toValue       = color.cgColor
        animation.duration      = 0.3
            
        /// Set the layer property to final value
        layer.backgroundColor   = color.cgColor
        
        /// Add animation to layer
        layer.add(animation, forKey: "backgroundColor")
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
