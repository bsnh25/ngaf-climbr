//
//  MainWindow.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Cocoa
import Swinject

class MainWindow: NSWindow {
  
    let screenFrame = NSRect(x: 0, y: 0, width: 1200, height: 840)
  
    init() {
        /// Init the main window with following parameters:
        super.init(
            contentRect: screenFrame,
            styleMask: [
              .titled, .closable, .miniaturizable, .resizable, .borderless, .fullSizeContentView
            ],
            backing: .buffered,
            defer: false
        )
        
        /// Set the title bar to transparent
        titlebarAppearsTransparent = true
      
        minSize = NSSize(width: screenFrame.width, height: screenFrame.height)
        
        /// Set the window to center axis by default
        center()
    }
  
    func addViewController(_ vc: NSViewController) {
      contentView             = vc.view
      contentViewController   = vc
    }
}
