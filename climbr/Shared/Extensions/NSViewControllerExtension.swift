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
    
    func push(to vc: NSViewController) {
        
        if let contentVC = self.view.window?.contentViewController {
            print("NAV - Before Push: ", contentVC.children)
            
            guard let currentVC = contentVC.children.last else {
                return
            }
            
            NSAnimationContext.runAnimationGroup { context in
                context.duration = 0.3
                
                vc.view.animator().alphaValue = 0
            } completionHandler: {
                contentVC.addSubViewController(vc, to: contentVC.view)
                
                vc.view.animator().alphaValue = 1
                
                /// Hide the current VC
                currentVC.view.isHidden = true
                
                print("NAV - After Push: ", contentVC.children)
                
                NSAnimationContext.runAnimationGroup { context in
                    context.duration = 0.3
                    
                    /// Unhide previous vc
                    contentVC.children.first?.view.isHidden = false
                }
            }
        }

    }
    
    func pop() {
        
        if let contentVC = self.view.window?.contentViewController {
            print("NAV - Before Pop: ", contentVC)
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
                
                print("NAV - After Pop: ", contentVC)
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
}
