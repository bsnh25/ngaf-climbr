//
//  MainVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Cocoa

class MainVC: NSViewController {
    
    let appLogoView     = NSImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAppLogo()
    }
    
    private func configureAppLogo() {
        view.addSubview(appLogoView)
        
        appLogoView.image   = NSImage.appLogo
        appLogoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appLogoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            appLogoView.widthAnchor.constraint(equalToConstant: 238)
        ])
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

