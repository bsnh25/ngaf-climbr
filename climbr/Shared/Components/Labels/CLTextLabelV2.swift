//
//  CLTextLabelV2.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 10/08/24.
//

import AppKit

class CLTextLabelV2: NSTextField {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(sizeOfFont: CGFloat, weightOfFont: NSFont.Weight, contentLabel: String){
        super.init(frame: .zero)
        wantsLayer = false
        isBordered = false
        isEditable = false
        isBezeled = false
        backgroundColor = .clear
        textColor = .black
        stringValue = contentLabel
        font = NSFont.systemFont(ofSize: sizeOfFont, weight: weightOfFont)
        
    }
    
    func setText(_ contentLabel: String){
        stringValue = contentLabel
    }
    
}
