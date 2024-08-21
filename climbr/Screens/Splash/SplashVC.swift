//
//  SplashVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 13/08/24.
//

import Cocoa
import Swinject

class SplashVC: NSViewController {
    
    let appLogoView = NSImageView(image: .appLogoWhite)
    let mountainImage = NSImageView(image: .onboardingmountain)
    var charService: CharacterService?
    var mountainImageTopConstraint: NSLayoutConstraint!
    var mountainImageCenterYConstraint: NSLayoutConstraint!
    var mountainImageCenterXConstraint: NSLayoutConstraint!
    var appLogoCenterYConstraint: NSLayoutConstraint!
    var appLogoCenterXConstraint: NSLayoutConstraint!
    
    init(charService: CharacterService?){
        super.init(nibName: nil, bundle: nil)
        self.charService = charService
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
        if self.charService?.getPreferences() == nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.animateTransition()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.animateTransition1()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.animateTransition2()
            }
        }
        navigateToHome()
    }
    
    private func configureMountainImage() {
        view.addSubview(mountainImage)
        mountainImage.translatesAutoresizingMaskIntoConstraints = false
        
        // Initial constraints
        mountainImageTopConstraint = mountainImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 550)
        mountainImageCenterYConstraint = mountainImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 700)
        mountainImageCenterXConstraint = mountainImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -75)
        
        NSLayoutConstraint.activate([
            mountainImageCenterXConstraint,
            mountainImageCenterYConstraint
        ])
    }
    
    private func configureAppLogo() {
        view.addSubview(appLogoView)
        appLogoView.translatesAutoresizingMaskIntoConstraints = false
        
        // Initial constraints
        appLogoCenterYConstraint = appLogoView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        appLogoCenterXConstraint = appLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        NSLayoutConstraint.activate([
            appLogoCenterXConstraint,
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
    
    private func animateTransition1() {
            // Animate the layout change
        NSAnimationContext.runAnimationGroup { context in
                    context.duration = 1.0
            context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                    
                    self.mountainImageCenterYConstraint.animator().constant = 0
                    self.appLogoCenterYConstraint.animator().constant = -115
                    
                    self.view.animator().layoutSubtreeIfNeeded()
                }
        }
    
    private func animateTransition2() {
            // Animate the layout change
        NSAnimationContext.runAnimationGroup { context in
                    context.duration = 1.0
            context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                    
                    self.appLogoCenterYConstraint.animator().constant = -840
                    self.mountainImageCenterYConstraint.animator().constant = -1000
                    
                    self.view.animator().layoutSubtreeIfNeeded()
                }
        }
    
    private func navigateToHome() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            /// After 3 seconds, replace this VC with HomeVC
            if self.charService?.getPreferences() == nil {
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
