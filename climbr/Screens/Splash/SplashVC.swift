//
//  SplashVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 13/08/24.
//

import Cocoa
import Swinject
import RiveRuntime

class SplashVC: NSViewController {
  
  //    let appLogoView = NSImageView(image: .appLogoWhite)
  //    let mountainImage = NSImageView(image: .onboardingmountain)
  var charService: CharacterService = UserManager.shared
  //    var mountainImageTopConstraint: NSLayoutConstraint!
  //    var mountainImageCenterYConstraint: NSLayoutConstraint!
  //    var mountainImageCenterXConstraint: NSLayoutConstraint!
  //    var appLogoCenterYConstraint: NSLayoutConstraint!
  //    var appLogoCenterXConstraint: NSLayoutConstraint!
  
  private lazy var animationMain : RiveViewModel = {
    var anima: RiveViewModel = RiveViewModel(fileName: "splash_screen")
    anima.fit = .cover
    
    return anima
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.wantsLayer = true
    //        view.layer?.backgroundColor = NSColor.onboardingBackground.cgColor
    configureMountainImage()
    //        configureAppLogo()
    //        if self.charService.getPreferences() == nil {
    //            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    //                self.animateTransition()
    //            }
    //        } else {
    //            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    //                self.animateTransition1()
    //            }
    //        }
    navigateToHome()
  }
  
  override func viewWillAppear() {
    super.viewWillAppear()
    
    guard let character = charService.getCharacterData() else {
      return
    }
    
    do {
      let artboardName: String = character.locationEquipment == .jungleJumble ? "jungle" : "snowy"
      try animationMain.configureModel(artboardName: artboardName)
      
      
      // Set background input to 2 (for Home)
      animationMain.setInput("background", value: Double(2))
    } catch {
      print("Error: ", error.localizedDescription)
    }
  }
  
  private func configureMountainImage() {
    
    let riveView = animationMain.createRiveView()
    
    view.addSubview(riveView)
    
    riveView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    //        mountainImage.translatesAutoresizingMaskIntoConstraints = false
    //
    //        // Initial constraints
    //        mountainImageTopConstraint = mountainImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 550)
    //        mountainImageCenterYConstraint = mountainImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 700)
    //        mountainImageCenterXConstraint = mountainImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -75)
    //
    //        NSLayoutConstraint.activate([
    //            mountainImageCenterXConstraint,
    //            mountainImageCenterYConstraint
    //        ])
  }
  
  //    private func configureAppLogo() {
  //        view.addSubview(appLogoView)
  //        appLogoView.translatesAutoresizingMaskIntoConstraints = false
  //
  //        // Initial constraints
  //        appLogoCenterYConstraint = appLogoView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
  //        appLogoCenterXConstraint = appLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
  //
  //        NSLayoutConstraint.activate([
  //            appLogoCenterXConstraint,
  //            appLogoCenterYConstraint,
  //            appLogoView.widthAnchor.constraint(equalToConstant: 238)
  //        ])
  //    }
  //
  //    private func animateTransition() {
  //            // Animate the layout change
  //        NSAnimationContext.runAnimationGroup { context in
  //                    context.duration = 2.0
  //            context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
  //
  //                    self.mountainImageCenterYConstraint.animator().constant = 0
  //                    self.appLogoCenterXConstraint.animator().constant = -334
  //
  //                    self.view.animator().layoutSubtreeIfNeeded()
  //                }
  //        }
  //
  //    private func animateTransition1() {
  //            // Animate the layout change
  //        NSAnimationContext.runAnimationGroup { context in
  //                    context.duration = 2.0
  //            context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
  //
  //                    self.mountainImageCenterYConstraint.animator().constant = 0
  //                    self.appLogoCenterXConstraint.animator().constant = -334
  //
  //                    self.view.animator().layoutSubtreeIfNeeded()
  //                }
  //        }
  
  private func navigateToHome() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
      guard let self else { return }
      
      /// After 3 seconds, replace this VC with HomeVC
      if self.charService.getPreferences() == nil {
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
