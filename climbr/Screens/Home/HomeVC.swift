//
//  HomeVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import AppKit
import SnapKit
import Swinject

class HomeVC: NSViewController {
    
    let settingButton = CLImageButton(imageName: "gear", accesibilityName: "settings", imgColor: .black.withAlphaComponent(0.5), bgColor: NSColor.cContainerHome.cgColor.copy(alpha: 0.84)!)
    let audioButton = CLImageButton(imageName: "speaker.wave.3", accesibilityName: "Music Play", imgColor: .black.withAlphaComponent(0.5), bgColor: NSColor.cContainerHome.cgColor.copy(alpha: 0.84)!)
    let storeButton = CLImageButton(imageName: "storefront", accesibilityName: "store", imgColor: .black.withAlphaComponent(0.5), bgColor: NSColor.cContainerHome.cgColor.copy(alpha: 0.84)!)
    let startStretchButton = CLTextButtonV2(title: "Start Session", backgroundColor: .cButton
                                                    , foregroundColorText: .white, fontText: .systemFont(ofSize: 20, weight: .semibold))
    let textB = CLTextLabelV2(sizeOfFont: 20, weightOfFont: .bold, contentLabel: "Today’s session goal")
    let containerView = NSView()
    let imageHome = NSImageView()
    let stack = NSStackView()
    
    var audioService: AudioService?
    var isSoundTapped: Bool = false
    var textA = CLTextLabelV2(sizeOfFont: 18, weightOfFont: .semibold, contentLabel: "0 / 4 sessions")
    var progressStretch = NSProgressIndicator()
    @Published var progressValue: Double = 0.0
    
//    var progressService: ProgressService?
//    var settingVC: SettingVC?
    
    init(audioService: AudioService?) {
        super.init(nibName: nil, bundle: nil)
//        self.progressService = progressService
        self.audioService = audioService
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
        
    }
    
    override func viewDidAppear() {
        audioService?.playBackgroundMusic(fileName: "bgmusic")
        
        if UserDefaults.standard.bool(forKey: UserDefaultsKey.kFirstTime) == true {
            guard let choosCharVc = Container.shared.resolve(ChooseCharacterVC.self) else {return}
            push(to: choosCharVc)
        }
    }
    
    private func previewAnimaConfig(){
        view.addSubview(imageHome)
        imageHome.wantsLayer = true
        imageHome.image = NSImage(resource: .homebg)
        imageHome.imageScaling = .scaleProportionallyUpOrDown
        
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
        
        textA.stringValue = "\(Int(progressValue)) / 4 sessions"
        startStretchButton.isEnabled = UserDefaults.standard.bool(forKey: "isFirstTime") ? false : true
        
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
        
        textA.snp.makeConstraints { text in
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
        
        containerView.addSubview(textB)
        containerView.addSubview(progressStretch)
        containerView.addSubview(textA)
        containerView.addSubview(startStretchButton)
        
        containerView.wantsLayer = true
        containerView.layer?.backgroundColor = NSColor.cContainerHome.withAlphaComponent(0.72).cgColor
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
  
}
