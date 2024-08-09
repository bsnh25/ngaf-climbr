//
//  HomeVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import AppKit
import SnapKit




class HomeVC: NSViewController {
    
    let settingButton = CLImageButton(imageName: "gear", accesibilityName: "settings", imgColor: .white, bgColor: .black)
    let audioButton = CLImageButton(imageName: "speaker.wave.2", accesibilityName: "sound", imgColor: .white, bgColor: .black)
    let storeButton = CLImageButton(imageName: "storefront", accesibilityName: "store", imgColor: .white, bgColor: .black)
    let startStretchButton = CLTextButton(titleBtn: "Start Session", labelColor: .white, bgColor: .black)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        ButtonConfigure()
        startBtnLabelConfig()
    }
    
    private func ButtonConfigure(){
        view.addSubview(settingButton)
        view.addSubview(audioButton)
        view.addSubview(storeButton)
        
        //MARK: Settings Button Action
        settingButton.action = #selector(actionSetting)
        settingButton.symbolConfiguration = NSImage.SymbolConfiguration(scale: .large)
        
        //MARK: Audio Button Action
        audioButton.action = #selector(actionAudio)
        audioButton.symbolConfiguration = NSImage.SymbolConfiguration(scale: .large)

        //MARK: Store Button Action
        storeButton.action = #selector(actionHome)
        storeButton.symbolConfiguration = NSImage.SymbolConfiguration(scale: .large)
        
        let vPadding = view.bounds.height * 0.08
        let hPadding = view.bounds.width * 0.02
        
        settingButton.snp.makeConstraints { setting in
            setting.leading.equalToSuperview().inset(hPadding)
            setting.top.equalToSuperview().inset(vPadding)
            setting.height.width.equalTo(45)
        }
        
        audioButton.snp.makeConstraints { audio in
            audio.leading.equalTo(settingButton.snp.trailing).offset(hPadding)
            audio.top.equalTo(settingButton.snp.top)
            audio.height.width.equalTo(45)
        }

        storeButton.snp.makeConstraints { store in
            store.leading.equalTo(audioButton.snp.trailing).offset(hPadding)
            store.top.equalTo(audioButton.snp.top)
            store.height.width.equalTo(45)
        }
    }
    
    private func startBtnLabelConfig(){
        view.addSubview(startStretchButton)
        
        //MARK: Start Session Button Action
        startStretchButton.action = #selector(actionStartSession)
        
        let padding = view.bounds.width * 0.02
        
        startStretchButton.snp.makeConstraints { start in
            start.trailing.equalToSuperview().inset(padding)
            start.bottom.equalToSuperview().inset(padding)
            start.height.equalTo(52)
            start.width.equalTo(400)
        }
    }
    
    private func progressConfig(){
        
    }
    
    @objc
    private func actionSetting(){
        print("hallo setting")
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
