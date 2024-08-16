//
//  CLDatePicker.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 11/08/24.
//

import Cocoa

class CLDatePicker: NSDatePicker {
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        configure()
    }
    
    init(backgroundColor: NSColor, textColor: NSColor, datePickerStyleElement: NSDatePicker.ElementFlags, font: NSFont) {
        super.init(frame: .zero)
        configure()
        self.font = font
        self.layer?.backgroundColor = backgroundColor.cgColor
        self.textColor = textColor
        self.datePickerElements = datePickerStyleElement
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        self.wantsLayer = true
        translatesAutoresizingMaskIntoConstraints = false
        layer?.cornerRadius = 5
        isBordered = false
        isBezeled = false
        datePickerStyle = .textField
        datePickerMode = .single
        
    }
    
    
}
