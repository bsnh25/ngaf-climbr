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
    
    guard let homeVc = Container.shared.resolve(HomeVC.self) else {return}
    replace(with: homeVc)
    
  }
  
  @objc
  func actionReminderHandler(_ sender: CLPickerButton){
    resetButtonColors()
    sender.isSelected = true
    sender.layer?.backgroundColor = NSColor.cNewButton.cgColor
    sender.foregroundColorText = .white
    nextButton.isEnabled = true
    
    print("\(sender.title) choose")
    
    intervalReminder = Int(sender.title)!
  }
  
  @objc
  func actionCheckbox(sender: NSButton) {
    isLaunchAtLogin = sender.state == .on
  }
  
  @objc
  func actionDifferentWorkHour(_ sender: NSButton) {
    isFlexibleWorkHour = sender.state == .on
    
    if isFlexibleWorkHour {
      daysButtonStack.unlockButton()
      
      preferenceStackView.isHidden = false
      workHourItemView.isHidden = true
      preferenceStack[0].isHidden = false
      
      if var day = workingHours.first(where: { $0.day == Weekday.monday.rawValue }) {
        day.isEnabled = true
        
        workingHours.update(with: day)
      }
    } else{
      daysButtonStack.lockButton()
      preferenceStackView.isHidden = true
      workHourItemView.isHidden = false
      
      preferenceStack.forEach { $0.isHidden = true }
      
      for item in workingHours {
        var data = WorkingHour(startHour: initialStartWorkHour, endHour: initialEndWorkHour, day: item.day)
        
        workingHours.update(with: data)
      }
    }
  }
  
}

extension UserPreferenceVC: DaysButtonToUserPreferenceDelegate {
  func didMondayTap(_ isSelected: Bool) {
    preferenceStack[0].isHidden = !isSelected
    
    if var day = workingHours.first(where: { $0.day == Weekday.monday.rawValue }) {
      day.isEnabled = isSelected
      
      if !isSelected {
        preferenceStack[0].reset()
        day.startHour = initialStartWorkHour
        day.endHour = initialEndWorkHour
      }
      
      workingHours.update(with: day)
    }
  }
  
  func didTuesdayTap(_ isSelected: Bool) {
    preferenceStack[1].isHidden = !isSelected
    
    if var day = workingHours.first(where: { $0.day == Weekday.tuesday.rawValue }) {
      day.isEnabled = isSelected
      
      if !isSelected {
        preferenceStack[1].reset()
        day.startHour = initialStartWorkHour
        day.endHour = initialEndWorkHour
      }
      
      workingHours.update(with: day)
    }
  }
  
  func didWednesdayTap(_ isSelected: Bool) {
    preferenceStack[2].isHidden = !isSelected
    
    if var day = workingHours.first(where: { $0.day == Weekday.wednesday.rawValue }) {
      day.isEnabled = isSelected
      
      if !isSelected {
        preferenceStack[2].reset()
        day.startHour = initialStartWorkHour
        day.endHour = initialEndWorkHour
      }
      
      workingHours.update(with: day)
    }
  }
  
  func didThursdayTap(_ isSelected: Bool) {
    preferenceStack[3].isHidden = !isSelected
    
    if var day = workingHours.first(where: { $0.day == Weekday.thursday.rawValue }) {
      day.isEnabled = isSelected
      
      if !isSelected {
        preferenceStack[3].reset()
        day.startHour = initialStartWorkHour
        day.endHour = initialEndWorkHour
      }
      
      workingHours.update(with: day)
    }
  }
  
  func didFridayTap(_ isSelected: Bool) {
    preferenceStack[4].isHidden = !isSelected
    
    if var day = workingHours.first(where: { $0.day == Weekday.friday.rawValue }) {
      day.isEnabled = isSelected
      
      if !isSelected {
        preferenceStack[4].reset()
        day.startHour = initialStartWorkHour
        day.endHour = initialEndWorkHour
      }
      
      workingHours.update(with: day)
    }
  }
  
  func didSaturdayTap(_ isSelected: Bool) {
    preferenceStack[5].isHidden = !isSelected
    
    if var day = workingHours.first(where: { $0.day == Weekday.saturday.rawValue }) {
      day.isEnabled = isSelected
      
      if !isSelected {
        preferenceStack[5].reset()
        day.startHour = initialStartWorkHour
        day.endHour = initialEndWorkHour
      }
      
      workingHours.update(with: day)
    }
  }
  
  func didSundayTap(_ isSelected: Bool) {
    preferenceStack[6].isHidden = !isSelected
    
    if var day = workingHours.first(where: { $0.day == Weekday.sunday.rawValue }) {
      day.isEnabled = isSelected
      
      if !isSelected {
        preferenceStack[6].reset()
        day.startHour = initialStartWorkHour
        day.endHour = initialEndWorkHour
      }
      
      workingHours.update(with: day)
    }
  }
  
}
