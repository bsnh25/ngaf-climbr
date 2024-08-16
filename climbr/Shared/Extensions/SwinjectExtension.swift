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
        container.register(CameraService.self) { _ in CameraManager() }
        container.register(UserService.self) { _ in UserManager() }
        container.register(NotificationService.self) { _ in NotificationManager.shared }
//        container.register(ProgressService.self) { _ in ProgressService() }
        
        /// ViewControllers
        container.register(MainVC.self) { resolver in
            return MainVC()
        }
        
        container.register(SplashVC.self) { resolver in
            let user = resolver.resolve(UserService.self)
            return SplashVC(userService: user)
        }
        
        container.register(UserPreferenceVC.self) { resolver in
            let notif = resolver.resolve(NotificationService.self)
            let user = resolver.resolve(UserService.self)
            return UserPreferenceVC(userService: user, notifService: notif)
        }
        
        container.register(ChooseCharacterVC.self) { resolver in
            let userService     = resolver.resolve(UserService.self)
            return ChooseCharacterVC(userService: userService)
        }
        
        container.register(HomeVC.self) { resolver in
            let audio = resolver.resolve(AudioService.self)
            let user = resolver.resolve(UserService.self)
            return HomeVC(audioService: audio, userService: user)
        }
        
        container.register(SettingVC.self) { resolver in
            return SettingVC()
        }
        
        container.register(StretchingResultVC.self) { resolver in
            let userService     = resolver.resolve(UserService.self)
            
            return StretchingResultVC(userService: userService)
        }
        
        container.register(StretchingVC.self) { resolver in
            let audioService    = resolver.resolve(AudioService.self)
            let cameraService   = resolver.resolve(CameraService.self)
            
            return StretchingVC(audioService: audioService, cameraService: cameraService)
        }
        
        container.register(ChooseCharacterVC.self){ resolver in
            let userService     = resolver.resolve(UserService.self)
            
            return ChooseCharacterVC(userService: userService)
        }
        
        return container
    }()
}
