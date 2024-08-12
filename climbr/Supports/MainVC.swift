//
//  MainVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Cocoa

class MainVC: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        
        /// Add SplashVC to MainVC
        addSubViewController(SplashVC(), to: view)
    }

}

