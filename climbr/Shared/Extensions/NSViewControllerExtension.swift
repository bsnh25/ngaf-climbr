//
//  NSViewControllerExtension.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 09/08/24.
//

import AppKit

extension NSViewController {
    func addSubViewController(_ vc: NSViewController, to view: NSView) {
        addChild(vc)
        
        view.addSubview(vc.view)
        vc.view.frame = view.bounds
    }
    
    func push(_ vc: NSViewController) {
        let currentVC = children.first
        
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.3
            
            currentVC?.view.animator().alphaValue = 0
        } completionHandler: {
            currentVC?.view.removeFromSuperview()
            currentVC?.removeFromParent()
            
            self.addChild(vc)
            self.view.addSubview(vc.view)
            vc.view.frame = self.view.bounds
            vc.view.autoresizingMask = [.height, .width]
            
            vc.view.animator().alphaValue = 0
            
            NSAnimationContext.runAnimationGroup { context in
                context.duration = 0.3
                
                vc.view.animator().alphaValue = 1
            }
        }

    }
}
