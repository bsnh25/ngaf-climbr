//
//  CLBlurEffectView.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 15/08/24.
//

import Cocoa

class CLBlurEffectView: NSVisualEffectView {

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
    
    private func configure() {
        blendingMode = .withinWindow
        material     = .hudWindow
//        appearance   = NSAppearance(named: .vibrantLight)
        
        state        = .active
        autoresizingMask = [.width, .height]
    }
    
}
