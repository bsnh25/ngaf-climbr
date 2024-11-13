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
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
          messageText = "Climbr Desktop App\nversion \(version)"
        }
      
        if let year = Calendar.current.dateComponents([.year], from: .now).year {
          informativeText = "Optimized for Apple Silicon\nCopyright 􀀈 \(year) !GAF Team"
        }
      
        addButton(withTitle: "OK")
        alertStyle = .informational
    }
    
}
