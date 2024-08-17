//
//  SettingVC+Extension.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 14/08/24.
//

import AppKit

extension SettingVC {
    @objc
    func actionCheckbox(){
        isChecked = checkboxButton.state == .on
    }
    
    @objc
    func action30min(){
        resetButtonColors()
        min30.isSelected = true
        min30.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.1).cgColor
        print("\( min30.isSelected) : 30 choose")
    }
    
    @objc
    func action60min(){
        resetButtonColors()
        min60.isSelected = true
        min60.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.1).cgColor
        print("\( min60.isSelected) : 60 choose")
    }
    
    @objc
    func action90min(){
        resetButtonColors()
        min90.isSelected = true
        min90.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.1).cgColor
        print("\( min90.isSelected) : 90 choose")
    }
    
    @objc
    func action120min(){
        resetButtonColors()
        min120.isSelected = true
        min120.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.1).cgColor
        print("\( min120.isSelected) : 120 choose")
    }
    
    func resetButtonColors() {
        // Reset all buttons to gray
        min30.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.05).cgColor
        min60.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.05).cgColor
        min90.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.05).cgColor
        min120.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.05).cgColor
        
        min30.isSelected = false
        min60.isSelected = false
        min90.isSelected = false
        min120.isSelected = false
    
    }
    
    @objc
    func actionSave(){
        ///get reminder value
        ///get start working hour and end working hour
        guard processSaveReminder() != 0, endTime.dateValue.timeIntervalSince(startTime.dateValue) >= 7200 else {
            print("Date must greater than 2 hour or reminder has \(processSaveReminder()) value")
            return
        }
        print("Reminder at \(processSaveReminder())")
        print("diff time : \(endTime.dateValue.timeIntervalSince(startTime.dateValue))")
        print("\(startTime.dateValue)")
        
        print("\(endTime.dateValue)")
        ///get checkbox value
        
        self.dismiss(self)
    }
    
    func processSaveReminder() -> Int{
        
        if min30.isSelected {
            return 30
        }else if min60.isSelected{
            return 60
        }else if min90.isSelected{
            return 90
        } else if min120.isSelected{
            return 120
        }else {
            print("ERR: at setting (reminder)")
            return 0
        }
    }
}
