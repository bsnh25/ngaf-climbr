//
//  DaysButtonStackView.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 30/10/24.
//

import AppKit
import SnapKit

protocol DaysButtonToUserPreferenceDelegate: AnyObject {
    func didMondayTap(_ monday: Bool)
    func didTuesdayTap(_ tuesday: Bool)
    func didWednesdayTap(_ wednesday: Bool)
    func didThursdayTap(_ thursday: Bool)
    func didFridayTap(_ friday: Bool)
    func didSaturdayTap(_ saturday: Bool)
    func didSundayTap(_ sunday: Bool)
}

class DaysButtonStackView: NSStackView {
    
    weak var daysButtonDelegate: DaysButtonToUserPreferenceDelegate?
    let monday = CLPickerButton(title: "M", backgroundColor: .white, foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    let tuesday = CLPickerButton(title: "T", backgroundColor: .white, foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    let wednesday = CLPickerButton(title: "W", backgroundColor: .white, foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    let thursday = CLPickerButton(title: "T", backgroundColor: .white, foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    let friday = CLPickerButton(title: "F", backgroundColor: .white, foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    let saturday = CLPickerButton(title: "S", backgroundColor: .white, foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    let sunday = CLPickerButton(title: "S", backgroundColor: .white, foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    
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
        
        
        setViews(daysButtonStack, in: .center)
        orientation = .horizontal
        
        for item in daysButtonStack {
            item.wantsLayer = true
            item.layer?.backgroundColor = .white
            item.foregroundColorText = .black
            item.isSelected = false
            item.translatesAutoresizingMaskIntoConstraints = false
            
            item.isEnabled = false
            
            
            
            item.snp.makeConstraints{item in
                item.width.equalTo(25.84)
                item.height.equalTo(30)
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
        
        
    }
    
    func lockButton() {
        for item in daysButtonStack {
            item.isSelected = false
            item.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
            item.foregroundColorText = .black
            item.isEnabled = false
        }
    }
    
    @objc func mondayAction() {
        if monday.isSelected{
            monday.isSelected = false
            monday.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
            monday.foregroundColorText = .black
            daysButtonDelegate?.didMondayTap(monday.isSelected)
        } else {
            monday.isSelected = true
            monday.layer?.backgroundColor = NSColor.cNewButton.cgColor
            monday.foregroundColorText = .white
            daysButtonDelegate?.didMondayTap(monday.isSelected)
        }
    }
    
    
    @objc func tuesdayAction() {
        if tuesday.isSelected{
            tuesday.isSelected = false
            tuesday.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
            tuesday.foregroundColorText = .black
            daysButtonDelegate?.didTuesdayTap(tuesday.isSelected)
        } else {
            tuesday.isSelected = true
            tuesday.layer?.backgroundColor = NSColor.cNewButton.cgColor
            tuesday.foregroundColorText = .white
            daysButtonDelegate?.didTuesdayTap(tuesday.isSelected)
        }
    }
    
    @objc func wednesdayAction() {
        if wednesday.isSelected{
            wednesday.isSelected = false
            wednesday.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
            wednesday.foregroundColorText = .black
            daysButtonDelegate?.didWednesdayTap(wednesday.isSelected)
        } else {
            wednesday.isSelected = true
            wednesday.layer?.backgroundColor = NSColor.cNewButton.cgColor
            wednesday.foregroundColorText = .white
            daysButtonDelegate?.didWednesdayTap(wednesday.isSelected)
        }
    }
    
    @objc func thursdayAction() {
        if thursday.isSelected{
            thursday.isSelected = false
            thursday.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
            thursday.foregroundColorText = .black
            daysButtonDelegate?.didThursdayTap(thursday.isSelected)
        } else {
            thursday.isSelected = true
            thursday.layer?.backgroundColor = NSColor.cNewButton.cgColor
            thursday.foregroundColorText = .white
            daysButtonDelegate?.didThursdayTap(thursday.isSelected)
        }
    }
    
    @objc func fridayAction() {
        if friday.isSelected{
            friday.isSelected = false
            friday.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
            friday.foregroundColorText = .black
            daysButtonDelegate?.didFridayTap(friday.isSelected)
        } else {
            friday.isSelected = true
            friday.layer?.backgroundColor = NSColor.cNewButton.cgColor
            friday.foregroundColorText = .white
            daysButtonDelegate?.didFridayTap(friday.isSelected)
        }
    }
    
    @objc func saturdayAction() {
        if saturday.isSelected{
            saturday.isSelected = false
            saturday.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
            saturday.foregroundColorText = .black
            daysButtonDelegate?.didSaturdayTap(saturday.isSelected)
        } else {
            saturday.isSelected = true
            saturday.layer?.backgroundColor = NSColor.cNewButton.cgColor
            saturday.foregroundColorText = .white
            daysButtonDelegate?.didSaturdayTap(saturday.isSelected)
        }
    }
    
    @objc func sundayAction() {
        if sunday.isSelected{
            sunday.isSelected = false
            sunday.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
            sunday.foregroundColorText = .black
            daysButtonDelegate?.didSundayTap(sunday.isSelected)
        } else {
            sunday.isSelected = true
            sunday.layer?.backgroundColor = NSColor.cNewButton.cgColor
            sunday.foregroundColorText = .white
            daysButtonDelegate?.didSundayTap(sunday.isSelected)
        }
    }
}
