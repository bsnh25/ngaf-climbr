//
//  HomeVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import AppKit
import SnapKit

class HomeVC: NSViewController {
    
    private let settingButton = CLImageButton(imageName: "gear", accesibilityName: "settings", imgColor: .white, bgColor: .black)
    private let audioButton = CLImageButton(imageName: "speaker.wave.3", accesibilityName: "Music Play", imgColor: .white, bgColor: .black)
    private let storeButton = CLImageButton(imageName: "storefront", accesibilityName: "store", imgColor: .white, bgColor: .black)
    private let startStretchButton = CLTextButtonV2(title: "Start Session", backgroundColor: .cButton
                                                    , foregroundColorText: .white, fontText: .systemFont(ofSize: 20, weight: .semibold))
    private let textA = CLTextLabelV2(sizeOfFont: 10, weightOfFont: .semibold, contentLabel: "0 / 4 sessions")
    private let textB = CLTextLabelV2(sizeOfFont: 13, weightOfFont: .bold, contentLabel: "Today’s session goal")
    private let progressStretch = NSProgressIndicator()
    private let containerView = NSView()
    private let previewAnimation = NSView()
    private var isSoundTapped: Bool = false
    
    var audioService: AudioService?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        previewAnimaConfig()
        ButtonConfigure()
        viewStretchConfig()
    }
    
    override func viewDidAppear() {
        audioService?.playBackgroundMusic(fileName: "bgmusic")
    }
    
    private func previewAnimaConfig(){
        view.addSubview(previewAnimation)
        previewAnimation.wantsLayer                = true
        previewAnimation.layer?.backgroundColor    = NSColor.red.cgColor.copy(alpha: 0.5)
        
        previewAnimation.snp.makeConstraints { anime in
            anime.top.leading.trailing.bottom.equalToSuperview()
            anime.centerX.centerY.equalToSuperview()
        }
    }
    
    private func ButtonConfigure(){
        view.addSubview(settingButton)
        view.addSubview(audioButton)
        view.addSubview(storeButton)
        
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
        let widthBtn = view.bounds.width * 0.08
        
        settingButton.snp.makeConstraints { setting in
            setting.leading.equalToSuperview().offset(hPadding)
            setting.top.equalToSuperview().offset(vPadding)
            setting.width.equalTo(widthBtn)
            setting.height.equalTo(widthBtn)
        }
        
        audioButton.snp.makeConstraints { audio in
            audio.leading.equalTo(settingButton.snp.trailing).offset(hPadding)
            audio.top.equalToSuperview().offset(vPadding)
            audio.width.equalTo(widthBtn)
            audio.height.equalTo(widthBtn)
        }
        
        storeButton.snp.makeConstraints { store in
            store.leading.equalTo(audioButton.snp.trailing).offset(hPadding)
            store.top.equalToSuperview().offset(vPadding)
            store.width.equalTo(widthBtn)
            store.height.equalTo(widthBtn)
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
        
        textA.snp.makeConstraints { text in
            text.top.equalTo(textB.snp.bottom).offset(minPadding - (view.bounds.height * 0.01))
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
        containerView.layer?.backgroundColor = NSColor.gray.cgColor
        containerView.layer?.opacity = 1
        containerView.layer?.cornerRadius = 20
        
        progressStretch.wantsLayer = true
        progressStretch.isIndeterminate = false
        progressStretch.isDisplayedWhenStopped = true
        progressStretch.layer?.masksToBounds = true
        progressStretch.style = .bar
        progressStretch.minValue = 0
        progressStretch.maxValue = 100
        progressStretch.doubleValue = 50
        progressStretch.layer?.backgroundColor = NSColor.darkGray.cgColor
        progressStretch.layer?.cornerRadius = 5
        progressStretch.displayIfNeeded()
//        print("Progress value set to: \(progressStretch.doubleValue)")

        startStretchButton.action = #selector(actionStartSession)
        startStretchButton.target = self
        
        stackConfig()
    }
    
    @objc
    private func actionSetting(){
        let settingsVC = SettingVC()
        settingsVC.preferredContentSize = CGSize(width: 412, height: 358)
        self.presentAsModalWindow(settingsVC)
    }

    @objc
    private func actionAudio(){
        guard let audio = audioService else {return}
        isSoundTapped.toggle()
        if isSoundTapped{
            audio.muteSound()
            audioButton.image = NSImage(systemSymbolName: "speaker.slash", accessibilityDescription: "Music Muted")
            return
        } else {
            audio.unmuteSound()
            audioButton.image = NSImage(systemSymbolName: "speaker.wave.2", accessibilityDescription: "Music Muted")
            return
        }
    }

    @objc
    private func actionStore(){
        print("go to shop")
    }

    @objc
    private func actionStartSession(){
        push(to: StretchingVC())
        print("go to stretching session")
    }
    
}

#Preview(traits: .defaultLayout, body: {
    HomeVC()
})
