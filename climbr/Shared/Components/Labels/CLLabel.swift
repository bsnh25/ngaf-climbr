//
//  CLLabel.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 10/08/24.
//

import AppKit

class CLLabel: NSTextField {

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
    
    init(text: String, foregroundColor: NSColor) {
        super.init(frame: .zero)
        
        configure()
        
        stringValue = text
        textColor   = foregroundColor
    }
    
    init(fontSize: CGFloat, fontWeight: NSFont.Weight) {
        super.init(frame: .zero)
        
        configure()
        
        font    = NSFont.systemFont(ofSize: fontSize, weight: fontWeight)
    }
    
    func setText(_ text: String) {
        stringValue = text
    }
    
    func setTextColor(_ color: NSColor) {
        textColor   = color
    }
    
    func setFont(ofSize: CGFloat, weight: NSFont.Weight) {
        font    = NSFont.systemFont(ofSize: ofSize, weight: weight)
    }
    
    private func configure() {
        isBordered      = false
        isEditable      = false
        
        translatesAutoresizingMaskIntoConstraints   = false
    }
    
}
