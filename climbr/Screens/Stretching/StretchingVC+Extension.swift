//
//  StretchingVC+Extension.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import AppKit

extension StretchingVC {
    @objc func skip() {
        guard let _ = Movement.items[safe: currentIndex+1] else {
            return
        }
        
        currentIndex += 1
        nextIndex     = currentIndex+1
    }
    
    func finishEarly() {
        push(StretchingResultVC())
    }
    
    @objc func showEndSessionAlert() {
        let alert                   = NSAlert()
        alert.messageText           = "Leaving So Soon?"
        alert.informativeText       = "Finishing the session early will reduce the amount of reward you will receive"
        alert.alertStyle            = .informational
        alert.icon                  = NSImage.appLogo
        alert.addButton(withTitle: "Stay")
        alert.addButton(withTitle: "End Session")
        
        if #available(macOS 11.0,*) {
            alert.buttons.last?.hasDestructiveAction = true
        }
        
        let result = alert.runModal()
        
        if result == .alertSecondButtonReturn {
            finishEarly()
        }
    }
    
    
}
