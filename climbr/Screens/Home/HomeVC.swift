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
    
    var audioService: AudioService?
    var charService: CharacterService?
    var equipmentService: EquipmentService?
    var isSoundTapped: Bool = false
    var progressText = CLTextLabelV2(sizeOfFont: 18, weightOfFont: .semibold, contentLabel: "")
    var progressStretch = NSProgressIndicator()
    var bagss: Set<AnyCancellable> = []
    
    @Published var progressValue: Double = UserDefaults.standard.double(forKey: UserDefaultsKey.kProgressSession)
    
    
    init(audioService: AudioService?, charService: CharacterService?, equipmentService: EquipmentService?) {
        super.init(nibName: nil, bundle: nil)
        self.audioService = audioService
        self.charService = charService
        self.equipmentService = equipmentService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        previewAnimaConfig()
        ButtonConfigure()
        viewStretchConfig()
        dailyProgress()
        setupPointsLabel()
        
        NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)
            .sink { [weak self] _ in
                guard let self = self else {return}
                
                DispatchQueue.main.async {
                    self.updateProgressData()
                }
            }
            .store(in: &bagss)
    }
    
    override func viewDidAppear() {
        let audio = Container.shared.resolve(AudioService.self)
        audio?.playBackgroundMusic(fileName: "summer")
        observeTimer()
        if charService?.getCharacterData() == nil {
            guard let choosCharVc = Container.shared.resolve(ChooseCharacterVC.self) else {return}
            push(to: choosCharVc)
            
            /// Store all equipments data to coredata
            equipmentService?.seedDatabase()
            
        }
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        $progressValue.sink { progress in
            
            self.progressText.stringValue = "\(Int(progress)) / 4 sessions"
            
        }.store(in: &bagss)
    }
    
    private func previewAnimaConfig(){
        view.addSubview(imageHome)
        imageHome.wantsLayer = true
        imageHome.image = NSImage(resource: .homebg)
        imageHome.imageScaling = .scaleAxesIndependently
        
        imageHome.snp.makeConstraints { anime in
            anime.top.leading.trailing.bottom.equalToSuperview()
            anime.centerX.centerY.equalToSuperview()
            anime.width.equalTo(view.snp.width)
            anime.height.equalTo(view.snp.height)
        }
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
        
        //MARK: Audio Button Action
        audioButton.action = #selector(actionAudio)
        audioButton.target = self
        
        //MARK: Store Button Action
        storeButton.action = #selector(actionStore)
        storeButton.target = self
        
        let vPadding = view.bounds.height * 0.08
        let hPadding = view.bounds.width * 0.02
        let widthBtn = view.bounds.width * 0.3
        let heightBtn = view.bounds.height * 0.08
        
        stack.snp.makeConstraints { stack in
            stack.leading.equalToSuperview().offset(hPadding)
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
        
        let padding = view.bounds.height * 0.04
        let minPadding = view.bounds.height * 0.02
        
        containerView.snp.makeConstraints { container in
            container.trailing.equalToSuperview().inset(padding)
            container.top.equalTo(settingButton.snp.top)
            container.width.equalTo(435)
            container.height.equalTo(135)
        }
        
        textB.snp.makeConstraints { title in
            title.top.equalTo(containerView.snp.top).offset(padding)
            title.leading.equalTo(containerView.snp.leading).offset(padding)
            title.trailing.equalTo(containerView.snp.trailing).offset(padding)
        }
        
        progressStretch.snp.makeConstraints { progress in
            progress.top.equalTo(textB.snp.bottom).offset(minPadding)
            progress.leading.equalTo(textB.snp.leading)
            progress.height.equalTo(4)
        }
        
        progressText.snp.makeConstraints { text in
            text.top.equalTo(textB.snp.bottom).offset(minPadding - (view.bounds.height * 0.02))
            text.leading.equalTo(progressStretch.snp.trailing).offset(minPadding)
            text.trailing.equalTo(containerView.snp.trailing).inset(padding)
        }
        
        startStretchButton.snp.makeConstraints { btn in
            btn.top.equalTo(progressStretch.snp.bottom).offset(padding)
            btn.leading.equalTo(containerView.snp.leading).inset(padding)
            btn.trailing.equalTo(containerView.snp.trailing).inset(padding)
            btn.bottom.equalTo(containerView.snp.bottom).inset(padding)
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
        
        view.addSubview(pointsView)
        
        let hPadding = view.bounds.width * 0.02
        
        NSLayoutConstraint.activate([
            pointsView.leadingAnchor.constraint(equalTo: storeButton.trailingAnchor, constant: hPadding),
            pointsView.topAnchor.constraint(equalTo: storeButton.topAnchor),
            pointsView.widthAnchor.constraint(equalToConstant: 160),
            pointsView.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
}
