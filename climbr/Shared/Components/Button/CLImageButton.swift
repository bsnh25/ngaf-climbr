//
//  CLImageButton.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 08/08/24.
//

import AppKit

class CLImageButton: NSButton {
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        
    }
    
    init(imageName: String, accesibilityName: String, imgColor: NSColor, bgColor: NSColor) {
        super.init(frame: .zero)
        self.wantsLayer = true
        self.bezelColor = bgColor //warna kontener
        self.symbolConfiguration = NSImage.SymbolConfiguration(hierarchicalColor: imgColor) //warna image
//        self.symbolConfiguration = NSImage.SymbolConfiguration(scale: scale)
        self.image = NSImage(systemSymbolName: imageName, accessibilityDescription: accesibilityName)
        self.bezelStyle = .flexiblePush
        self.isEnabled = true
        self.target = self
        self.controlSize = .large
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

#Preview(traits: .defaultLayout, body: {
    CLImageButton()
})
