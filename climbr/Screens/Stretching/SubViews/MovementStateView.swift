//
//  MovementStateView.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 12/08/24.
//

import Cocoa

class MovementStateView: NSView {
    let label      = CLLabel(fontSize: 16, fontWeight: .bold)

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints          = false
        label.translatesAutoresizingMaskIntoConstraints    = false
        
        label.setText("Incorrect")
        label.backgroundColor  = .clear
        
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
    
}
