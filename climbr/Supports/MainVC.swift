//
//  MainVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Cocoa
import Swinject

class MainVC: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        
        guard let vc = Container.shared.resolve(SplashVC.self) else {return}
        
        /// Add SplashVC to MainVC
        addSubViewController(vc, to: view)
    }

}

