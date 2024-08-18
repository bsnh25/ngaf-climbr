//
//  Divider.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 10/08/24.
//

import AppKit

class Divider: NSBox {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(color: NSColor) {
        super.init(frame: .zero)
        configure()
        borderColor                                 = color
    }
    
    private func configure() {
        boxType                                     = .separator
        translatesAutoresizingMaskIntoConstraints   = false
    }
    
}
