//
//  CLTextButtonV2.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 09/08/24.
//

import Cocoa

class CLTextButtonV2: NSButton {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.isBordered = false // Remove default button border
    }
    
    override func draw(_ dirtyRect: NSRect) {
        if let backgroundColor = layer?.backgroundColor {
            NSColor(cgColor: backgroundColor)?.setFill()
        } else {
            NSColor.clear.setFill()
        }
        let path = NSBezierPath(roundedRect: bounds, xRadius: 20, yRadius: 20)
        path.fill()
        super.draw(dirtyRect)
    }
    
    init(title: String, backgroundColor: NSColor, foregroundColorText: NSColor, fontText: NSFont) {
        super.init(frame: .zero)
        wantsLayer = true
        self.title = title
        self.isBordered = false // Remove default button border
        self.bezelStyle = .regularSquare // Set the bezel style to a flat square
        configure(foregroundColorText: foregroundColorText, font: fontText, backgroundColor: backgroundColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(foregroundColorText: NSColor, font: NSFont, backgroundColor: NSColor) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: foregroundColorText,
            .font: font
        ]
        layer?.cornerRadius = 20
        layer?.backgroundColor = backgroundColor.cgColor
        attributedTitle = NSAttributedString(string: self.title, attributes: attributes)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}


#Preview(traits: .defaultLayout, body: {
    CLTextButtonV2()
})

