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
        
        print(self.children)
        
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
    
    func pop() {
        
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.3
            
            /// Set current view opacity to zero
            self.view.animator().alphaValue = 0
        } completionHandler: {
            /// After animation complete, remove current VC from parent and remove current view from superview
            self.removeFromParent()
            self.view.removeFromSuperview()
        }
        
    }
    
    func replace(with nextViewController: NSViewController) {
        if let contentVC = self.view.window?.contentViewController {
            guard let currentVC = contentVC.children.first else {
                return
            }
            
            NSAnimationContext.runAnimationGroup { context in
                context.duration = 0.3
                
                /// Set next vc view opacity to zero
                nextViewController.view.animator().alphaValue = 0
            } completionHandler: {
                /// Add next vc to the content vc
                contentVC.addSubViewController(nextViewController, to: contentVC.view)
                
                NSAnimationContext.runAnimationGroup { context in
                    context.duration = 0.3
                    
                    /// Set back next vc view opacity to one
                    nextViewController.view.animator().alphaValue = 1
                } completionHandler: {
                    /// After animation comple, remove current vc from parent and remove current view from super view
                    currentVC.removeFromParent()
                    currentVC.view.removeFromSuperview()
                }
                
            }
        }
    }
}
