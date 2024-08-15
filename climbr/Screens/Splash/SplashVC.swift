//
//  SplashVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 13/08/24.
//

import Cocoa
import Swinject

class SplashVC: NSViewController {
    
    let appLogoView = NSImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: UserDefaultsKey.kFirstTime)
        view.wantsLayer = true
        view.layer?.backgroundColor = .white
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            /// After 3 seconds, replace this VC with HomeVC
            if UserDefaults.standard.bool(forKey: UserDefaultsKey.kFirstTime) {
                guard let onBoardVc = Container.shared.resolve(UserPreferenceVC.self) else {return}
                self.replace(with: onBoardVc)
                UserDefaults.standard.setValue(Date(), forKey: UserDefaultsKey.kDateNow)
                print("DATE GMT+0 : \(UserDefaults.standard.object(forKey: UserDefaultsKey.kDateNow)!)")
            } else{
                
                guard let vc = Container.shared.resolve(HomeVC.self) else {return}
                self.replace(with: vc)
            }
        }
    }
}
