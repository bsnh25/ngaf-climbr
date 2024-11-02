//
//  UserPreference+Extension.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 16/08/24.
//

import AppKit
import Swinject

extension UserPreferenceVC{
    
    func processSavePreference() -> Int64{
        
        if button1.isSelected {
            return 30
        }else if button2.isSelected{
            return 60
        }else if button3.isSelected{
            return 90
        } else if button4.isSelected{
            return 120
        }else {
            print("ERR: at user preference (reminder)")
            return 0
        }
        
    }
    
    @objc
    func actNextButton(){
        
        guard processSavePreference() != 0, stopWorkHour.dateValue.timeIntervalSince(startWorkHour.dateValue) >= 7200 else {
            print("Date must greater than 2 hour or reminder has \(processSavePreference()) value")
            configureWarning()
            return
        }
        print("Start Work Hour : \(startWorkHour.dateValue)")
        print("End Work Hour : \(stopWorkHour.dateValue)")
        
        print("Reminder at \(processSavePreference())")
        print("diff time : \(stopWorkHour.dateValue.timeIntervalSince(startWorkHour.dateValue))")
        ///get checkbox value
        let userPreferenceData = UserPreferenceModel(id: UUID(), launchAtLogin: isChecked, reminderInterval: processSavePreference(), workingHours: workingHours)
        
        charService?.savePreferences(data: userPreferenceData)
        guard let homeVc = Container.shared.resolve(HomeVC.self) else {return}
        replace(with: homeVc)
        guard let notif = Container.shared.resolve(NotificationService.self) else {return}

        notif.sendNotification(title: "🚨 Extreme muscle tightness detected!", body: "Initiate emergency stretch protocol or risk a workplace avalanche!", reminder: userPreferenceData)

    }
    
    @objc
    func action30min(){
        resetButtonColors()
        button1.isSelected = true
        button1.layer?.backgroundColor = .white
        button1.foregroundColorText = .black
        nextButton.isEnabled = true
        print("\(button1.title) choose")
    }
    
    @objc
    func action60min(){
        resetButtonColors()
        button2.isSelected = true
        button2.layer?.backgroundColor = .white
        button2.foregroundColorText = .black
        nextButton.isEnabled = true
        print("\(button2.title) choose")
    }
    
    @objc
    func action90min(){
        resetButtonColors()
        button3.isSelected = true
        button3.layer?.backgroundColor = .white
        button3.foregroundColorText = .black
        nextButton.isEnabled = true
        print("\(button3.title) choose")
    }
    
    @objc
    func action120min(){
        resetButtonColors()
        button4.isSelected = true
        button4.layer?.backgroundColor = .white
        button4.foregroundColorText = .black
        nextButton.isEnabled = true
        print("\(button4.title) choose")
    }
    
    @objc
    func actionCheckbox() {
        let buttonState = checkboxButton.state
        if buttonState == .on {
            isChecked = true
        } else {
            isChecked = false
        }
    }
    
    @objc func startWorkHourChanged(_ sender: NSDatePicker) {
        let calendar = Calendar.current
        let difference = calendar.dateComponents([.minute], from: lastStartValue, to: lastStopValue)
        
        if difference.minute == 120 && isTimeIncreased(from: lastStartValue, to: startWorkHour.dateValue) {
            // Start time increased and difference was 2 hours
            updateStopWorkHour()
        }
        
        lastStartValue = startWorkHour.dateValue
    }
    
    @objc func stopWorkHourChanged(_ sender: NSDatePicker) {
        let calendar = Calendar.current
        let difference = calendar.dateComponents([.minute], from: lastStartValue, to: lastStopValue)
        
        if handleSpecialCases(oldTime: lastStopValue, newTime: stopWorkHour.dateValue){
            stopWorkHour.dateValue = lastStopValue
            return
        }
        
        if difference.minute == 120 && isTimeDecreased(from: lastStopValue, to: stopWorkHour.dateValue) {
            updateStartWorkHour()
        }
        
        lastStopValue = stopWorkHour.dateValue
    }
    
    func updateStopWorkHour() {
        let calendar = Calendar.current
        let twoHours = DateComponents(hour: 2)
        if let stopDate = calendar.date(byAdding: twoHours, to: startWorkHour.dateValue) {
            stopWorkHour.dateValue = stopDate
            lastStopValue = stopDate
        }
    }
    
    func updateStartWorkHour() {
        let calendar = Calendar.current
        let minusTwoHours = DateComponents(hour: -2)
        if let startDate = calendar.date(byAdding: minusTwoHours, to: stopWorkHour.dateValue) {
            startWorkHour.dateValue = startDate
            lastStartValue = startDate
        }
    }
    
    func isTimeIncreased(from oldTime: Date, to newTime: Date) -> Bool {
        let calendar = Calendar.current
        let oldComponents = calendar.dateComponents([.hour, .minute], from: oldTime)
        let newComponents = calendar.dateComponents([.hour, .minute], from: newTime)
        
        let oldMinutes = oldComponents.hour! * 60 + oldComponents.minute!
        let newMinutes = newComponents.hour! * 60 + newComponents.minute!
        
        let difference = (newMinutes - oldMinutes + 1440) % 1440
        
        return difference <= 720
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
