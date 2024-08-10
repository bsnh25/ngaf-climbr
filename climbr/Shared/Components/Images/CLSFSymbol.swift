//
//  CLSFSymbol.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 10/08/24.
//

import Cocoa

class CLSFSymbol: NSImageView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(symbolName: String, description: String) {
        super.init(frame: .zero)
        configure()
        
        image   = NSImage(systemSymbolName: symbolName, accessibilityDescription: description)
    }
    
    func setConfiguration(size: CGFloat, weight: NSFont.Weight) {
        symbolConfiguration = NSImage.SymbolConfiguration(pointSize: size, weight: weight)
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size),
            heightAnchor.constraint(equalToConstant: size)
        ])
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
