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
    private let audioButton = CLImageButton(imageName: "speaker.wave.2", accesibilityName: "sound", imgColor: .white, bgColor: .black)
    private let storeButton = CLImageButton(imageName: "storefront", accesibilityName: "store", imgColor: .white, bgColor: .black)
    private let startStretchButton = CLTextButtonV2(title: "Start Session", backgroundColor: .black
                                                    , foregroundColorText: .white, fontText: .systemFont(ofSize: 20, weight: .bold))
    private let textA = NSTextField(string: "0 / 4 sessions")
    private let textB = NSTextField(string: "Today’s session goal")
    private let progressStretch = NSProgressIndicator()
    private let containerView = NSView()
    private let stackView = NSStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        ButtonConfigure()
        viewStretchConfig()
        
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
        storeButton.action = #selector(actionHome)
        storeButton.target = self
        
        let vPadding = view.bounds.height * 0.08
        let hPadding = view.bounds.width * 0.02
        let widthBtn = view.bounds.width * 0.08
        let heightBtn = view.bounds.height * 0.06
        
        settingButton.snp.makeConstraints { setting in
            setting.leading.equalToSuperview().inset(hPadding)
            setting.top.equalToSuperview().inset(vPadding)
            setting.width.equalTo(widthBtn)
            setting.height.equalTo(heightBtn)
        }
        
        audioButton.snp.makeConstraints { audio in
            audio.leading.equalTo(settingButton.snp.trailing).offset(hPadding)
            audio.top.equalTo(settingButton.snp.top)
            audio.width.equalTo(settingButton.snp.width)
            audio.height.equalTo(settingButton.snp.height)
        }
        
        storeButton.snp.makeConstraints { store in
            store.leading.equalTo(audioButton.snp.trailing).offset(hPadding)
            store.top.equalTo(settingButton.snp.top)
            store.width.equalTo(settingButton.snp.width)
            store.height.equalTo(settingButton.snp.height)
        }
    }
    
    private func stackConfig(){
        stackView.orientation = .horizontal
        stackView.distribution = .equalSpacing
        
        progressStretch.style = .bar
        progressStretch.wantsLayer = true
        
        progressStretch.minValue = 0
        progressStretch.maxValue = 4
        
        stackView.addArrangedSubview(progressStretch)
        stackView.addArrangedSubview(textA)
        
        textA.wantsLayer = false
        textA.isBordered = false
        textA.isEditable = false
        textA.isBezeled = false
        textA.backgroundColor = .clear
//        textA.layer?.borderColor = .black
        textA.textColor = .black
        textA.font = NSFont.boldSystemFont(ofSize: 10)
        
        
        progressStretch.wantsLayer = true
        progressStretch.minValue = 0
        progressStretch.maxValue = 4
        progressStretch.doubleValue = 0
        
        textA.snp.makeConstraints { text in
            text.trailing.equalTo(stackView.snp.trailing)
            text.width.equalTo(75)
            text.height.equalTo(20)
        }
        
        progressStretch.snp.makeConstraints { progress in
            progress.leading.equalTo(stackView.snp.leading)
            progress.width.equalTo(480)
            progress.height.equalTo(textA.snp.height)
        }
        
    }
    
    private func viewStretchConfig(){
        view.addSubview(containerView)
        
        containerView.addSubview(stackView)
        containerView.addSubview(startStretchButton)
        containerView.addSubview(textB)
        
        stackView.wantsLayer = true
        containerView.wantsLayer = true
        
        containerView.layer?.backgroundColor = CGColor.init(red: 246, green: 246, blue: 246, alpha: 84)
        containerView.layer?.opacity = 1
        containerView.layer?.cornerRadius = 20
        stackView.layer?.borderColor = .black
        
        stackConfig()
        
        textB.wantsLayer = true
        textB.isBordered = true
        textB.isEditable = false
        textB.isBezeled = false
        textB.backgroundColor = .clear
        textB.textColor = .black
        textB.font = NSFont.boldSystemFont(ofSize: 13)
        
        startStretchButton.action = #selector(actionStartSession)
        startStretchButton.target = self
        
        containerView.snp.makeConstraints { container in
            container.trailing.equalToSuperview().inset(20)
            container.top.equalTo(settingButton.snp.top)
            container.width.equalTo(435)
            container.height.equalTo(137)
        }
        
        stackView.snp.makeConstraints { stack in
            stack.leading.equalTo(containerView.snp.leading).inset(20)
            stack.trailing.equalTo(containerView.snp.trailing).inset(20)
            stack.height.equalTo(19.44)
        }
        
        startStretchButton.snp.makeConstraints { btn in
            btn.leading.equalTo(stackView.snp.leading)
            btn.trailing.equalTo(stackView.snp.trailing)
            btn.top.equalTo(stackView.snp.bottom).offset(11)
            btn.bottom.equalTo(containerView.snp.bottom).inset(18)
            btn.height.equalTo(49.57)
            btn.width.equalTo(stackView.snp.width)
        }
        
        textB.snp.makeConstraints { title in
            title.top.equalTo(containerView.snp.top).inset(18)
            title.leading.equalTo(stackView.snp.leading)
            title.bottom.equalTo(stackView.snp.top)
        }
    }
    
    @objc
    private func actionSetting(){
        let settingsVC = SettingsView()
        settingsVC.title = "Settings Preference"
        settingsVC.preferredContentSize = CGSize(width: 412, height: 358)
        self.presentAsModalWindow(settingsVC)
    }

    @objc
    private func actionAudio(){
        print("hallo audio")
    }

    @objc
    private func actionHome(){
        print("hallo home")
    }

    @objc
    private func actionStartSession(){
        print("hallo start session")
    }
    
}

#Preview(traits: .defaultLayout, body: {
    HomeVC()
})
