//
//  HomeVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import AppKit
import SnapKit
import Swinject
import Combine
import RiveRuntime

class HomeVC: NSViewController {
    
    let settingButton = CLImageButton(
        imageName: "gear",
        accesibilityName: "settings",
        imgColor: .black.withAlphaComponent(0.5),
        bgColor: NSColor.cContainerHome.cgColor.copy(alpha: 0.84)!
    )
    
    let audioButton = CLImageButton(
        imageName: "speaker.wave.3",
        accesibilityName: "Music Play",
        imgColor: .black.withAlphaComponent(0.5),
        bgColor: NSColor.cContainerHome.cgColor.copy(alpha: 0.84)!
    )
    
    let storeButton = CLImageButton(
        imageName: "storefront",
        accesibilityName: "store",
        imgColor: .black.withAlphaComponent(0.5),
        bgColor: NSColor.cContainerHome.cgColor.copy(alpha: 0.84)!
    )
    
    let startStretchButton = CLTextButtonV2(
        title: "Start Session",
        backgroundColor: .cButton,
        foregroundColorText: .white,
        fontText: .systemFont(ofSize: 20, weight: .semibold)
    )
    
    let textB = CLTextLabelV2(
        sizeOfFont: 20,
        weightOfFont: .bold,
        contentLabel: "Today’s session goal"
    )
    let points  = CLLabel(
        fontSize: 18.79,
        fontWeight: .bold
    )
    let containerView = NSView()
    let imageHome = NSImageView()
    let stack = NSStackView()
    let pointsView = NSStackView()
    
    var riveView = RiveView()
    var audioService: AudioService?
    var charService: CharacterService?
    var equipmentService: EquipmentService?
    var isSoundTapped: Bool = false
    var progressText = CLTextLabelV2(sizeOfFont: 18, weightOfFont: .semibold, contentLabel: "")
    var progressStretch = NSProgressIndicator()
    var bagss: Set<AnyCancellable> = []
    var arrNotif: [String] = []
    var character: CharacterModel?
    
    var animationMain : RiveViewModel? = {
        var anima: RiveViewModel = RiveViewModel(fileName: "climbr")
        anima.fit = .fill
        return anima
    }()
    
    @Published var progressValue: Double = UserDefaults.standard.double(forKey: UserDefaultsKey.kProgressSession)
    var notificationServ : NotificationService?
    
    init(audioService: AudioService?, charService: CharacterService?, equipmentService: EquipmentService?, notif: NotificationService? ) {
        super.init(nibName: nil, bundle: nil)
        self.audioService = audioService
        self.charService = charService
        self.equipmentService = equipmentService
        self.notificationServ = notif
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        print("viewWillAppear")
        reloadAnimation()
        self.character = self.charService?.getCharacterData()
        
        if let character {
            /// Configure rive artboard
            do {
                try animationMain?.configureModel(artboardName: character.gender == .male ? "HomescreenMale" : "HomescreenFemale")
            } catch {
                print(error.localizedDescription)
            }
        }
        self.updateCharacter()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.wantsLayer = true
//        previewAnimaConfig()
        ButtonConfigure()
        viewStretchConfig()
        dailyProgress()
        setupPointsLabel()
        
        NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)
            .sink { [weak self] _ in
                guard let self = self else {return}
                
                DispatchQueue.main.async {
                    self.updateProgressData()
                    self.observeNotif()
                }
            }
            .store(in: &bagss)
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        print("viewDidAppear")
        
        let audio = Container.shared.resolve(AudioService.self)
        audio?.playBackgroundMusic(fileName: "summer")
        observeTimer()
    
        print("Rive Home Status: \(String(describing: animationMain?.isPlaying))")
        
        guard let character else {
            guard let choosCharVc = Container.shared.resolve(ChooseCharacterVC.self) else {return}
            push(to: choosCharVc)
            choosCharVc.genderDelegate = self
            /// Store all equipments data to coredata
            equipmentService?.seedDatabase()
            
            return
        }
    }
    
    private func previewAnimaConfig(){
        guard let animation = animationMain else {return}
        animation.fit = .fill
        riveView = animation.createRiveView()
        view.addSubview(riveView)
        riveView.wantsLayer = true
//        riveView.layer?.zPosition = -10
//        riveView.layer?.backgroundColor = .black
        
        riveView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            riveView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            riveView.topAnchor.constraint(equalTo: view.topAnchor),
            riveView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            riveView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func ButtonConfigure(){
        
        view.addSubview(stack)
        
        stack.wantsLayer = true
        stack.setViews([settingButton, audioButton, storeButton], in: .center)
        stack.orientation = .horizontal
        stack.spacing = 10
        
        //MARK: Settings Button Action
        settingButton.action = #selector(actionSetting)
        settingButton.target = self
        settingButton.setAccessibilityElement(true)
        settingButton.setAccessibilityTitle("Settings")
        settingButton.setAccessibilityLabel("Adjust your preferences, manage work hours and launch at login")
        settingButton.setAccessibilityRole(.button)
        
        //MARK: Audio Button Action
        audioButton.action = #selector(actionAudio)
        audioButton.target = self
        audioButton.setAccessibilityElement(true)
        audioButton.setAccessibilityTitle("Background Music")
        audioButton.setAccessibilityLabel("Mute or unmute the background music")
        audioButton.setAccessibilityRole(.button)
        
        //MARK: Store Button Action
        storeButton.action = #selector(actionStore)
        storeButton.target = self
        storeButton.setAccessibilityElement(true)
        storeButton.setAccessibilityTitle("Shop")
        storeButton.setAccessibilityLabel("Discovers unique climbing gears, customize your character")
        storeButton.setAccessibilityRole(.button)
        
        let vPadding = 40
        let hPadding = 10
        let widthBtn = 250
        let heightBtn = 40
        
        stack.snp.makeConstraints { stack in
            stack.leading.equalToSuperview().offset(20)
            stack.top.equalToSuperview().offset(vPadding)
            stack.width.equalTo(widthBtn)
            stack.height.equalTo(heightBtn)
        }
        
        settingButton.snp.makeConstraints { setting in
            setting.leading.equalTo(stack.snp.leading)
            setting.top.equalTo(stack.snp.top)
            setting.width.equalTo(38)
            setting.height.equalTo(38)
        }
        
        audioButton.snp.makeConstraints { audio in
            audio.leading.equalTo(settingButton.snp.trailing).offset(hPadding)
            audio.top.equalTo(stack.snp.top)
            audio.width.equalTo(38)
            audio.height.equalTo(38)
        }
        
        storeButton.snp.makeConstraints { store in
            store.leading.equalTo(audioButton.snp.trailing).offset(hPadding)
            store.top.equalTo(stack.snp.top)
            store.width.equalTo(38)
            store.height.equalTo(38)
        }
    }
    
    private func stackConfig(){
        
        containerView.snp.makeConstraints { container in
            container.trailing.equalToSuperview().inset(20)
            container.top.equalTo(settingButton.snp.top)
            container.width.equalTo(435)
            container.height.equalTo(135)
        }
        
        textB.snp.makeConstraints { title in
            title.top.equalTo(containerView.snp.top).offset(15)
            title.leading.equalTo(containerView.snp.leading).offset(20)
            title.trailing.equalTo(containerView.snp.trailing).offset(20)
        }
        
        progressStretch.snp.makeConstraints { progress in
            progress.top.equalTo(textB.snp.bottom).offset(20)
            progress.leading.equalTo(textB.snp.leading)
            progress.height.equalTo(5)
        }
        
        progressText.snp.makeConstraints { text in
            text.top.equalTo(textB.snp.bottom).offset(10)
            text.leading.equalTo(progressStretch.snp.trailing).offset(20)
            text.trailing.equalTo(containerView.snp.trailing).inset(20)
        }
        
        startStretchButton.snp.makeConstraints { btn in
            btn.top.equalTo(progressStretch.snp.bottom).offset(20)
            btn.leading.equalTo(containerView.snp.leading).inset(20)
            btn.trailing.equalTo(containerView.snp.trailing).inset(20)
            btn.bottom.equalTo(containerView.snp.bottom).inset(15)
        }
        
    }
    
    private func viewStretchConfig(){
        view.addSubview(containerView)
        
        let blurEffect = CLBlurEffectView(frame: containerView.bounds)
        
        containerView.addSubview(textB)
        containerView.addSubview(progressStretch)
        containerView.addSubview(progressText)
        containerView.addSubview(startStretchButton)
        containerView.addSubview(blurEffect, positioned: .below, relativeTo: nil)
        
        containerView.wantsLayer = true
        containerView.layer?.backgroundColor = .white.copy(alpha: 0.72)
        containerView.layer?.opacity = 1
        containerView.layer?.cornerRadius = 20
        
        progressStretch.wantsLayer = true
        progressStretch.isIndeterminate = false
        progressStretch.isDisplayedWhenStopped = true
        progressStretch.layer?.masksToBounds = true
        progressStretch.style = .bar
        progressStretch.layer?.backgroundColor = NSColor.black.cgColor.copy(alpha: 0.12)
        progressStretch.layer?.cornerRadius = 5
        progressStretch.displayIfNeeded()
        
        startStretchButton.action = #selector(actionStartSession)
        startStretchButton.target = self
        startStretchButton.setAccessibilityElement(true)
        startStretchButton.setAccessibilityTitle("Start Session")
        startStretchButton.setAccessibilityLabel("Opens a guided stretching page")
        startStretchButton.setAccessibilityRole(.button)
        
        stackConfig()
    }
    
    func setupPointsLabel() {
        
        let icon = CLSFSymbol(symbolName: "c.circle", description: "coins")
        icon.setConfiguration(size: 18.79, weight: .bold)
        icon.contentTintColor = .black
        
        points.backgroundColor = .clear
        points.setTextColor(.black)
        
        pointsView.wantsLayer = true
        
        pointsView.setViews([icon, points], in: .center)
        pointsView.translatesAutoresizingMaskIntoConstraints = false
        pointsView.orientation = .horizontal
        pointsView.alignment = .centerY
        pointsView.distribution = .equalSpacing
        pointsView.layer?.backgroundColor = .white.copy(alpha: 0.7)
        pointsView.layer?.cornerRadius = 10
        pointsView.edgeInsets = NSEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
      
        pointsView.setAccessibilityTitle("Coins")
        pointsView.setAccessibilityLabel("View your balance")
        pointsView.setAccessibilityRole(.button)
        
        view.addSubview(pointsView)
        
        let blur = CLBlurEffectView(frame: pointsView.bounds)
        pointsView.addSubview(blur, positioned: .below, relativeTo: nil)
        
        NSLayoutConstraint.activate([
            pointsView.leadingAnchor.constraint(equalTo: storeButton.trailingAnchor, constant: 10),
            pointsView.topAnchor.constraint(equalTo: storeButton.topAnchor),
            pointsView.widthAnchor.constraint(equalToConstant: 160),
            pointsView.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    private func reloadAnimation() {
        riveView.removeFromSuperview()
        stack.removeFromSuperview()
        containerView.removeFromSuperview()
        pointsView.removeFromSuperview()
        previewAnimaConfig()
        ButtonConfigure()
        viewStretchConfig()
        dailyProgress()
        setupPointsLabel()
    }
}
