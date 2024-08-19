//
//  SubtractedView.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 18/08/24.
//

import AppKit

class SubtractedView: NSView {
    
    override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        return false
    }
    override var allowedTouchTypes: NSTouch.TouchTypeMask {
        get { return [] }
        set { }
    }
    
    override func mouseDown(with event: NSEvent) {
        
        /// Only enable touch on specific area
        if subtractRect.contains(event.locationInWindow) {
            super.mouseDown(with: event)
        }
    }
    
    private var subtractRect: NSRect = .zero
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        // Ensure the view has a backing layer
        self.wantsLayer = true
        translatesAutoresizingMaskIntoConstraints = false
        
        subtractRect = self.bounds
        // Optionally, give the view a background color to make the effect visible
        self.layer?.backgroundColor = .black.copy(alpha: 0.8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layout() {
        
        super.layout()
        print("NEED LAYOUT")
        
        // Define the path that represents the entire view's bounds
        let fullPath = NSBezierPath(rect: self.frame)
        
        // Define the path for the shape to subtract (e.g., a circle in the center)
        let subtractPath = NSBezierPath(roundedRect: subtractRect, xRadius: 26, yRadius: 26)
        
        // Append the subtract path to the full path with even-odd rule
        fullPath.append(subtractPath)
        fullPath.windingRule = .evenOdd
        
        // Create a CAShapeLayer with the combined path
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.frame
        maskLayer.path = fullPath.cgPath
        maskLayer.fillRule = .evenOdd
        
        // Apply the mask to the view's layer
        self.layer?.mask = maskLayer
        
        print("frame: subtract ", self.bounds)
    }
    
    func subtract(with rect: NSRect) {
        subtractRect = rect
        needsLayout = true
    }
    
}
