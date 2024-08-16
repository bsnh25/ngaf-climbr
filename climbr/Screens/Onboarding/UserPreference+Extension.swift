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
    
    @objc
    func datePickerValueChanged(_ sender: NSDatePicker) {
        // Get the selected date from the date picker
        let selectedDate = sender.dateValue
        
        // Convert the date to a string for display (optional)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .short
//        let dateString = dateFormatter.string(from: selectedDate)
        
        // Display the selected date
        print("Date changed to: \(selectedDate)")
        stopWorkHour.dateValue = selectedDate.addingTimeInterval(7200)
//        stopWorkHour.minDate = selectedDate.addingTimeInterval(7200)
        print("\(stopWorkHour.dateValue)")
        
    }
    
}
