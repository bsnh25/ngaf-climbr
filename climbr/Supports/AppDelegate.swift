//
//  AppDelegate.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import AppKit
import Swinject

class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {

    var mainWindow: MainWindow?
    var statusBar: NSStatusBar!
    var statusBarItem: NSStatusItem!
    let audio = Container.shared.resolve(AudioService.self)


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // Insert code here to initialize your application
        mainWindow = MainWindow()
        
        NSApp.setActivationPolicy(.regular)
        NSApplication.shared.setActivationPolicy(.regular)
        
        guard let mainWindow = mainWindow else {return}
        mainWindow.delegate = self

        /// Create status bar instance
        statusBar       = NSStatusBar()
        
        /// Create status item with dynamic size (depends on its content)
        statusBarItem   = statusBar.statusItem(withLength: NSStatusItem.variableLength)
        
        /// Make sure the button is not nil
        if let button = statusBarItem.button {
            
            /// Set the image with custom icon
            let image       = NSImage.stretchingIcon
            image.size      = CGSize(width: 16, height: 16)
            button.image    = image
            
            /// Set the action button to run openApp function
            button.action   = #selector(openApp)
            button.target   = self
        }
        NSApp.appearance = NSAppearance(named: .aqua)
        ///audio setup
        if let audio = audio {
            audio.playBackgroundMusic(fileName: "summer")
        } else {
            print("AudioService not resolved.")
        }

        mainWindow.makeKeyAndOrderFront(nil)
    }
    

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        audio?.stopBackground()
        print("Application will terminate")
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    @objc private func openApp() {
        /// Make sure the window is not nill
        /// Show the window and make window key, then activate the app
        if let window = NSApplication.shared.windows.first {
            window.makeKeyAndOrderFront(nil)
            NSApplication.shared.activate(ignoringOtherApps: true)
        } else {
            print("Main window is not available.")
        }
    }
    
    
    func applicationDidResignActive(_ notification: Notification) {
        audio?.stopBackground()
        print("Application resigned active")
        
    }

    func windowWillClose(_ notification: Notification) {
        NSApp.hide(nil) // Menyembunyikan aplikasi saat jendela ditutup
        if let audio = audio {
            audio.stopBackground()
        } else {
            print("AudioService not resolved.")
        }

        print("Application will close")
        mainWindow?.isReleasedWhenClosed = false
        NSApplication.shared.setActivationPolicy(.accessory)
    }
    
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {

        
        if !flag {
            mainWindow?.orderFront(self)
            if let window = mainWindow {
                window.makeKeyAndOrderFront(nil)
                NSApplication.shared.activate(ignoringOtherApps: true)
            } else {
                mainWindow?.makeKeyAndOrderFront(self)
                print("Creating a new mainWindow instance.")
                mainWindow = MainWindow()
                mainWindow?.delegate = self
                mainWindow?.makeKeyAndOrderFront(nil)
                NSApplication.shared.activate(ignoringOtherApps: true)
            }
        }
        
        return true
    }
}

