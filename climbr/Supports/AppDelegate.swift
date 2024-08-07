//
//  AppDelegate.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    let mainWindow = MainWindow()


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        mainWindow.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

