//
//  CLGradientContainer.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 13/08/24.
//

import Cocoa

class RadialGradientView: NSView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Tentukan warna-warna untuk gradien
        let gradient = NSGradient(starting: NSColor(red: 90/255, green: 213/255, blue: 255/255, alpha: 1), ending: NSColor(red: 207/255, green: 244/255, blue: 255/255, alpha: 1))
        
        // Tentukan titik pusat dan radius untuk radial gradient
        let centerPoint = NSPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = max(bounds.width, bounds.height) / 2
        
        // Gambar radial gradient
        gradient?.draw(fromCenter: centerPoint, radius: 0, toCenter: centerPoint, radius: radius, options: .drawsBeforeStartingLocation)
    }
    
    
}

