//
//  SettingVC+Extension.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 14/08/24.
//

import AppKit

extension SettingVC {
    @objc
    internal func actionCheckbox(sender: NSButton) {
        isPreferenceEdited = true
      
        if sender.state == .on {
            isLaunchAtLogin = true
        } else {
            isLaunchAtLogin = false
        }
        
        let newState = sender.state == .on ? "Checked" : "Unchecked"
        sender.setAccessibilityValue(newState)
    }
    
    @objc
    internal func actionDifferentWorkHour(_ sender: NSButton) {
        isFlexibleWorkHour = sender.state == .on
          
        isPreferenceEdited = true
      
        if isFlexibleWorkHour {
          
          configureWorkingHours()
          daysButtonStack.unlockButton()
          
          workHourItemView.isHidden = true
          preferenceStackView.isHidden = false
          
          let reservedWorkingHours = workingHours.filter { $0.isEnabled }.count
          
          if reservedWorkingHours == 0 {
            daysButtonStack.sunday.isSelected = true
            preferenceStack[0].isHidden = false
            
            if var workHour = workingHours.first {
              workHour.isEnabled = true
              
              workingHours.update(with: workHour)
            }
          }
          
        } else{
          daysButtonStack.lockButton()
          preferenceStackView.isHidden = true
          workHourItemView.isHidden = false
          
          preferenceStack.forEach { $0.isHidden = true }
          
          for item in workingHours {
            var data = item
            data.isEnabled = false
            
            workingHours.update(with: data)
          }
        }
    }
    
    @objc
    internal func actionReminderHandler(_ sender: CLPickerButton){
      resetButtonColors()
      sender.isSelected = true
      sender.layer?.backgroundColor = NSColor.cNewButton.cgColor
      sender.foregroundColorText = .white
      
      isPreferenceEdited = true
      
      print("\(sender.title) choose")
      
      intervalReminder = Int(sender.title)!
    }
    
    @objc
    internal func actSaveButton(){
      
      print("Flexible Working Hours: ", isFlexibleWorkHour)
      
      let formatter = DateFormatter()
      formatter.dateFormat = "HH:mm"
      
      if isFlexibleWorkHour {
        for item in workingHours where item.isEnabled {
          let day = Weekday(rawValue: item.day)!
          print("\(day.fullName):", formatter.string(from: item.startHour), "to", formatter.string(from: item.endHour))
        }
      } else {
        for item in workingHours {
          let day = Weekday(rawValue: item.day)!
          print("\(day.fullName): ", formatter.string(from: item.startHour), " to ", formatter.string(from: item.endHour))
        }
      }
      
      print("Reminder Interval: ", intervalReminder)
      print("Launch At Login: ", isLaunchAtLogin)
      
      let data = UserPreferenceModel(
        launchAtLogin: isLaunchAtLogin,
        isFlexibleWorkHour: isFlexibleWorkHour,
        reminderInterval: intervalReminder,
        workingHours: Array(workingHours)
      )
      
      UserManager.shared.savePreferences(data: data)
      print("isi data preference: \(data)")
      notifService.startOverlayScheduler(userPreference: data)
      
                
        self.dismiss(self)
    }
  
  @objc
  internal func actCancelButton(){
              
      self.dismiss(self)
  }
}

extension SettingVC: DaysButtonToUserPreferenceDelegate {
    func didSundayTap(_ isSelected: Bool) {
      preferenceStack[0].isHidden = !isSelected
      isPreferenceEdited = true
      
      if var day = workingHours.first(where: { $0.day == Weekday.sunday.rawValue }) {
        day.isEnabled = isSelected
        
//        if !isSelected {
//          preferenceStack[0].reset()
//          day.startHour = initialStartWorkHour
//          day.endHour = initialEndWorkHour
//        }
        
        workingHours.update(with: day)
      }
    }
    
    func didMondayTap(_ isSelected: Bool) {
      preferenceStack[1].isHidden = !isSelected
      isPreferenceEdited = true
      
      if var day = workingHours.first(where: { $0.day == Weekday.monday.rawValue }) {
        day.isEnabled = isSelected
        
//        if !isSelected {
//          preferenceStack[1].reset()
//          day.startHour = initialStartWorkHour
//          day.endHour = initialEndWorkHour
//        }
        
        workingHours.update(with: day)
      }
    }
    
    func didTuesdayTap(_ isSelected: Bool) {
      preferenceStack[2].isHidden = !isSelected
      isPreferenceEdited = true
      
      if var day = workingHours.first(where: { $0.day == Weekday.tuesday.rawValue }) {
        day.isEnabled = isSelected
        
//        if !isSelected {
//          preferenceStack[2].reset()
//          day.startHour = initialStartWorkHour
//          day.endHour = initialEndWorkHour
//        }
        
        workingHours.update(with: day)
      }
    }
    
    func didWednesdayTap(_ isSelected: Bool) {
      preferenceStack[3].isHidden = !isSelected
      isPreferenceEdited = true
      
      if var day = workingHours.first(where: { $0.day == Weekday.wednesday.rawValue }) {
        day.isEnabled = isSelected
        
//        if !isSelected {
//          preferenceStack[3].reset()
//          day.startHour = initialStartWorkHour
//          day.endHour = initialEndWorkHour
//        }
        
        workingHours.update(with: day)
      }
    }
    
    func didThursdayTap(_ isSelected: Bool) {
      preferenceStack[4].isHidden = !isSelected
      isPreferenceEdited = true
      
      if var day = workingHours.first(where: { $0.day == Weekday.thursday.rawValue }) {
        day.isEnabled = isSelected
        
//        if !isSelected {
//          preferenceStack[4].reset()
//          day.startHour = initialStartWorkHour
//          day.endHour = initialEndWorkHour
//        }
        
        workingHours.update(with: day)
      }
    }
    
    func didFridayTap(_ isSelected: Bool) {
      preferenceStack[5].isHidden = !isSelected
      isPreferenceEdited = true
      
      if var day = workingHours.first(where: { $0.day == Weekday.friday.rawValue }) {
        day.isEnabled = isSelected
        
//        if !isSelected {
//          preferenceStack[5].reset()
//          day.startHour = initialStartWorkHour
//          day.endHour = initialEndWorkHour
//        }
        
        workingHours.update(with: day)
      }
    }
    
    func didSaturdayTap(_ isSelected: Bool) {
      preferenceStack[6].isHidden = !isSelected
      isPreferenceEdited = true
      
      if var day = workingHours.first(where: { $0.day == Weekday.saturday.rawValue }) {
        day.isEnabled = isSelected
        
//        if !isSelected {
//          preferenceStack[6].reset()
//          day.startHour = initialStartWorkHour
//          day.endHour = initialEndWorkHour
//        }
        
        workingHours.update(with: day)
      }
    }
}
