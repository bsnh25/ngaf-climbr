//
//  UserPreference+Extension.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 16/08/24.
//

import AppKit
import Swinject

extension UserPreferenceVC{
    @objc
    func actNextButton(){
        guard processSavePreference() != 0, stopWorkHour.dateValue.timeIntervalSince(startWorkHour.dateValue) >= 7200 else {
            print("Date must greater than 2 hour or reminder has \(processSavePreference()) value")
            return
        }
        print("Reminder at \(processSavePreference())")
        print("diff time : \(stopWorkHour.dateValue.timeIntervalSince(startWorkHour.dateValue))")
        ///get checkbox value
        print("value checkbox is : \(UserDefaults.standard.bool(forKey: UserDefaultsKey.kIsOpenAtLogin))")
        let userPreferenceData = UserPreferenceModel(id: UUID(), endWorkingHour: stopWorkHour.dateValue, launchAtLogin: isChecked, reminderInterval: processSavePreference(), startWorkingHour: startWorkHour.dateValue)
        
        userService?.savePreferences(data: userPreferenceData)
        guard let homeVc = Container.shared.resolve(HomeVC.self) else {return}
        replace(with: homeVc)
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
    func actionCheckbox(){
        isChecked = checkboxButton.state == .on
        print("\(isChecked)")
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
        
        if difference.minute == 120 && isTimeDecreased(from: lastStopValue, to: stopWorkHour.dateValue) {
            // Stop time decreased and difference was 2 hours
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
        
        return (newMinutes - oldMinutes + 1440) % 1440 <= 720
    }
    
    func isTimeDecreased(from oldTime: Date, to newTime: Date) -> Bool {
        return !isTimeIncreased(from: oldTime, to: newTime)
    }
}
