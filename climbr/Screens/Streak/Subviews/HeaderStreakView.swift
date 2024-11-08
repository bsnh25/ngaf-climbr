//
//  HeaderStreakView.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 05/11/24.
//

import Cocoa
import AppKit
import SnapKit

class HeaderStreakView: NSStackView {
  
  let titleStreak: CLLabel = CLLabel(fontSize: 17, fontWeight: .bold)
  let valueLabelStreak: CLLabel = CLLabel(fontSize: 26, fontWeight: .bold)
  let imagePresent: NSImageView = NSImageView()
  
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
    
    wantsLayer = true
    
    self.orientation = .vertical
    self.alignment = .centerX
  }
  
  private func configStackLabel(){
    addArrangedSubview(titleStreak)
    addArrangedSubview(valueLabelStreak)
    
  }
  
  private func setupPresent(){
    imagePresent.image = NSImage(systemSymbolName: "archivebox.fill", accessibilityDescription: "Streak Reward")
    imagePresent.imageScaling = .scaleAxesIndependently
    imagePresent.contentTintColor = .cButton
    
    setCustomSpacing(20, after: valueLabelStreak)
    
    addArrangedSubview(imagePresent)
    
    imagePresent.snp.makeConstraints { make in
      make.height.width.equalTo(72)
    }
    
  }
  
  private func titleAndValueConfig(){
    titleStreak.setText("Next streak reward in")
    valueLabelStreak.setText("Coba")
  }
  
  func updateValue(value: String){
    valueLabelStreak.setText(value)
  }
  
  
}
