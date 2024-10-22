//
//  AppDelegate.swift
//  climbrHelper
//
//  Created by Bayu Septyan Nur Hidayat on 22/10/24.
//

import Cocoa
import ServiceManagement

@main
class AppDelegate: NSObject, NSApplicationDelegate {


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if #available(macOS 13.0, *) {
            let helperAppIdentifier = "com.hkbp.climbr.helper"
            let loginItem = SMAppService.loginItem(identifier: helperAppIdentifier)
            
            do {
                try loginItem.register()
                print("Helper App registered successfully.")
            } catch {
                print("Failed to register Helper App: \(error.localizedDescription)")
            }
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

