//
//  DaysButtonStackView.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 30/10/24.
//

import AppKit
import SnapKit

protocol DaysButtonToUserPreferenceDelegate: AnyObject {
    func didMondayTap(_ isSelected: Bool)
    func didTuesdayTap(_ isSelected: Bool)
    func didWednesdayTap(_ isSelected: Bool)
    func didThursdayTap(_ isSelected: Bool)
    func didFridayTap(_ isSelected: Bool)
    func didSaturdayTap(_ isSelected: Bool)
    func didSundayTap(_ isSelected: Bool)
}

class DaysButtonStackView: NSStackView {
    
    weak var daysButtonDelegate: DaysButtonToUserPreferenceDelegate?
  let monday = CLPickerButton(
    title: "M",
    backgroundColor: .white,
    foregroundColorText: .black,
    fontText: .boldSystemFont(ofSize: 20)
  )
  let tuesday = CLPickerButton(
    title: "T",
    backgroundColor: .white,
    foregroundColorText: .black,
    fontText: .boldSystemFont(ofSize: 20)
  )
  let wednesday = CLPickerButton(
    title: "W",
    backgroundColor: .white,
    foregroundColorText: .black,
    fontText: .boldSystemFont(ofSize: 20)
  )
  let thursday = CLPickerButton(
    title: "T",
    backgroundColor: .white,
    foregroundColorText: .black,
    fontText: .boldSystemFont(ofSize: 20)
  )
  let friday = CLPickerButton(
    title: "F",
    backgroundColor: .white,
    foregroundColorText: .black,
    fontText: .boldSystemFont(ofSize: 20)
  )
  let saturday = CLPickerButton(
    title: "S",
    backgroundColor: .white,
    foregroundColorText: .black,
    fontText: .boldSystemFont(ofSize: 20)
  )
  let sunday = CLPickerButton(
    title: "S",
    backgroundColor: .white,
    foregroundColorText: .black,
    fontText: .boldSystemFont(ofSize: 20)
  )
    
    var daysButtonStack: [CLPickerButton] = []
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        daysButtonStack = [monday, tuesday, wednesday, thursday, friday, saturday, sunday]
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        spacing = 20
        alignment = .leading
        clipsToBounds = true
        
      setViews(daysButtonStack, in: .leading)
        orientation = .horizontal
      distribution = .fillProportionally
        
        for item in daysButtonStack {
            item.wantsLayer = true
            item.layer?.backgroundColor = .white
          item.layer?.cornerRadius = 4
            item.foregroundColorText = .black
            item.isSelected = false
            
            item.isEnabled = false
            item.snp.makeConstraints{item in
                item.width.equalTo(32)
                item.height.equalTo(36)
            }
        }
        
        monday.target = self
        monday.action = #selector(mondayAction)
        tuesday.target = self
        tuesday.action = #selector(tuesdayAction)
        wednesday.target = self
        wednesday.action = #selector(wednesdayAction)
        thursday.target = self
        thursday.action = #selector(thursdayAction)
        friday.target = self
        friday.action = #selector(fridayAction)
        saturday.target = self
        saturday.action = #selector(saturdayAction)
        sunday.target = self
        sunday.action = #selector(sundayAction)
    }
    
    func unlockButton() {
        for item in daysButtonStack {
            item.isEnabled = true
            item.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
            item.foregroundColorText = .black
            item.isSelected = false
        }
        
        monday.isSelected = true
        monday.layer?.backgroundColor = NSColor.cNewButton.cgColor
        monday.foregroundColorText = .white
    }
    
    func lockButton() {
        for item in daysButtonStack {
            item.isSelected = false
            item.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
            item.foregroundColorText = .black
            item.isEnabled = false
        }
    }
    
  @objc func mondayAction(_ sender: CLPickerButton) {
    guard hasMinimumADayActive() && sender.isSelected else {
          sender.isSelected = true
          sender.layer?.backgroundColor = NSColor.cNewButton.cgColor
          sender.foregroundColorText = .white
          daysButtonDelegate?.didMondayTap(monday.isSelected)
        
          return
      }
      
      sender.isSelected = false
      sender.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
      sender.foregroundColorText = .black
      daysButtonDelegate?.didMondayTap(monday.isSelected)
        
    }
    
    
  @objc func tuesdayAction(_ sender: CLPickerButton) {
    guard hasMinimumADayActive() && sender.isSelected else {
          sender.isSelected = true
          sender.layer?.backgroundColor = NSColor.cNewButton.cgColor
          sender.foregroundColorText = .white
          daysButtonDelegate?.didTuesdayTap(tuesday.isSelected)
        
          return
      }
    
      sender.isSelected = false
      sender.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
      sender.foregroundColorText = .black
      daysButtonDelegate?.didTuesdayTap(tuesday.isSelected)
    }
    
  @objc func wednesdayAction(_ sender: CLPickerButton) {
    guard hasMinimumADayActive() && sender.isSelected else {
          sender.isSelected = true
          sender.layer?.backgroundColor = NSColor.cNewButton.cgColor
          sender.foregroundColorText = .white
          daysButtonDelegate?.didWednesdayTap(wednesday.isSelected)
        
          return
      }
    
      sender.isSelected = false
      sender.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
      sender.foregroundColorText = .black
      daysButtonDelegate?.didWednesdayTap(wednesday.isSelected)
    }
    
  @objc func thursdayAction(_ sender: CLPickerButton) {
    guard hasMinimumADayActive() && sender.isSelected else {
          sender.isSelected = true
          sender.layer?.backgroundColor = NSColor.cNewButton.cgColor
          sender.foregroundColorText = .white
          daysButtonDelegate?.didThursdayTap(thursday.isSelected)
        
          return
      }
    
      sender.isSelected = false
      sender.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
      sender.foregroundColorText = .black
      daysButtonDelegate?.didThursdayTap(thursday.isSelected)
          
    }
    
  @objc func fridayAction(_ sender: CLPickerButton) {
    guard hasMinimumADayActive() && sender.isSelected else {
          sender.isSelected = true
          sender.layer?.backgroundColor = NSColor.cNewButton.cgColor
          sender.foregroundColorText = .white
          daysButtonDelegate?.didFridayTap(friday.isSelected)
      
          return
      }
    
      sender.isSelected = false
      sender.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
      sender.foregroundColorText = .black
      daysButtonDelegate?.didFridayTap(friday.isSelected)

    }
    
  @objc func saturdayAction(_ sender: CLPickerButton) {
    guard hasMinimumADayActive() && sender.isSelected else {
          sender.isSelected = true
          sender.layer?.backgroundColor = NSColor.cNewButton.cgColor
          sender.foregroundColorText = .white
          daysButtonDelegate?.didSaturdayTap(saturday.isSelected)
          
          return
      }
    
        
      sender.isSelected = false
      sender.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
      sender.foregroundColorText = .black
      daysButtonDelegate?.didSaturdayTap(saturday.isSelected)
       
    }
    
  @objc func sundayAction(_ sender: CLPickerButton) {
    guard hasMinimumADayActive() && sender.isSelected else {
          sender.isSelected = true
          sender.layer?.backgroundColor = NSColor.cNewButton.cgColor
          sender.foregroundColorText = .white
          daysButtonDelegate?.didSundayTap(sunday.isSelected)
            
          return
      }
    
      
      sender.isSelected = false
      sender.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
      sender.foregroundColorText = .black
      daysButtonDelegate?.didSundayTap(sunday.isSelected)
    }
  
    private func hasMinimumADayActive() -> Bool {
      daysButtonStack.filter { $0.isSelected == true }.count > 1
    }
}
