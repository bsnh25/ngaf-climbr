//
//  HeaderStreakView.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 05/11/24.
//

import Cocoa
import AppKit
import SnapKit

class HeaderStreakView: NSView {
    
    let titleStreak: CLLabel = CLLabel(fontSize: 17, fontWeight: .bold)
    let valueLabelStreak: CLLabel = CLLabel(fontSize: 26, fontWeight: .bold)
    let imagePresent: NSImageView = NSImageView()
    let stackStreakLabel: NSStackView = {
        let vstack = NSStackView()
        vstack.orientation = .vertical
        vstack.alignment = .centerX
        vstack.spacing = 0
        return vstack
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        configSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSelf(){
        titleAndValueConfig()
        configStackLabel()
        setupPresent()
        
    }
    
    private func configStackLabel(){
        self.addSubview(stackStreakLabel)
        stackStreakLabel.addArrangedSubview(titleStreak)
        stackStreakLabel.addArrangedSubview(valueLabelStreak)
        
        //border
        stackStreakLabel.wantsLayer = true
        stackStreakLabel.layer?.borderColor = .black
        stackStreakLabel.layer?.borderWidth = 1
        
        stackStreakLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self)
            make.height.equalTo(63)
        }
    }
    
    private func setupPresent(){
        self.addSubview(imagePresent)
        imagePresent.image = NSImage(systemSymbolName: "archivebox.fill", accessibilityDescription: "")
        imagePresent.imageScaling = .scaleAxesIndependently
        imagePresent.contentTintColor = .cButton
        
        imagePresent.wantsLayer = true
        imagePresent.layer?.borderColor = NSColor.blue.cgColor
        imagePresent.layer?.borderWidth = 1
        
        
        imagePresent.snp.makeConstraints { make in
            make.top.equalTo(stackStreakLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(stackStreakLabel.snp.horizontalEdges)
            make.bottom.equalTo(self.snp.bottom)
//            make.bottom.equalTo(self)
        }
    }
    
    private func titleAndValueConfig(){
        titleStreak.setText("Next streak reward in")
        valueLabelStreak.setText("Coba")
        
//        titleStreak.snp.makeConstraints { make in
//            make.edges.equalTo(stackStreakLabel.snp.edges)
//        }
//        
//        valueLabelStreak.snp.makeConstraints { make in
//            make.edges.equalTo(stackStreakLabel.snp.edges)
//        }
    }
    
    func updateValue(value: String){
        valueLabelStreak.setText(value)
    }
    
    
}
