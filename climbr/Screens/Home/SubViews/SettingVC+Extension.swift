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
        let buttonState = checkboxButton.state
        if buttonState == .on {
            isChecked = true
        } else {
            isChecked = false
        }
    }
    
    @objc
    func action30min(){
        resetButtonColors()
        min30.isSelected = true
        min30.layer?.backgroundColor = NSColor.cButton.cgColor
        min30.foregroundColorText = .white
        print("\( min30.isSelected) : 30 choose")
    }
    
    @objc
    func action60min(){
        resetButtonColors()
        min60.isSelected = true
        min60.layer?.backgroundColor = NSColor.cButton.cgColor
        min60.foregroundColorText = .white
        print("\( min60.isSelected) : 60 choose")
    }
    
    @objc
    func action90min(){
        resetButtonColors()
        min90.isSelected = true
        min90.layer?.backgroundColor = NSColor.cButton.cgColor
        min90.foregroundColorText = .white
        print("\( min90.isSelected) : 90 choose")
    }
    
    @objc
    func action120min(){
        resetButtonColors()
        min120.isSelected = true
        min120.layer?.backgroundColor = NSColor.cButton.cgColor
        min120.foregroundColorText = .white
        print("\( min120.isSelected) : 120 choose")
    }
    
    func resetButtonColors() {
        // Reset all buttons to gray
        min30.layer?.backgroundColor = NSColor.cContainerHome.cgColor.copy(alpha: 0.48)
        min60.layer?.backgroundColor = NSColor.cContainerHome.cgColor.copy(alpha: 0.48)
        min90.layer?.backgroundColor = NSColor.cContainerHome.cgColor.copy(alpha: 0.48)
        min120.layer?.backgroundColor = NSColor.cContainerHome.cgColor.copy(alpha: 0.48)
        
        min30.foregroundColorText = .black
        min60.foregroundColorText = .black
        min90.foregroundColorText = .black
        min120.foregroundColorText = .black
        
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
        let updateData = UserPreferenceModel(id: UUID(), endWorkingHour: endTime.dateValue, launchAtLogin: isChecked, reminderInterval: processSaveReminder(), startWorkingHour: startTime.dateValue)
        print("Reminder at \(processSaveReminder())")
        print("diff time : \(endTime.dateValue.timeIntervalSince(startTime.dateValue))")
        print("\(startTime.dateValue)")
        
        print("\(endTime.dateValue)")
        ///get checkbox value
        
        guard let char = charService else {return}
        char.updatePreferences(data: updateData)
        guard let notif = notifService else {return}
        notif.sendNotification(title: "🚨 Extreme muscle tightness detected!", body: "Initiate emergency stretch protocol or risk a workplace avalanche!", reminder: updateData)
        
        self.dismiss(self)
    }
    
    func processSaveReminder() -> Int64{
        
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
        
        if handleSpecialCases(oldTime: lastStopValue, newTime: endTime.dateValue){
            endTime.dateValue = lastStopValue
            return
        }
        
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
    
    func handleSpecialCases(oldTime: Date, newTime: Date) -> Bool {
            let calendar = Calendar.current
            let oldComponents = calendar.dateComponents([.hour, .minute], from: oldTime)
            let newComponents = calendar.dateComponents([.hour, .minute], from: newTime)
            
            let oldHour = oldComponents.hour!
            let newHour = newComponents.hour!
            
            // Special case: from 23:00-23:59 to 00:00-00:59 (next day)
            if oldHour == 23 && newHour == 3 {
                return true
            }
            
            // Special case: from 00:00-00:59 to 23:00-23:59 (same day)
            if oldHour == 3 && newHour == 23 {
                return false
            }
            
            // No special case detected
            return false
        }
}
