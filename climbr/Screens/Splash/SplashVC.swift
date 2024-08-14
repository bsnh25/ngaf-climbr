//
//  SplashVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 13/08/24.
//

import Cocoa

class SplashVC: NSViewController {
    
    let appLogoView     = NSImageView()
    var isFirstTime: Void     = UserDefaults.standard.set(true, forKey: "isFirstTime")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAppLogo()
        
        navigateToHome()
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
    
    private func navigateToHome() {
        let onboardingStage = UserPreferenceVC()
        let vc          = HomeVC()
        vc.audioService = AudioManager.shared
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            /// After 3 seconds, replace this VC with HomeVC
            if UserDefaults.standard.bool(forKey: "isFirstTime") {
                self.replace(with: onboardingStage)
            }else{
                self.replace(with: vc)
            }
        }
    }
}
