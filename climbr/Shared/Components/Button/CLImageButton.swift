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
        self.wantsLayer = true
        self.controlSize = .regular
        self.cell?.isBezeled = false
        self.isBordered = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(imageName: String, accesibilityName: String, imgColor: NSColor, bgColor: NSColor) {
        super.init(frame: .zero)
        self.wantsLayer = false
        self.controlSize = .regular
        self.bezelStyle = .flexiblePush
        self.isBordered = true
        
        configureUI(imageName: imageName, accesibilityName: accesibilityName, imgColor: imgColor, bgColor: bgColor)
    }
    
    private func configureUI(imageName: String, accesibilityName: String, imgColor: NSColor, bgColor: NSColor){
        
        layer?.cornerRadius = 10
        layer?.backgroundColor = bgColor.cgColor
        contentTintColor = .white
        self.symbolConfiguration = NSImage.SymbolConfiguration(scale: .large)
        self.image = NSImage(systemSymbolName: imageName, accessibilityDescription: accesibilityName)
    }
    
//    override func updateLayer() {
//        super.updateLayer()
//
//        if isHighlighted {
//            layer?.backgroundColor = layer?.backgroundColor?.copy(alpha: 0.2)
//        } else {
//            layer?.backgroundColor = layer?.backgroundColor?.copy(alpha: 1.0)
//        }
//    }
}
