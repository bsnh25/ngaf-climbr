//
//  CLTextButtonV2.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 09/08/24.
//

import Cocoa

class CLTextButtonV2: NSButton {

    var backgroundColor: NSColor!
    var foregroundColorText: NSColor!
    var fontText: NSFont!

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.isBordered = false // Remove default button border
        self.wantsLayer = true // Ensure the layer is available for custom drawing
    }
    init(title: String, backgroundColor: NSColor, foregroundColorText: NSColor, fontText: NSFont) {
        super.init(frame: .zero)
        
        wantsLayer = true
        
        self.title                  = title
        self.isBordered             = false
        layer?.backgroundColor      = backgroundColor.cgColor
        
        self.backgroundColor        = backgroundColor
        self.foregroundColorText    = foregroundColorText
        self.fontText               = font

        configure(foregroundColorText: foregroundColorText, font: fontText)
    }
    
    init(title: String, borderColor: NSColor, font: NSFont) {
        super.init(frame: .zero)
        
        self.wantsLayer             = true
        self.title                  = title
        self.isBordered             = false
        self.layer?.borderColor     = borderColor.cgColor
        self.layer?.borderWidth     = 1.5
        self.layer?.backgroundColor = .white.copy(alpha: 0)
        
        configure(foregroundColorText: borderColor, font: font)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure(foregroundColorText: NSColor, font: NSFont) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: foregroundColorText,
            .font: font
        ]
        
        attributedTitle     = NSAttributedString(string: self.title, attributes: attributes)
        layer?.cornerRadius = 10
        bezelStyle          = .flexiblePush
        
        translatesAutoresizingMaskIntoConstraints = false
    }

    override func updateLayer() {
        super.updateLayer()

        if isHighlighted {
            layer?.backgroundColor = layer?.backgroundColor?.copy(alpha: 0.7)
        } else {
            layer?.backgroundColor = layer?.backgroundColor?.copy(alpha: 1.0)
        }
        
        if !isEnabled {
            layer?.backgroundColor = layer?.backgroundColor?.copy(alpha: 0.1)
            
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: layer?.backgroundColor,
                .font: fontText!
            ]
            
            attributedTitle = NSAttributedString(string: self.title, attributes: attributes)
        }
    }
    
}
