//
//  CLTextField.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 13/08/24.
//

import Cocoa

class CLTextField: NSTextField {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        configure()
    }
    
    init(placeholder: String){
        super.init(frame: .zero)
        self.placeholderString = placeholder
        configure()
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        wantsLayer = true
        layer?.cornerRadius = 5
        backgroundColor = NSColor.white
        translatesAutoresizingMaskIntoConstraints = false
        isBordered = false
        isSelectable = true
        isEditable = true
        textColor = NSColor.black
        
        // Tambahkan ini untuk mengatur perataan tengah
        alignment = .center
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: NSColor.gray,
            .font: NSFont.systemFont(ofSize: 20, weight: .regular),
            .paragraphStyle: paragraphStyle
        ]
        
        placeholderAttributedString = NSAttributedString(string: self.placeholderString!, attributes: attributes)
        font = NSFont.systemFont(ofSize: 20, weight: .regular)
    }
}
