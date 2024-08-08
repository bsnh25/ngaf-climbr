//
//  HomeVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import AppKit
import SnapKit

class HomeVC: NSViewController {
    
    let settingButton = CLImageButton(imageName: "gear", accesibilityName: "settings", imgColor: .black, bgColor: .blue)
    let audioButton = CLImageButton(imageName: "speaker.wave.2", accesibilityName: "sound", imgColor: .black, bgColor: .blue)
    let storeButton = CLImageButton(imageName: "storefront", accesibilityName: "store", imgColor: .black, bgColor: .blue)


    let btnLabel = CLTextButton(titleBtn: "Hallo Dunia", labelColor: .black, bgColor: .white)
    
//    let btnLabel = NSButton(title: "Hallo dunia", target: self, action: #selector(actionAudio))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
//        ButtonConfigure()
        btnLabelConfig()
    }
    
    func ButtonConfigure(){
        view.addSubview(settingButton)
        view.addSubview(audioButton)
        view.addSubview(storeButton)
        
        //MARK: Settings Button Action & target
        settingButton.action = #selector(actionSetting)
        
        //MARK: Audio Button Action & target
        audioButton.action = #selector(actionAudio)

        //MARK: Store Button Action & target
        storeButton.action = #selector(actionHome)
        
        
        settingButton.snp.makeConstraints { setting in
            setting.centerX.centerY.equalToSuperview()
            setting.height.width.equalTo(25)
        }
        
        audioButton.snp.makeConstraints { audio in
            audio.centerX.centerY.equalToSuperview()
            audio.height.width.equalTo(25)
        }

        storeButton.snp.makeConstraints { store in
            store.centerX.centerY.equalToSuperview()
            store.height.width.equalTo(25)
        }
    }
    
    private func btnLabelConfig(){
        view.addSubview(btnLabel)
        
        btnLabel.controlSize = .large
        
        btnLabel.snp.makeConstraints { lab in
            lab.centerX.centerY.equalToSuperview()
        }
    }
    
    @objc
    private func actionSetting(){
        print("hallo")
    }

    @objc
    private func actionAudio(){
        print("hallo")
    }

    @objc
    private func actionHome(){
        print("hallo")
    }
    
}

#Preview(traits: .defaultLayout, body: {
    HomeVC()
})
