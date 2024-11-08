//
//  SettingsVC.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 09/08/24.
//

import AppKit
import SnapKit
import Combine

class SettingVC: NSViewController {
    
    private lazy var workHoursStack: NSStackView = NSStackView()
    private lazy var reminderStack: NSStackView = NSStackView()
    
    internal let settingText = CLTextLabelV2(
        sizeOfFont: 22,
        weightOfFont: .bold,
        contentLabel: "User Preference"
    )
    internal let subTitleA = CLTextLabelV2(
        sizeOfFont: 17,
        weightOfFont: .bold,
        contentLabel: "Your Work Days"
    )
    
    internal let preferenceStackView = NSStackView()
    internal let differentWorkHoursCheckbox = NSButton(checkboxWithTitle: "I have different daily work hours", target: nil, action: #selector(actionDifferentWorkHour))
    internal let daysButtonStack = DaysButtonStackView()
    internal let workHourItemView = DayTimePreferenceView(dayName: "Work Hours")
    internal let sundayPreference = DayTimePreferenceView(dayName: "Sunday")
    internal let mondayPreference = DayTimePreferenceView(dayName: "Monday")
    internal let tuesdayPreference = DayTimePreferenceView(dayName: "Tuesday")
    internal let wednesdayPreference = DayTimePreferenceView(dayName: "Wednesday")
    internal let thursdayPreference = DayTimePreferenceView(dayName: "Thursday")
    internal let fridayPreference = DayTimePreferenceView(dayName: "Friday")
    internal let saturdayPreference = DayTimePreferenceView(dayName: "Saturday")
    
    internal var preferenceStack: [DayTimePreferenceView] = []
    internal var isFlexibleWorkHour: Bool = false
    
    internal lazy var workingHours: Set<WorkingHour> = []
    
    internal let reminder30MinutesButton = CLPickerButton(
        title: "30",
        backgroundColor: .white,
        foregroundColorText: .black,
        fontText: .boldSystemFont(ofSize: 17)
    )
    internal let reminder60MinutesButton = CLPickerButton(
        title: "60",
        backgroundColor: .white,
        foregroundColorText: .black,
        fontText: .boldSystemFont(ofSize: 17)
    )
    internal let reminder90MinutesButton = CLPickerButton(
        title: "90",
        backgroundColor: .white,
        foregroundColorText: .black,
        fontText: .boldSystemFont(ofSize: 17)
    )
    internal let reminder120MinutesButton = CLPickerButton(
        title: "120",
        backgroundColor: .white,
        foregroundColorText: .black,
        fontText: .boldSystemFont(ofSize: 17)
    )
    internal var intervalReminder: Int = 0
    internal let launchAtLoginChecBox = NSButton(checkboxWithTitle: "Launch Limbr on startup", target: nil, action: #selector(actionCheckbox))
    internal var isLaunchAtLogin: Bool = false
    @Published internal var isPreferenceEdited: Bool = false
  
    internal var bag: AnyCancellable?
  
    internal let saveButton = CLTextButtonV2(title: "Save", backgroundColor: .cButton, foregroundColorText: .white, fontText: .systemFont(ofSize: 26, weight: .bold))
  
  internal let cancelButton = CLTextButtonV2(title: "Cancel", backgroundColor: .kDarkGray, foregroundColorText: .white, fontText: .systemFont(ofSize: 26, weight: .bold))
    
    
    internal let reminderLabel = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .bold, contentLabel: "Choose When do you want to be reminded")
    
    internal let fromText = CLTextLabelV2(
        sizeOfFont: 17,
        weightOfFont: .regular,
        contentLabel: "From"
    )
    
    internal let everyText = CLTextLabelV2(
        sizeOfFont: 17,
        weightOfFont: .regular,
        contentLabel: "Every"
    )
    
    internal let minutesText = CLTextLabelV2(
        sizeOfFont: 17,
        weightOfFont: .regular,
        contentLabel: "minutes"
    )
    
    
    internal let warnContainer = NSView()
    internal let warnLabel = CLTextLabelV2(sizeOfFont: 14, weightOfFont: .light, contentLabel: "􀇾 Can’t be less than 2 (two) hours")
    
    
    internal var notifService: NotificationService = NotificationManager.shared
    internal var charService: CharacterService = UserManager.shared
    internal var userPreferenceData: UserPreferenceModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.cBox.cgColor.copy(alpha: 0.84)
        
        userPreferenceData = charService.getPreferences()
        configure()
      
        bag = $isPreferenceEdited.sink { [weak self] isEdited in
          guard let self else { return }
          self.saveButton.isEnabled = isEdited
        }
        
    }
  
  override func viewWillAppear() {
    super.viewWillAppear()
    
    userPreferenceData = charService.getPreferences()
    
    if let workingHours = userPreferenceData?.workingHours {
      self.workingHours = Set(workingHours)
    }
  }
  
    override func viewDidDisappear() {
      bag?.cancel()
    }
    
    func configure(){
        configureSettingTitle()
        configureYourWorkDaysText()
        configureDifferentWorkHours()
        configureWorkHourItemView()
        configureDifferentWorkHoursStackView()
        configureWorkHoursStack()
        configureReminderStack()
        configureLaunchAtLoginCheckBox()
        configureSaveButton()
        configureCancelButton()
      
    
        configureWorkingHours()
        daysButtonStack.daysButtonDelegate = self
    }
    
    func configureSettingTitle(){
        view.addSubview(settingText)
        
        settingText.snp.makeConstraints{setting in
            setting.top.equalTo(view.snp.top).inset(16.67)
            setting.leading.equalTo(view.snp.leading).inset(33.34)
            setting.trailing.equalTo(635)
        }
        
        settingText.setAccessibilityElement(true)
        settingText.setAccessibilityTitle(settingText.stringValue)
        settingText.setAccessibilityLabel("This is \(settingText.stringValue) page. You can modify your work hours preference here")
        settingText.setAccessibilityRole(.staticText)
        
    }
    
    func configureYourWorkDaysText(){
        view.addSubview(subTitleA)
        
        subTitleA.snp.makeConstraints{subTitle in
            subTitle.top.equalTo(settingText.snp.bottom).offset(26.67)
            subTitle.leading.equalTo(view.snp.leading).inset(33.34)
        }
        
        subTitleA.setAccessibilityElement(true)
        subTitleA.setAccessibilityTitle(subTitleA.stringValue)
        subTitleA.setAccessibilityLabel("This is \(subTitleA.stringValue) section. below you can modify your day and time preference")
        subTitleA.setAccessibilityRole(.staticText)
    }
    
    func configureWorkHoursStack() {
      
        view.addSubview(workHoursStack)
        
        // Add views to the workHoursStack
        workHoursStack.setViews([daysButtonStack, differentWorkHoursCheckbox, workHourItemView, preferenceStackView], in: .center)
        workHoursStack.spacing = 16
        workHoursStack.alignment = .leading
        workHoursStack.orientation = .vertical
        
//        if let userPreference = userPreferenceData {
//            if userPreference.isFlexibleWorkHour {
//                isFlexibleWorkHour = true
//                differentWorkHoursCheckbox.state = .on
//                // Unlock the day buttons
//                daysButtonStack.unlockButton()
//                daysButtonStack.sunday.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
//                daysButtonStack.sunday.foregroundColorText = .black
//                daysButtonStack.sunday.isSelected = false
//                
//                // Show the preference stack view
//                workHourItemView.isHidden = true
//                
//                preferenceStackView.isHidden = false
//                
//                // Loop through the working hours and update preferences accordingly
//                for workingHour in userPreference.workingHours {
//                    if workingHour.isEnabled {
//                        // Find the corresponding day index and preference view
//                        let dayIndex = workingHour.day
//                        if let dayPreference = getDayPreference(for: dayIndex) {
//                            // Enable the button for the corresponding day
//                            let button = daysButtonStack.daysButtonStack[dayIndex]
//                            button.isSelected = true
//                            button.isEnabled = true
//                            button.layer?.backgroundColor = NSColor.cNewButton.cgColor
//                            button.foregroundColorText = .white
//                            
//                            // Update the start and end hours in the DayTimePreferenceView
//                            dayPreference.setInitialValue(workingHour.startHour, workingHour.endHour)
//                            dayPreference.isHidden = false
//                            workingHours.update(with: workingHour)
//                        }
//                    }
//                }
//            } else {
//                isFlexibleWorkHour = false
//                differentWorkHoursCheckbox.state = .off
//                daysButtonStack.lockButton()
//                preferenceStackView.isHidden = true  // Hide the preferences if not flexible
//                
//                if let workingHour = userPreference.workingHours.first {
//                  workHourItemView.setInitialValue(workingHour.startHour, workingHour.endHour)
//                }
//                
//                for workingHour in userPreference.workingHours {
//                    workingHours.update(with: workingHour)
//                }
//            }
//        }
        
        // Set constraints for the stack
        workHoursStack.snp.makeConstraints { make in
            make.top.equalTo(subTitleA.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(40)
        }

    }
    
    func getDayPreference(for dayIndex: Int) -> DayTimePreferenceView? {
      guard let dayName = Weekday(rawValue: dayIndex) else { return nil }
      
      switch dayName {
      case .sunday:
        return sundayPreference
      case .monday:
        return mondayPreference
      case .tuesday:
        return tuesdayPreference
      case .wednesday:
        return wednesdayPreference
      case .thursday:
        return thursdayPreference
      case .friday:
        return fridayPreference
      case .saturday:
        return saturdayPreference
      }
    }
    
    func configureDifferentWorkHours(){
      
      guard let userPreferenceData else { return }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 22, weight: .bold),
            .foregroundColor: NSColor.black
        ]
        
        // Apply the attributed title
        differentWorkHoursCheckbox.attributedTitle = NSAttributedString(string: differentWorkHoursCheckbox.title, attributes: attributes)
      
        differentWorkHoursCheckbox.state = userPreferenceData.isFlexibleWorkHour ? .on : .off
        
        // Set the content tint color (optional, depending on what you want to achieve)
        differentWorkHoursCheckbox.contentTintColor = .blue
        
        differentWorkHoursCheckbox.target = self
        differentWorkHoursCheckbox.action = #selector(actionDifferentWorkHour)
        differentWorkHoursCheckbox.setAccessibilityElement(true)
        differentWorkHoursCheckbox.setAccessibilityTitle("Different Work Hours")
        differentWorkHoursCheckbox.setAccessibilityLabel("Check this if you want to configure work hour independently")
        differentWorkHoursCheckbox.setAccessibilityRole(.checkBox)
    }
    
    func configureWorkHourItemView(){
      guard let userPreferenceData else { return }
      
      workHourItemView.isHidden = userPreferenceData.isFlexibleWorkHour
      let workingHour = userPreferenceData.workingHours.first
      
      if let workingHour {
        workHourItemView.setInitialValue(workingHour.startHour, workingHour.endHour)
      }
      
        workHourItemView.onValueChanged = { [weak self] start, end in
          
            guard let self else { return }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            print("Work Hours: ", formatter.string(from: start), " to ", formatter.string(from: end))
            
            for item in self.workingHours {
                let data = WorkingHour(startHour: start, endHour: end, day: item.day)
                
                self.workingHours.update(with: data)
            }
            
            self.isPreferenceEdited = true
        }
        
        workHourItemView.snp.makeConstraints{item in
            item.width.equalTo(372.5)
            item.height.equalTo(38.3)
        }
    }
  
  func configureWorkingHours() {
    guard let userPreferenceData else { return }
    if userPreferenceData.isFlexibleWorkHour {
      daysButtonStack.unlockButton()
      
      for workingHour in userPreferenceData.workingHours where workingHour.isEnabled {
        let dayPreference: DayTimePreferenceView? = getDayPreference(for: workingHour.day)
        
        dayPreference?.isHidden = false
        dayPreference?.setInitialValue(workingHour.startHour, workingHour.endHour)
          workingHours.update(with: workingHour)
      }
      
      for workingHour in userPreferenceData.workingHours {
        guard let dayName = Weekday(rawValue: workingHour.day) else { return }
        
        let weekDayButton: CLPickerButton?
        
        switch dayName {
          
        case .sunday:
          weekDayButton = daysButtonStack.sunday
        case .monday:
          weekDayButton = daysButtonStack.monday
        case .tuesday:
          weekDayButton = daysButtonStack.tuesday
        case .wednesday:
          weekDayButton = daysButtonStack.wednesday
        case .thursday:
          weekDayButton = daysButtonStack.thursday
        case .friday:
          weekDayButton = daysButtonStack.friday
        case .saturday:
          weekDayButton = daysButtonStack.saturday
        }
        
        weekDayButton?.isSelected = workingHour.isEnabled
      }
      
    } else {
      daysButtonStack.lockButton()
    }
    
  }
    
    func configureDifferentWorkHoursStackView(){
        guard let userPreferenceData else { return }
      
        preferenceStack = [
            sundayPreference,
            mondayPreference,
            tuesdayPreference,
            wednesdayPreference,
            thursdayPreference,
            fridayPreference,
            saturdayPreference,
        ]
        
        preferenceStackView.isHidden = !userPreferenceData.isFlexibleWorkHour
        preferenceStackView.spacing = 16
        preferenceStackView.alignment = .leading
        
        preferenceStackView.setViews(preferenceStack, in: .center)
        preferenceStackView.orientation = .vertical
        preferenceStackView.distribution = .fillEqually
        
        for item in preferenceStack {
          item.isHidden = true
          item.snp.makeConstraints{item in
            item.width.equalTo(372.5)
            item.height.equalTo(38.3)
          }
          
        }
        
        sundayPreference.onValueChanged = { [weak self] start, end in
          guard let self else { return }
          
          let formatter = DateFormatter()
          formatter.dateFormat = "HH:mm"
          print("Sunday: ", formatter.string(from: start), " to ", formatter.string(from: end))
          
          if var day = workingHours.first(where: { $0.day == Weekday.sunday.rawValue }) {
            day.startHour = start
            day.endHour = end
            
            workingHours.update(with: day)
          }
          
          self.isPreferenceEdited = true
          
        }
        
        mondayPreference.onValueChanged = { [weak self] start, end in
          guard let self else { return }
          
          let formatter = DateFormatter()
          formatter.dateFormat = "HH:mm"
          print("Monday: ", formatter.string(from: start), " to ", formatter.string(from: end))
          
          if var day = workingHours.first(where: { $0.day == Weekday.monday.rawValue }) {
            day.startHour = start
            day.endHour = end
            
            workingHours.update(with: day)
          }
          
          self.isPreferenceEdited = true
            
        }
        
        tuesdayPreference.onValueChanged = { [weak self] start, end in
          guard let self else { return }
          
          let formatter = DateFormatter()
          formatter.dateFormat = "HH:mm"
          print("Tuesday: ", formatter.string(from: start), " to ", formatter.string(from: end))
          
          if var day = workingHours.first(where: { $0.day == Weekday.tuesday.rawValue }) {
            day.startHour = start
            day.endHour = end
            
            workingHours.update(with: day)
          }
          
          self.isPreferenceEdited = true
            
        }
        
        wednesdayPreference.onValueChanged = { [weak self] start, end in
          guard let self else { return }
          
          let formatter = DateFormatter()
          formatter.dateFormat = "HH:mm"
          print("Wednesday: ", formatter.string(from: start), " to ", formatter.string(from: end))
          
          if var day = workingHours.first(where: { $0.day == Weekday.wednesday.rawValue }) {
            day.startHour = start
            day.endHour = end
            
            workingHours.update(with: day)
          }
          
          self.isPreferenceEdited = true
          
        }
        
        thursdayPreference.onValueChanged = { [weak self] start, end in
          guard let self else { return }
          
          let formatter = DateFormatter()
          formatter.dateFormat = "HH:mm"
          print("Thursday: ", formatter.string(from: start), " to ", formatter.string(from: end))
          
          if var day = workingHours.first(where: { $0.day == Weekday.thursday.rawValue }) {
            day.startHour = start
            day.endHour = end
            
            workingHours.update(with: day)
          }
          
          self.isPreferenceEdited = true
          
        }
        
        fridayPreference.onValueChanged = { [weak self] start, end in
          guard let self else { return }
          
          let formatter = DateFormatter()
          formatter.dateFormat = "HH:mm"
          print("Friday: ", formatter.string(from: start), " to ", formatter.string(from: end))
          
          if var day = workingHours.first(where: { $0.day == Weekday.friday.rawValue }) {
            day.startHour = start
            day.endHour = end
            
            workingHours.update(with: day)
          }
          
          self.isPreferenceEdited = true
          
        }
        
        saturdayPreference.onValueChanged = { [weak self] start, end in
          guard let self else { return }
          
          let formatter = DateFormatter()
          formatter.dateFormat = "HH:mm"
          print("Saturday: ", formatter.string(from: start), " to ", formatter.string(from: end))
          
          if var day = workingHours.first(where: { $0.day == Weekday.saturday.rawValue }) {
            day.startHour = start
            day.endHour = end
            
            workingHours.update(with: day)
          }
          
          self.isPreferenceEdited = true
          
        }
    }
    
    private func configureReminderStack() {
        guard let userPreferenceData else { return }
        
        view.addSubview(reminderStack)
        
        let buttons = [ reminder30MinutesButton, reminder60MinutesButton, reminder90MinutesButton, reminder120MinutesButton ]
        let intervals = buttons.map { Int($0.title) }
        
        for button in buttons {
            button.target = self
            button.action = #selector(actionReminderHandler(_:))
            button.layer?.cornerRadius = 6
            
            button.setAccessibilityElement(true)
            button.setAccessibilityTitle("\(button.title) minutes")
            button.setAccessibilityLabel("Set the reminder interval to \(button.title) minutes")
            button.setAccessibilityRole(.button)
            
            button.snp.makeConstraints{button in
                button.width.equalTo(44)
                button.height.equalTo(30)
            }
        }
        
        // Handle the user preference for reminderInterval
        if let index = intervals.firstIndex(of: userPreferenceData.reminderInterval) {
          let correspondingButton = buttons[index]
            
          correspondingButton.isSelected = true
            correspondingButton.layer?.backgroundColor = NSColor.cNewButton.cgColor
            correspondingButton.foregroundColorText = .white
        }
        
        
        let everyLabel = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .regular, contentLabel: "Every")
        let minutesLabel = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .regular, contentLabel: "Minutes")
        
        let componentStack: NSStackView = NSStackView(views: [ everyLabel, reminder30MinutesButton, reminder60MinutesButton, reminder90MinutesButton, reminder120MinutesButton, minutesLabel ])
        componentStack.spacing = 16
        componentStack.alignment = .leading
        componentStack.orientation = .horizontal
        
        reminderStack.setViews([reminderLabel, componentStack], in: .center)
        reminderStack.spacing = 16
        reminderStack.alignment = .leading
        reminderStack.orientation = .vertical
        
        reminderStack.snp.makeConstraints { make in
            make.top.equalTo(settingText.snp.bottom).offset(26.67)
            //          make.leading.equalTo(subTitleA.snp.leading).offset(289.167)
            make.trailing.equalToSuperview().inset(33.34)
        }
    }
    
    func resetButtonColors() {
        // Reset all buttons to gray
        reminder30MinutesButton.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
        reminder60MinutesButton.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
        reminder90MinutesButton.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
        reminder120MinutesButton.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
        
        reminder30MinutesButton.foregroundColorText = .black
        reminder60MinutesButton.foregroundColorText = .black
        reminder90MinutesButton.foregroundColorText = .black
        reminder120MinutesButton.foregroundColorText = .black
        
        reminder30MinutesButton.isSelected = false
        reminder60MinutesButton.isSelected = false
        reminder90MinutesButton.isSelected = false
        reminder120MinutesButton.isSelected = false
    }
    
    func configureLaunchAtLoginCheckBox(){
        view.addSubview(launchAtLoginChecBox)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 22, weight: .bold),
            .foregroundColor: NSColor.black
        ]
        
        
        if ((userPreferenceData?.launchAtLogin) != nil){
            launchAtLoginChecBox.state = .on
            isFlexibleWorkHour = true
        } else{
            launchAtLoginChecBox.state = .off
        }
        
        let newState = launchAtLoginChecBox.state == .on ? "Checked" : "Unchecked"
        // Apply the attributed title
        launchAtLoginChecBox.attributedTitle = NSAttributedString(string: launchAtLoginChecBox.title, attributes: attributes)
        
        // Set the content tint color (optional, depending on what you want to achieve)
        launchAtLoginChecBox.contentTintColor = .blue
        launchAtLoginChecBox.target = self
        launchAtLoginChecBox.action = #selector(actionCheckbox)
        
        launchAtLoginChecBox.setAccessibilityElement(true)
        launchAtLoginChecBox.setAccessibilityTitle("Launch At StartUp")
        launchAtLoginChecBox.setAccessibilityLabel("Check this if you want to launch Climbr automatically on startup")
        launchAtLoginChecBox.setAccessibilityRole(.checkBox)
        
        launchAtLoginChecBox.setAccessibilityValue(newState)
        
        launchAtLoginChecBox.snp.makeConstraints{ check in
            check.leading.trailing.equalTo(reminderStack)
            check.top.equalTo(reminderStack.snp.bottom).offset(28)
        }
        
    }
    
    func configureSaveButton(){
        view.addSubview(saveButton)
        saveButton.isEnabled = false
        saveButton.target = self
        saveButton.action = #selector(actSaveButton)
        
        saveButton.setAccessibilityElement(true)
        saveButton.setAccessibilityTitle("\(saveButton.title)")
        saveButton.setAccessibilityLabel("Save your preference data")
        saveButton.setAccessibilityRole(.button)
        
        saveButton.snp.makeConstraints {next in
            next.trailing.equalTo(launchAtLoginChecBox)
            next.bottom.equalToSuperview().inset(16.67)
            next.width.equalTo(88.34)
            next.height.equalTo(42.5)
        }
    }

  func configureCancelButton(){
    view.addSubview(cancelButton)
    cancelButton.target = self
    cancelButton.action = #selector(actCancelButton)
    
    cancelButton.setAccessibilityElement(true)
    cancelButton.setAccessibilityTitle("\(cancelButton.title)")
    cancelButton.setAccessibilityLabel("Cancel and close the settings page")
    cancelButton.setAccessibilityRole(.button)
    
    cancelButton.snp.makeConstraints { make in
      make.trailing.equalTo(saveButton.snp.leading).offset(-20)
      make.bottom.height.equalTo(saveButton)
      make.width.equalTo(136)
    }
  }

}

//#Preview(traits: .defaultLayout, body: {
//    SettingVC()
//})
