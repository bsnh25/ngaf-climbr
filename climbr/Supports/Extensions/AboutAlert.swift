//
//  AboutVC.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 12/11/24.
//

import Cocoa

class AboutAlert: NSAlert {
    
    override init() {
        super.init()
        
        icon = NSImage(named: "AppIcon")
        messageText = "Climbr Desktop App\nversion 2.0.0"
        informativeText = "Optimized for Apple Silicon\nCopyright 􀀈 2024 !GAF Team"
        addButton(withTitle: "OK")
        alertStyle = .informational
    }
    
}
