//
//  AppDelegate.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {

    let mainWindow = MainWindow()
    var statusBar: NSStatusBar!
    var statusBarItem: NSStatusItem!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        /// Create status bar instance
        statusBar       = NSStatusBar()
        /// Create status item with dynamic size (depends on its content)
        statusBarItem   = statusBar.statusItem(withLength: NSStatusItem.variableLength)
        /// Make sure the button is not nil
        if let button = statusBarItem.button {
            /// Set the image with SFSymbol
            button.image    = NSImage(systemSymbolName: "figure.hiking", accessibilityDescription: "Climbr")
            /// Set the action button to run openApp function
            button.action   = #selector(openApp)
            button.target   = self
        }
        
        mainWindow.makeKeyAndOrderFront(nil)
    }
    

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    @objc private func openApp() {
        /// Make sure the window is not nill
        ///
        /// Show the window and make window key, then activate the app
        if let window = NSApplication.shared.windows.first {
            window.makeKeyAndOrderFront(nil)
            NSApplication.shared.activate(ignoringOtherApps: true)
        }
    }

}

