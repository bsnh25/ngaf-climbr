//
//  CLTextButton.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 08/08/24.
//

import AppKit

class CLTextButton: NSButton {
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
    }
    
    init(titleBtn: String, labelColor: NSColor, bgColor: NSColor){
        super.init(frame: .zero)
        self.wantsLayer = true
        self.title = titleBtn
        self.bezelColor = bgColor //warna kontener
        self.bezelStyle = .flexiblePush
        self.contentTintColor = .selectedTextColor
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: labelColor
        ]
        attributedTitle = NSAttributedString(string: self.title, attributes: attributes)
        isEnabled = true
        target = self
    }
    
}

#Preview(traits: .defaultLayout, body: {
    CLTextButton()
})

