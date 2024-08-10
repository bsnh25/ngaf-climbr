////
////  SampleView.swift
////  climbr
////
////  Created by Ivan Nur Ilham Syah on 08/08/24.
////
//
//import AppKit
//import SnapKit
//
//class ProgressIndicatorView: NSView {
//    
//    let progressStretch = NSProgressIndicator()
//    let startStretchButton = CLTextButton(titleBtn: "Start Session", labelColor: .white, bgColor: .black)
//    let stack = NSStackView()
//    
//    override init(frame frameRect: NSRect) {
//        super.init(frame: frameRect)
//        configure()
//        startBtnLabelConfig()
//    }
//    
//    required init(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//    private func configure(){
//        progressStretch.style = .bar
//        progressStretch.wantsLayer = true
//        
//        progressStretch.minValue = 0
//        progressStretch.maxValue = 4
////        addSubview(progressStretch)
//        
//        progressStretch.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.width.equalToSuperview()
//            make.height.equalToSuperview()
//        }
//    }
//    
//    private func startBtnLabelConfig(){
//        addSubview(startStretchButton)
//        
////        startStretchButton.layer?.frame = NSRect(x: 0, y: 0, width: 500, height: 50)
////        startStretchButton.layer?.backgroundColor = .black
////        startStretchButton.layer?.cornerRadius = 10
//        
//        //MARK: Start Session Button Action
//        startStretchButton.action = #selector(actionStartSession)
//        
//        startStretchButton.snp.makeConstraints { start in
//            start.top.equalTo(progressStretch.snp.bottom)
//            start.height.equalTo(40)
//            start.width.equalTo(progressStretch.snp.width)
//        }
//    }
//    
//    private func stackConfigure(){
////        add
//    }
//    
//    @objc
//    private func actionStartSession(){
//        print("hallo start session")
//    }
//    
//    
//}
//
//#Preview(traits: .defaultLayout, body: {
//    ProgressIndicatorView()
//})
