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
        
        ///change print into user deafult settings
        isChecked ? UserDefaults.standard.set(true, forKey: UserDefaultsKey.kIsOpenAtLogin) : UserDefaults.standard.set(false, forKey: UserDefaultsKey.kIsOpenAtLogin)
//        print("value checkbox : \(UserDefaults.standard.bool(forKey: UserDefaultsKey.kIsOpenAtLogin))")

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
        print("value checkbox is : \(UserDefaults.standard.bool(forKey: UserDefaultsKey.kIsOpenAtLogin))")
        
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
    
    @objc func startWorkHourChanged(_ sender: NSDatePicker) {
        let calendar = Calendar.current
        let difference = calendar.dateComponents([.minute], from: lastStartValue, to: lastStopValue)
        
        if difference.minute == 120 && isTimeIncreased(from: lastStartValue, to: startTime.dateValue) {
            // Start time increased and difference was 2 hours
            updateStopWorkHour()
        }
        
        lastStartValue = startTime.dateValue
    }
    
    @objc func stopWorkHourChanged(_ sender: NSDatePicker) {
        let calendar = Calendar.current
        let difference = calendar.dateComponents([.minute], from: lastStartValue, to: lastStopValue)
        
        if difference.minute == 120 && isTimeDecreased(from: lastStopValue, to: endTime.dateValue) {
            // Stop time decreased and difference was 2 hours
            updateStartWorkHour()
        }
        
        lastStopValue = endTime.dateValue
    }
    
    func updateStopWorkHour() {
        let calendar = Calendar.current
        let twoHours = DateComponents(hour: 2)
        if let stopDate = calendar.date(byAdding: twoHours, to: startTime.dateValue) {
            endTime.dateValue = stopDate
            lastStopValue = stopDate
        }
    }
    
    func updateStartWorkHour() {
        let calendar = Calendar.current
        let minusTwoHours = DateComponents(hour: -2)
        if let startDate = calendar.date(byAdding: minusTwoHours, to: endTime.dateValue) {
            startTime.dateValue = startDate
            lastStartValue = startDate
        }
    }
    
    func isTimeIncreased(from oldTime: Date, to newTime: Date) -> Bool {
        let calendar = Calendar.current
        let oldComponents = calendar.dateComponents([.hour, .minute], from: oldTime)
        let newComponents = calendar.dateComponents([.hour, .minute], from: newTime)
        
        let oldMinutes = oldComponents.hour! * 60 + oldComponents.minute!
        let newMinutes = newComponents.hour! * 60 + newComponents.minute!
        
        return (newMinutes - oldMinutes + 1440) % 1440 <= 720
    }
    
    func isTimeDecreased(from oldTime: Date, to newTime: Date) -> Bool {
        return !isTimeIncreased(from: oldTime, to: newTime)
    }
}
