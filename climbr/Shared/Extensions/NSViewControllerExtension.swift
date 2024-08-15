//
//  NSViewControllerExtension.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 09/08/24.
//

import AppKit

fileprivate var overlayView: CustomOverlayView!

extension NSViewController {
    func addSubViewController(_ vc: NSViewController, to view: NSView) {
        addChild(vc)
        
        overlayView = CustomOverlayView(frame: view.bounds)
        overlayView.wantsLayer = true
        overlayView.layer?.backgroundColor = .clear
        overlayView.autoresizingMask = [.width, .height]
        
        view.addSubview(vc.view)
        vc.view.frame = view.bounds
        vc.view.addSubview(overlayView, positioned: .below, relativeTo: nil)
    }
    
    func push(to vc: NSViewController) {
        
        if let contentVC = self.view.window?.contentViewController {
            print("NAV - Before Push: ", contentVC.children)
            
            
            NSAnimationContext.runAnimationGroup { context in
                context.duration = 0.3
                
                vc.view.animator().alphaValue = 0
            } completionHandler: {
                
                
                contentVC.addSubViewController(vc, to: contentVC.view)
                
                vc.view.animator().alphaValue = 1
                
                print("NAV - After Push: ", contentVC.children)
            }
        }
        
    }
    
    func pop() {
        
        if let contentVC = self.view.window?.contentViewController {
            print("NAV - Before Pop: ", contentVC.children)
            guard let currentVC = contentVC.children.last else {
                return
            }
            
            NSAnimationContext.runAnimationGroup { context in
                context.duration = 0.3
                
                /// Set next vc view opacity to zero
                currentVC.view.animator().alphaValue = 0
            } completionHandler: {
                /// Remove current VC from parent
                currentVC.removeFromParent()
                currentVC.view.removeFromSuperview()
                
                // Remove overlay from superview
                overlayView.removeFromSuperview()
                
                print("NAV - After Pop: ", contentVC.children)
            }
        }
    }
    
    func replace(with nextViewController: NSViewController) {
        if let contentVC = self.view.window?.contentViewController {
            print("NAV - Before Replace: ", contentVC.children)
            guard let currentVC = contentVC.children.last else {
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
                    
                    print("NAV - After Replace: ", contentVC.children)
                }
                
            }
        }
    }
    
    func resetAndAdjust(with vc: NSViewController){
        
        if let contentVC = self.view.window?.contentViewController {
            print("NAV - Before Reset: ", contentVC)
            contentVC.children.removeAll()
            if contentVC.children.isEmpty {
                NSAnimationContext.runAnimationGroup { context in
                    context.duration = 0.2
                    
                    /// Set next vc view opacity to zero
                    vc.view.animator().alphaValue = 0
                } completionHandler: {
                    /// Add next vc to the content vc
                    contentVC.addSubViewController(vc, to: contentVC.view)
                    vc.view.animator().alphaValue = 1
                    print("NAV - After Reset: ", contentVC.children)
                }
            } else {
                print("Err reset: ", contentVC.children)
            }
        }
    }
}

class CustomOverlayView: NSView {
    override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        return false
    }
    override var allowedTouchTypes: NSTouch.TouchTypeMask {
        get { return [] }
        set { }
    }
    
    override func mouseDown(with event: NSEvent) {
        
    }
}
