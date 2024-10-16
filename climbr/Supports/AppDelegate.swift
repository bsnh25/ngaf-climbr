//
//  AppDelegate.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import AppKit
import Swinject
import UserNotifications
import RiveRuntime

class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {

    var mainWindow: MainWindow?
    var statusBar: NSStatusBar!
    var statusBarItem: NSStatusItem!
    let audio = Container.shared.resolve(AudioService.self)
    var quitMenu: NSMenu!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        RenderContextManager.shared().defaultRenderer = .riveRenderer
        mainWindow = MainWindow()
        
        /// Create Quit Menu
        quitMenu = NSMenu()
        
        /// Create quit menu item
        let quitMenuItem = NSMenuItem(
            title: "Quit \(ProcessInfo.processInfo.processName)",
            action: #selector(quitApp(sender:)),
            keyEquivalent: "q"
        )
        
        quitMenu.addItem(quitMenuItem)
        
        ///create menu
//        let mainMenu = NSMenu()
//        NSApp.menu = mainMenu
//        let appMenuItem = NSMenuItem()
//        mainMenu.addItem(appMenuItem)
//        let appMenu = NSMenu(title: "App")
//        appMenuItem.submenu = appMenu
//        let quitMenuItem = NSMenuItem(
//            title: "Quit \(ProcessInfo.processInfo.processName)",
//            action: #selector(quitApp(sender:)),
//            keyEquivalent: "q"
//        )
//        appMenu.addItem(quitMenuItem)
        
        /// Get app main menu, the replace the submenu with quit menu
        if let mainMenu = NSApplication.shared.mainMenu {
            if let appMenuItem = mainMenu.items.first {
                appMenuItem.submenu = quitMenu
            }
        }
        
        NSApplication.shared.setActivationPolicy(.regular)
        
        
        mainWindow?.delegate = self

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
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
        NSApp.appearance = NSAppearance(named: .aqua)
        

        UNUserNotificationCenter.current().delegate = self

        mainWindow?.makeKeyAndOrderFront(nil)
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
        
        if let event = NSApplication.shared.currentEvent {
            if event.type == .rightMouseUp  {
                
                statusBarItem.menu = quitMenu
                statusBarItem.button?.performClick(nil)
                statusBarItem.menu = nil
                
                return
            } else {
                // Make sure the window is not nill
                /// Show the window and make window key, then activate the app
                if let window = mainWindow /*NSApplication.shared.windows.first*/ {
                    window.makeKeyAndOrderFront(nil)
                    NSApplication.shared.activate(ignoringOtherApps: true)
                } else {
                    print("Main window is not available.")
                    mainWindow = MainWindow()
                    mainWindow?.delegate = self
                    mainWindow?.makeKeyAndOrderFront(nil)
                    NSApplication.shared.activate(ignoringOtherApps: true)
                }
            }
        }
    }
    
    @objc private func quitApp(sender: Any?) {
        NSApplication.shared.terminate(sender)
    }
//
//    func applicationDidResignActive(_ notification: Notification) {
//        audio?.stopBackground()
//        print("Application resigned active")
//    }

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
    
//    func applicationWillUpdate(_ notification: Notification) {
//        ///audio setup
//        if let audio = audio {
//            audio.playBackgroundMusic(fileName: "summer")
//        } else {
//            print("AudioService not resolved.")
//        }
//    }
    
    
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

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
        
        print("Notification Did Received on foreground")
        
        var count = UserDefaults.standard.integer(forKey: UserDefaultsKey.kNotificationCount)
        
        count += 1
        
        UserDefaults.standard.setValue(count, forKey: UserDefaultsKey.kNotificationCount)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Notification Did Received on background")
        
        var count = UserDefaults.standard.integer(forKey: UserDefaultsKey.kNotificationCount)
        
        count += 1
        
        UserDefaults.standard.setValue(count, forKey: UserDefaultsKey.kNotificationCount)
        
        completionHandler()
        
        if let vc = Container.shared.resolve(StretchingVC.self) {
            mainWindow?.contentViewController?.push(to: vc)
            print("go to stretching session")
        }
    }
}
