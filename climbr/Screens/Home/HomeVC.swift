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
    let startStretchButton = CLTextButton(titleBtn: "Start Session", labelColor: .white, bgColor: .black, sizeFont: 20)
    let textA = NSTextField(string: "0 / 4 sessions")
    let textB = NSTextField(string: "Today’s session goal")
    let progressStretch = NSProgressIndicator()
    let containerView = NSView()
    let stackView = NSStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        ButtonConfigure()
//        startBtnLabelConfig()
        viewStretchConfig()
        
    }
    
    private func ButtonConfigure(){
        view.addSubview(settingButton)
        view.addSubview(audioButton)
        view.addSubview(storeButton)
        
        //MARK: Settings Button Action
        settingButton.action = #selector(actionSetting)
        settingButton.target = self
        settingButton.symbolConfiguration = NSImage.SymbolConfiguration(scale: .large)
        
        //MARK: Audio Button Action
        audioButton.action = #selector(actionAudio)
        audioButton.target = self
        audioButton.symbolConfiguration = NSImage.SymbolConfiguration(scale: .large)
        
        //MARK: Store Button Action
        storeButton.action = #selector(actionHome)
        storeButton.target = self
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
    
    private func stackConfig(){
        stackView.orientation = .horizontal
        stackView.distribution = .equalSpacing
        
        progressStretch.style = .bar
        progressStretch.wantsLayer = true
        
        progressStretch.minValue = 0
        progressStretch.maxValue = 4
        
        stackView.addArrangedSubview(progressStretch)
        stackView.addArrangedSubview(textA)
        
        textA.wantsLayer = true
        textA.isBordered = true
        textA.isEditable = false
        textA.isBezeled = false
        textA.backgroundColor = .clear
        textA.textColor = .black
        textA.font = NSFont.boldSystemFont(ofSize: 14)
        
        
        progressStretch.wantsLayer = true
        progressStretch.minValue = 0
        progressStretch.maxValue = 4
        progressStretch.doubleValue = 0
        
        textA.snp.makeConstraints { text in
            text.trailing.equalTo(stackView.snp.trailing)
//            text.bottom.equalTo(startStretchButton.snp.top)
            text.width.equalTo(100)
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
        textB.font = NSFont.boldSystemFont(ofSize: 19)
        
        startStretchButton.action = #selector(actionStartSession)
        startStretchButton.target = self
        
        containerView.snp.makeConstraints { container in
            container.trailing.equalToSuperview().inset(20)
            container.top.equalTo(settingButton.snp.top)
            container.width.equalTo(632)
            container.height.equalTo(200)
        }
        
        stackView.snp.makeConstraints { stack in
            stack.leading.equalTo(containerView.snp.leading).inset(20)
            stack.trailing.equalTo(containerView.snp.trailing).inset(20)
            stack.height.equalTo(30)
        }
        
        startStretchButton.snp.makeConstraints { btn in
            btn.leading.equalTo(stackView.snp.leading)
            btn.trailing.equalTo(stackView.snp.trailing)
            btn.top.equalTo(stackView.snp.bottom).offset(16)
            btn.bottom.equalTo(containerView.snp.bottom).inset(20)
            btn.height.equalTo(72)
            btn.width.equalTo(stackView.snp.width)
        }
        
        textB.snp.makeConstraints { title in
            title.top.equalTo(containerView.snp.top).inset(20)
            title.leading.equalTo(stackView.snp.leading)
            title.bottom.equalTo(stackView.snp.top)
        }
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


//private func startBtnLabelConfig(){
//    view.addSubview(startStretchButton)
//    view.addSubview(progressStretch)
//    
//    //MARK: Start Session Button Action
//    progressStretch.style = .bar
//    progressStretch.wantsLayer = true
//    
//    progressStretch.minValue = 0
//    progressStretch.maxValue = 4
//    
//
//    
//    let padding = view.bounds.width * 0.02
//    
//    startStretchButton.snp.makeConstraints { start in
//        start.trailing.equalToSuperview().inset(padding)
//        start.bottom.equalToSuperview().inset(padding)
//        start.height.equalTo(52)
//        start.width.equalTo(400)
//    }
//
//    progressStretch.snp.makeConstraints { make in
//        make.centerX.centerY.equalToSuperview()
//        make.width.equalTo(400)
//        make.height.equalTo(52)
//    }
//
//}
