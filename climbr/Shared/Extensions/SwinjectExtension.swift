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
        /// Ubah yang masih shared
        container.register(PredictorService.self) { _ in PredictorManager() }
        container.register(AudioService.self) { _ in AudioManager.shared } ///dipake di banyak tempat
        container.register(CameraService.self) { _ in CameraManager() } ///dipake di satu tempat saja
        container.register(PersistenceController.self) { _ in return PersistenceController.shared }
        container.register(EquipmentService.self) { resolver in
            let persistence = resolver.resolve(PersistenceController.self)
            return EquipmentManager(controller: persistence)
        }
        
        /// ViewControllers
        container.register(MainVC.self) { resolver in
            return MainVC()
        }
        
        container.register(SplashVC.self) { resolver in
            let char = resolver.resolve(CharacterService.self)
            return SplashVC(charService: char)
        }
        
        container.register(UserPreferenceVC.self) { _ in
          return UserPreferenceVC()
        }
        
        container.register(ChooseCharacterVC.self) { _ in
            return ChooseCharacterVC()
        }
        
        container.register(HomeVC.self) { resolver in
            let audio = resolver.resolve(AudioService.self)
            let equipment = resolver.resolve(EquipmentService.self)
            return HomeVC(audioService: audio, equipmentService: equipment)
        }
        
        container.register(SettingVC.self) { _ in
            return SettingVC()
        }
        
        container.register(ShopItemVC.self) { resolver in
            let equipment = resolver.resolve(EquipmentService.self)
            return ShopItemVC(equipment: equipment)
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
        
        container.register(TutorialVC.self){ resolver in
            return TutorialVC()
        }
        
        
        return container
    }()
}
