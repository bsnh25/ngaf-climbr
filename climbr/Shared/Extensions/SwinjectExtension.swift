//
//  SwinjectExtension.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 13/08/24.
//

import Foundation
import Swinject

extension Container {
    static let shared: Container = {
        let container = Container()
        
        /// Managers
        container.register(AudioService.self) { _ in AudioManager.shared }
        
        /// ViewControllers
        container.register(MainVC.self) { resolver in
            return MainVC()
        }
        
        container.register(StretchingVC.self) { resolver in
            let audioService = resolver.resolve(AudioService.self)
            
            return StretchingVC(audioService: audioService)
        }
        
        return container
    }()
}
