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
        container.register(PredictorService.self) { _ in PredictorManager() }
        container.register(AudioService.self) { _ in AudioManager.shared }
        container.register(CameraService.self) { _ in CameraManager() }
        container.register(NotificationService.self) { _ in NotificationManager.shared }
        container.register(PersistenceController.self) { _ in return PersistenceController.shared }
        container.register(CharacterService.self) { resolver in
            let persistence = resolver.resolve(PersistenceController.self)
            return UserManager(controller: persistence)
        }
        container.register(EquipmentService.self) { resolver in
            let persistence = resolver.resolve(PersistenceController.self)
            return EquipmentManager(controller: persistence)
        }
        
        /// ViewControllers
        container.register(MainVC.self) { resolver in
            return MainVC()
        }
        
        container.register(SplashVC.self) { resolver in
            let user = resolver.resolve(CharacterService.self)
            return SplashVC(userService: user)
        }
        
        container.register(UserPreferenceVC.self) { resolver in
            let notif = resolver.resolve(NotificationService.self)
            let char = resolver.resolve(CharacterService.self)
            return UserPreferenceVC(charService: char, notifService: notif)
        }
        
        container.register(ChooseCharacterVC.self) { resolver in
            let char     = resolver.resolve(CharacterService.self)
            return ChooseCharacterVC(charService: char)
        }
        
        container.register(HomeVC.self) { resolver in
            let audio = resolver.resolve(AudioService.self)
            let char = resolver.resolve(CharacterService.self)
            let equipment = resolver.resolve(EquipmentService.self)
            return HomeVC(audioService: audio, charService: char, equipmentService: equipment)
        }
        
        container.register(SettingVC.self) { resolver in
            let char = resolver.resolve(CharacterService.self)
            return SettingVC(charService: char)
        }
        
        container.register(ShopItemVC.self) { resolver in
            return ShopItemVC()
        }
        
        container.register(StretchingResultVC.self) { resolver in
            let char     = resolver.resolve(CharacterService.self)
            
            return StretchingResultVC(charService: char)
        }
        
        container.register(StretchingVC.self) { resolver in
            let audioService    = resolver.resolve(AudioService.self)
            let cameraService   = resolver.resolve(CameraService.self)
            let predictorService   = resolver.resolve(PredictorService.self)
            
            return StretchingVC(audioService: audioService, cameraService: cameraService, predictor: predictorService)
        }
        
        container.register(ChooseCharacterVC.self){ resolver in
            let char     = resolver.resolve(CharacterService.self)
            
            return ChooseCharacterVC(charService: char)
        }
        
        container.register(TutorialVC.self){ resolver in
            let char = resolver.resolve(CharacterService.self)
            return TutorialVC(charService: char)
        }
        
        
        return container
    }()
}
