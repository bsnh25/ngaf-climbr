//
//  OverlayWindow.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 28/10/24.
//

import Foundation
import AppKit
import Cocoa
import RiveRuntime

class OverlayWindow: NSWindowController {
    var riveVm: RiveViewModel?
    
    init() {
        let frame = NSScreen.main?.frame ?? .zero
        let window = NSPanel(
            contentRect: frame,
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )
        
        window.isFloatingPanel = true
        window.hidesOnDeactivate = false
        window.hasShadow = false
        window.becomesKeyOnlyIfNeeded = true
        window.level = .mainMenu
        window.backgroundColor = .clear
        window.collectionBehavior = [.canJoinAllSpaces]
        window.animationBehavior = .alertPanel
        
        super.init(window: window)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViewContoller(_ vc: NSViewController) {
        let vc = OverlayView()
        
        vc.delegate = self
        window?.contentViewController = vc
        window?.contentView = vc.view
        riveVm = vc.climbrVm
    }
    
    func show() {
        guard let window else { return }
        let frame = NSScreen.main?.frame ?? .zero
        let frameOverlay = CGRect(x: 510, y: 0, width: Int(frame.width * 0.67), height: Int(frame.height * 0.75))
        window.setFrame(frameOverlay, display: false)
        window.makeKeyAndOrderFront(nil)
        riveVm?.setInput("isIntro", value: true)
    }
    
    func dismiss() {
        riveVm?.setInput("isIntro", value: false)
        guard let window else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            window.orderOut(nil)
            self.close()
        }
    }
    
}

extension OverlayWindow: OverlayServices {
    func didOverlayDismissed() { dismiss() }
}
