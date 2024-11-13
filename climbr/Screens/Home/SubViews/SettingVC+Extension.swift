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
          
//          configureWorkingHours()
//          daysButtonStack.unlockButton()
          
          workHourItemView.isHidden = true
          preferenceStackView.isHidden = false
          
            for workingHour in self.workingHours {
                if workingHour.isEnabled{
                    preferenceStack[workingHour.day].isHidden = false
                    preferenceStack[workingHour.day].setInitialValue(workingHour.startHour, workingHour.endHour)
                      
                    workingHours.update(with: workingHour)
                    
                }
            }
          
        } else{
//          daysButtonStack.lockButton()
          preferenceStackView.isHidden = true
          workHourItemView.isHidden = false
          
          preferenceStack.forEach { $0.isHidden = true }
          
            for item in workingHours {
                if item.isEnabled{
                    var data = WorkingHour(startHour: item.startHour, endHour: item.endHour, day: item.day, isEnabled: true)
                    
                    workingHours.update(with: data)
                }else {
                    var data = WorkingHour(startHour: item.startHour, endHour: item.endHour, day: item.day)
                    
                    workingHours.update(with: data)
                }
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
        if isFlexibleWorkHour {
            preferenceStack[0].isHidden = !isSelected
            
            if var day = workingHours.first(where: { $0.day == Weekday.sunday.rawValue }) {
                day.isEnabled = isSelected
                
                workingHours.update(with: day)
            }
        } else {
            if var day = workingHours.first(where: { $0.day == Weekday.sunday.rawValue }) {
                day.isEnabled = isSelected
                
                if !isSelected {
                    day.isEnabled = isSelected
                }
                
                workingHours.update(with: day)
            }
        }
        
        isPreferenceEdited = true
    }
    
    func didMondayTap(_ isSelected: Bool) {
        if isFlexibleWorkHour {
            preferenceStack[1].isHidden = !isSelected
            
            if var day = workingHours.first(where: { $0.day == Weekday.monday.rawValue }) {
                day.isEnabled = isSelected
                
                
                workingHours.update(with: day)
            }
        } else {
            if var day = workingHours.first(where: { $0.day == Weekday.monday.rawValue }) {
                day.isEnabled = isSelected
                
                if !isSelected {
                    day.isEnabled = isSelected
                }
                
                workingHours.update(with: day)
            }
        }
        isPreferenceEdited = true
    }
    
    func didTuesdayTap(_ isSelected: Bool) {
        if isFlexibleWorkHour{
            preferenceStack[2].isHidden = !isSelected
            
            if var day = workingHours.first(where: { $0.day == Weekday.tuesday.rawValue }) {
                day.isEnabled = isSelected
                
                workingHours.update(with: day)
            }
        } else {
            if var day = workingHours.first(where: { $0.day == Weekday.tuesday.rawValue }) {
                day.isEnabled = isSelected
                
                if !isSelected {
                    day.isEnabled = isSelected
                }
                
                workingHours.update(with: day)
            }
        }
        
        isPreferenceEdited = true
    }
    
    func didWednesdayTap(_ isSelected: Bool) {
        if isFlexibleWorkHour {
            preferenceStack[3].isHidden = !isSelected
            
            if var day = workingHours.first(where: { $0.day == Weekday.wednesday.rawValue }) {
                day.isEnabled = isSelected
                
                
                workingHours.update(with: day)
            }
        } else {
            if var day = workingHours.first(where: { $0.day == Weekday.wednesday.rawValue }) {
                day.isEnabled = isSelected
                
                if !isSelected {
                    day.isEnabled = isSelected
                }
                
                workingHours.update(with: day)
            }
        }
        
        isPreferenceEdited = true
    }
    
    func didThursdayTap(_ isSelected: Bool) {
        if isFlexibleWorkHour{
            preferenceStack[4].isHidden = !isSelected
            
            if var day = workingHours.first(where: { $0.day == Weekday.thursday.rawValue }) {
                day.isEnabled = isSelected
                
                
                workingHours.update(with: day)
            }
        }else {
            if var day = workingHours.first(where: { $0.day == Weekday.thursday.rawValue }) {
                day.isEnabled = isSelected
                
                if !isSelected {
                    day.isEnabled = isSelected
                }
                
                workingHours.update(with: day)
            }
        }
        
        isPreferenceEdited = true
    }
    
    func didFridayTap(_ isSelected: Bool) {
        if isFlexibleWorkHour{
            preferenceStack[5].isHidden = !isSelected
            
            if var day = workingHours.first(where: { $0.day == Weekday.friday.rawValue }) {
                day.isEnabled = isSelected
                
                
                workingHours.update(with: day)
            }
        }else {
            if var day = workingHours.first(where: { $0.day == Weekday.friday.rawValue }) {
                day.isEnabled = isSelected
                
                if !isSelected {
                    day.isEnabled = isSelected
                }
                
                workingHours.update(with: day)
            }
        }
        
        isPreferenceEdited = true
    }
    
    func didSaturdayTap(_ isSelected: Bool) {
        if isFlexibleWorkHour{
            preferenceStack[6].isHidden = !isSelected
            
            if var day = workingHours.first(where: { $0.day == Weekday.saturday.rawValue }) {
                day.isEnabled = isSelected
                
                
                workingHours.update(with: day)
            }
        }else {
            
            if var day = workingHours.first(where: { $0.day == Weekday.saturday.rawValue }) {
                day.isEnabled = isSelected
                
                if !isSelected {
                    day.isEnabled = isSelected
                }
                
                workingHours.update(with: day)
            }
        }
        
        isPreferenceEdited = true
    }
}
