//
//  MainWindow.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Cocoa

class MainWindow: NSWindow {
    var audioService: AudioService?
    init(audioService: AudioService) {
        self.audioService = audioService
        /// Init the main window with following parameters:
        super.init(
            contentRect: NSRect(x: 0, y: 0, width: 1200, height: 840),
            styleMask: [
                .titled, .closable, .miniaturizable, .fullSizeContentView
            ],
            backing: .buffered,
            defer: false
        )
        
        /// Set the title bar to transparent
        titlebarAppearsTransparent = true
        
        /// Set the window to center axis by default
        center()
        let vc                  = ChooseCharacterVC()
        contentView             = vc.view
        contentViewController   = vc
    }
}
