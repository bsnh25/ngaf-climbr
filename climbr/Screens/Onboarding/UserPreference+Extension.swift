//
//  UserPreference+Extension.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 16/08/24.
//

import AppKit
import Swinject

extension UserPreferenceVC{
    
//    func processSavePreference() -> Int64{
        
//        if button1.isSelected {
//            return 30
//        }else if button2.isSelected{
//            return 60
//        }else if button3.isSelected{
//            return 90
//        } else if button4.isSelected{
//            return 120
//        }else {
//            print("ERR: at user preference (reminder)")
//            return 0
//        }
        
//    }
    
    @objc
    func actNextButton(){
        
//        guard processSavePreference() != 0, samePreference.startWorkPicker.dateValue.timeIntervalSince(samePreference.endWorkPicker.dateValue) >= 7200 else {
//            print("Date must greater than 2 hour or reminder has \(processSavePreference()) value")
////            configureWarning()
//            return
//        }
//        print("Start Work Hour : \(samePreference.startWorkPicker.dateValue)")
//        print("End Work Hour : \(samePreference.endWorkPicker.dateValue)")
//        
//        print("Reminder at \(processSavePreference())")
//        print("diff time : \(samePreference.startWorkPicker.dateValue.timeIntervalSince(samePreference.endWorkPicker.dateValue))")
        ///get checkbox value
//        let userPreferenceData = UserPreferenceModel(id: UUID(), launchAtLogin: isChecked, reminderInterval: processSavePreference(), workingHours: workingHours)
        
//        charService?.savePreferences(data: userPreferenceData)
        guard let homeVc = Container.shared.resolve(HomeVC.self) else {return}
        replace(with: homeVc)
        guard let notif = Container.shared.resolve(NotificationService.self) else {return}

//        notif.sendNotification(title: "🚨 Extreme muscle tightness detected!", body: "Initiate emergency stretch protocol or risk a workplace avalanche!", reminder: userPreferenceData)

    }
    
    @objc
  func actionReminderHandler(_ sender: CLPickerButton){
        resetButtonColors()
        sender.isSelected = true
        sender.layer?.backgroundColor = NSColor.cNewButton.cgColor
        sender.foregroundColorText = .white
        nextButton.isEnabled = true
        
        print("\(sender.title) choose")
    }
    
//    @objc
//    func action60min(){
//        resetButtonColors()
//        button2.isSelected = true
//        button2.layer?.backgroundColor = NSColor.cNewButton.cgColor
//        button2.foregroundColorText = .white
//        nextButton.isEnabled = true
//        print("\(button2.title) choose")
//    }
//    
//    @objc
//    func action90min(){
//        resetButtonColors()
//        button3.isSelected = true
//        button3.layer?.backgroundColor = NSColor.cNewButton.cgColor
//        button3.foregroundColorText = .white
//        nextButton.isEnabled = true
//        print("\(button3.title) choose")
//    }
//    
//    @objc
//    func action120min(){
//        resetButtonColors()
//        button4.isSelected = true
//        button4.layer?.backgroundColor = NSColor.cNewButton.cgColor
//        button4.foregroundColorText = .white
//        nextButton.isEnabled = true
//        print("\(button4.title) choose")
//    }
    
    @objc
  func actionCheckbox(sender: NSButton) {
    isLaunchAtLogin = sender.state == .on
    }
    
    @objc
    func actionDifferentWorkHour(_ sender: NSButton) {
        
        if differentWorkHoursCheckbox.state == .on {
            daysButtonStack.unlockButton()
            
            preferenceStackView.isHidden = false
            workHourItemView.isHidden = true
            preferenceStack[0].isHidden = false
        } else{
            daysButtonStack.lockButton()
            preferenceStackView.isHidden = true
            workHourItemView.isHidden = false
          
            preferenceStack.forEach { $0.isHidden = true }
        }
    }
    
}

extension UserPreferenceVC: DaysButtonToUserPreferenceDelegate {
    func didMondayTap(_ isSelected: Bool) {
      preferenceStack[0].isHidden = !isSelected
    }
    
    func didTuesdayTap(_ isSelected: Bool) {
      preferenceStack[1].isHidden = !isSelected
    }
    
    func didWednesdayTap(_ isSelected: Bool) {
      preferenceStack[2].isHidden = !isSelected
    }
    
    func didThursdayTap(_ isSelected: Bool) {
      preferenceStack[3].isHidden = !isSelected
    }
    
    func didFridayTap(_ isSelected: Bool) {
      preferenceStack[4].isHidden = !isSelected
    }
    
    func didSaturdayTap(_ isSelected: Bool) {
      preferenceStack[5].isHidden = !isSelected
    }
    
    func didSundayTap(_ isSelected: Bool) {
      preferenceStack[6].isHidden = !isSelected
    }
    
}
