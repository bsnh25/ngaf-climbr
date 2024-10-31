//
//  DayTimePreference.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 29/10/24.
//

import AppKit
import SnapKit




class DayTimePreferenceView: NSView {
    
    var divider: Divider = Divider()
    var dayName: CLTextLabelV2!
    var startWorkPicker: CLDatePicker!
    var toLabel: CLTextLabelV2 = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .regular, contentLabel: "to")
    var endWorkPicker: CLDatePicker!
    var switchButton: NSSwitch = NSSwitch()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    // Custom initializer
    init(dayName: String, startWorkPicker: CLDatePicker, endWorkPicker: CLDatePicker) {
            super.init(frame: .zero)
            self.dayName = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .bold, contentLabel: dayName)
            self.startWorkPicker = startWorkPicker
            self.endWorkPicker = endWorkPicker
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    func configure(){
        setupNameLabel()
        setupStartPicker()
        setupToLabel()
        setupEndPicker()
        setupDivider()
    }
    
    
    private func setupNameLabel(){
        addSubview(dayName)
        dayName.translatesAutoresizingMaskIntoConstraints = false
        
        dayName.snp.makeConstraints { dayName in
            dayName.top.equalToSuperview()
            dayName.leading.equalToSuperview()
            dayName.trailing.equalToSuperview()
        }
        
    }
    
    private func setupStartPicker(){
        addSubview(startWorkPicker)
        startWorkPicker.translatesAutoresizingMaskIntoConstraints = false
        
        startWorkPicker.snp.makeConstraints { startWorkPicker in
            startWorkPicker.top.equalToSuperview()
            startWorkPicker.leading.equalTo(dayName.snp.trailing).offset(84.167)
            startWorkPicker.width.equalTo(58.3)
            startWorkPicker.height.equalTo(28.3)
        }
    }
    
    private func setupToLabel(){
        addSubview(toLabel)
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        
        toLabel.snp.makeConstraints{toLabel in
            toLabel.top.equalToSuperview()
            toLabel.leading.equalTo(startWorkPicker.snp.trailing).offset(10)
        }
    }
    
    private func setupEndPicker(){
        addSubview(endWorkPicker)
        endWorkPicker.translatesAutoresizingMaskIntoConstraints = false
        
        endWorkPicker.snp.makeConstraints{ endWorkPicker in
            endWorkPicker.top.equalToSuperview()
            endWorkPicker.leading.equalTo(toLabel.snp.trailing).offset(10)
            endWorkPicker.width.equalTo(58.3)
            endWorkPicker.height.equalTo(28.3)
        }
    }
    
    
    private func setupDivider(){
        addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        divider.snp.makeConstraints{divider in
            divider.bottom.equalTo(startWorkPicker.snp.top).offset(-11.6)
            divider.leading.equalTo(dayName.snp.leading)
            divider.trailing.equalTo(endWorkPicker.snp.trailing)
        }
        
    }
}


//#Preview(traits: .defaultLayout, body: {
//    DayTimePreference?(NSCoder())
//})
