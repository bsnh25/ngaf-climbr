//
//  SplashVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 13/08/24.
//

import Cocoa
import Swinject

class SplashVC: NSViewController {
    
    let appLogoView = NSImageView(image: .appLogo)
    let mountainImage = NSImageView(image: .onboardingmountain)
    var userService: UserService?
    var mountainImageTopConstraint: NSLayoutConstraint!
    var mountainImageCenterYConstraint: NSLayoutConstraint!
    var appLogoCenterYConstraint: NSLayoutConstraint!
    
    init(userService: UserService?){
        super.init(nibName: nil, bundle: nil)
        self.userService = userService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.onboardingBackground.cgColor
        configureMountainImage()
        configureAppLogo()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.animateTransition()
        }
        navigateToHome()
    }
    
    private func configureMountainImage() {
        view.addSubview(mountainImage)
        mountainImage.translatesAutoresizingMaskIntoConstraints = false
        
        // Initial constraints
        mountainImageTopConstraint = mountainImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 550)
        mountainImageCenterYConstraint = mountainImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 700)
        
        NSLayoutConstraint.activate([
            mountainImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -75),
            mountainImageCenterYConstraint
        ])
    }
    
    private func configureAppLogo() {
        view.addSubview(appLogoView)
        appLogoView.translatesAutoresizingMaskIntoConstraints = false
        
        // Initial constraints
        appLogoCenterYConstraint = appLogoView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        NSLayoutConstraint.activate([
            appLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appLogoCenterYConstraint,
            appLogoView.widthAnchor.constraint(equalToConstant: 238)
        ])
    }
    
    private func animateTransition() {
            // Animate the layout change
        NSAnimationContext.runAnimationGroup { context in
                    context.duration = 2.0
            context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                    
                    self.mountainImageCenterYConstraint.animator().constant = 0
                    self.appLogoCenterYConstraint.animator().constant = -115
                    
                    self.view.animator().layoutSubtreeIfNeeded()
                }
        }
    
    private func navigateToHome() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            /// After 3 seconds, replace this VC with HomeVC
            if self.userService?.getPreferences() == nil {
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
