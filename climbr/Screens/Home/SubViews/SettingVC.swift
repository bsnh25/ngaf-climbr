//
//  SettingsVC.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 09/08/24.
//

import AppKit
import SnapKit


//class SettingWC: NSWindowController {
//
//    init(contentVC: NSViewController) {
//        let window = NSWindow(contentViewController: contentVC)
//        window.titleVisibility = .visible
//        window.styleMask.remove(.titled)
//        window.styleMask.remove(.miniaturizable)
//        window.styleMask.remove(.resizable)
//        window.styleMask.insert(.closable)
//
//        super.init(window: window)
//
//        window.level = .modalPanel
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}




class SettingVC: NSViewController {
    
    private lazy var workHoursStack: NSStackView = NSStackView()
    private lazy var reminderStack: NSStackView = NSStackView()
    
    let settingText = CLTextLabelV2(
        sizeOfFont: 22,
        weightOfFont: .bold,
        contentLabel: "User Preference"
    )
    let subTitleA = CLTextLabelV2(
        sizeOfFont: 17,
        weightOfFont: .bold,
        contentLabel: "Your Work Days"
    )
    
    let preferenceStackView = NSStackView()
    let differentWorkHoursCheckbox = NSButton(checkboxWithTitle: "I have different daily work hours", target: nil, action: #selector(actionDifferentWorkHour))
    let daysButtonStack = DaysButtonStackView()
    let workHourItemView = DayTimePreferenceView(dayName: "Work Hours")
    let sundayPreference = DayTimePreferenceView(dayName: "Sunday")
    let mondayPreference = DayTimePreferenceView(dayName: "Monday")
    let tuesdayPreference = DayTimePreferenceView(dayName: "Tuesday")
    let wednesdayPreference = DayTimePreferenceView(dayName: "Wednesday")
    let thursdayPreference = DayTimePreferenceView(dayName: "Thursday")
    let fridayPreference = DayTimePreferenceView(dayName: "Friday")
    let saturdayPreference = DayTimePreferenceView(dayName: "Saturday")
    
    var preferenceStack: [DayTimePreferenceView] = []
    var isFlexibleWorkHour: Bool = false
    
    
    lazy var initialStartWorkHour: Date = {
        let calendar = Calendar.current
        
        var components = calendar.dateComponents([.hour, .minute], from: Date())
        components.hour = 8
        components.minute = 0
        
        return calendar.date(from: components)!
    }()
    
    lazy var initialEndWorkHour: Date = {
        initialStartWorkHour.addingTimeInterval(2 * 60 * 60)
    }()
    
    lazy var workingHours: Set<WorkingHour> = [
        WorkingHour(startHour: initialStartWorkHour, endHour: initialEndWorkHour, day: Weekday.sunday.rawValue),
        WorkingHour(startHour: initialStartWorkHour, endHour: initialEndWorkHour, day: Weekday.monday.rawValue),
        WorkingHour(startHour: initialStartWorkHour, endHour: initialEndWorkHour, day: Weekday.tuesday.rawValue),
        WorkingHour(startHour: initialStartWorkHour, endHour: initialEndWorkHour, day: Weekday.wednesday.rawValue),
        WorkingHour(startHour: initialStartWorkHour, endHour: initialEndWorkHour, day: Weekday.thursday.rawValue),
        WorkingHour(startHour: initialStartWorkHour, endHour: initialEndWorkHour, day: Weekday.friday.rawValue),
        WorkingHour(startHour: initialStartWorkHour, endHour: initialEndWorkHour, day: Weekday.saturday.rawValue),
    ]
    
    let reminder30MinutesButton = CLPickerButton(
        title: "30",
        backgroundColor: .white.withAlphaComponent(0.5),
        foregroundColorText: .black,
        fontText: .boldSystemFont(ofSize: 17)
    )
    let reminder60MinutesButton = CLPickerButton(
        title: "60",
        backgroundColor: .white.withAlphaComponent(0.5),
        foregroundColorText: .black,
        fontText: .boldSystemFont(ofSize: 17)
    )
    let reminder90MinutesButton = CLPickerButton(
        title: "90",
        backgroundColor: .white.withAlphaComponent(0.5),
        foregroundColorText: .black,
        fontText: .boldSystemFont(ofSize: 17)
    )
    let reminder120MinutesButton = CLPickerButton(
        title: "120",
        backgroundColor: .white.withAlphaComponent(0.5),
        foregroundColorText: .black,
        fontText: .boldSystemFont(ofSize: 17)
    )
    var intervalReminder: Int = 0
    let launchAtLoginChecBox = NSButton(checkboxWithTitle: "Launch Limbr on startup", target: nil, action: #selector(actionCheckbox))
    var isLaunchAtLogin: Bool = false
    let nextButton = CLTextButtonV2(title: "Save", backgroundColor: .cButton, foregroundColorText: .white, fontText: .systemFont(ofSize: 26, weight: .bold))
    
    
    let reminderLabel = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .bold, contentLabel: "Choose When do you want to be reminded")
    
    let fromText = CLTextLabelV2(
        sizeOfFont: 17,
        weightOfFont: .regular,
        contentLabel: "From"
    )
    
    let everyText = CLTextLabelV2(
        sizeOfFont: 17,
        weightOfFont: .regular,
        contentLabel: "Every"
    )
    
    let minutesText = CLTextLabelV2(
        sizeOfFont: 17,
        weightOfFont: .regular,
        contentLabel: "minutes"
    )
    
    
    let warnContainer = NSView()
    let warnLabel = CLTextLabelV2(sizeOfFont: 14, weightOfFont: .light, contentLabel: "􀇾 Can’t be less than 2 (two) hours")
    
    
    var notifService: NotificationService = NotificationManager.shared
    var charService: CharacterService = UserManager.shared
    var userPreferenceData: UserPreferenceModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.cBox.cgColor.copy(alpha: 0.84)
        
        userPreferenceData = charService.getPreferences()
        configure()
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        // Check if the view is hosted in a window
        if let window = self.view.window {
            // Remove the minimize button
            window.styleMask.remove(.miniaturizable)
            window.titleVisibility = .hidden
            
            // Optionally, remove the close and zoom buttons
            // window.styleMask.remove(.closable)
            window.styleMask.remove(.resizable)
        }
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
        configureNextButton()
        
        daysButtonStack.daysButtonDelegate = self
    }
    
    func configureSettingTitle(){
        view.addSubview(settingText)
        
        settingText.snp.makeConstraints{setting in
            setting.top.equalTo(view.snp.top).inset(16.67)
            setting.leading.equalTo(view.snp.leading).inset(33.34)
            setting.trailing.equalTo(635)
        }
        
        
    }
    
    func configureYourWorkDaysText(){
        view.addSubview(subTitleA)
        
        subTitleA.snp.makeConstraints{subTitle in
            subTitle.top.equalTo(settingText.snp.bottom).offset(26.67)
            subTitle.leading.equalTo(view.snp.leading).inset(33.34)
        }
    }
    
    func configureWorkHoursStack() {
        view.addSubview(workHoursStack)
        
        // Add views to the workHoursStack
        workHoursStack.setViews([daysButtonStack, differentWorkHoursCheckbox, workHourItemView, preferenceStackView], in: .center)
        workHoursStack.spacing = 16
        workHoursStack.alignment = .leading
        workHoursStack.orientation = .vertical
        
        if let userPreference = userPreferenceData {
            if userPreference.isFlexibleWorkHour {
                isFlexibleWorkHour = true
                differentWorkHoursCheckbox.state = .on
                // Unlock the day buttons
                daysButtonStack.unlockButton()
                daysButtonStack.sunday.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
                daysButtonStack.sunday.foregroundColorText = .black
                daysButtonStack.sunday.isSelected = false
                
                // Show the preference stack view
                workHourItemView.isHidden = true
                
                preferenceStackView.isHidden = false
                
                // Loop through the working hours and update preferences accordingly
                for workingHour in userPreference.workingHours {
                    if workingHour.isEnabled {
                        // Find the corresponding day index and preference view
                        let dayIndex = workingHour.day
                        if let dayPreference = getDayPreference(for: dayIndex) {
                            // Enable the button for the corresponding day
                            let button = daysButtonStack.daysButtonStack[dayIndex]
                            button.isSelected = true
                            button.isEnabled = true
                            button.layer?.backgroundColor = NSColor.cNewButton.cgColor
                            button.foregroundColorText = .white
                            
                            // Update the start and end hours in the DayTimePreferenceView
                            dayPreference.startWorkPicker.dateValue = workingHour.startHour
                            dayPreference.endWorkPicker.dateValue = workingHour.endHour
                            dayPreference.isHidden = false
                            workingHours.update(with: workingHour)
                        }
                    }
                }
            } else {
                isFlexibleWorkHour = false
                differentWorkHoursCheckbox.state = .off
                daysButtonStack.lockButton()
                preferenceStackView.isHidden = true  // Hide the preferences if not flexible
                
                workHourItemView.startWorkPicker.dateValue = userPreference.workingHours.first!.startHour
                workHourItemView.endWorkPicker.dateValue = userPreference.workingHours.first!.endHour
                
                for workingHour in userPreference.workingHours {
                    workingHours.update(with: workingHour)
                }
            }
        }
        
        // Set constraints for the stack
        workHoursStack.snp.makeConstraints { make in
            make.top.equalTo(subTitleA.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(40)
        }
    }
    
    func getDayPreference(for dayIndex: Int) -> DayTimePreferenceView? {
        switch dayIndex {
        case 0: return sundayPreference
        case 1: return mondayPreference
        case 2: return tuesdayPreference
        case 3: return wednesdayPreference
        case 4: return thursdayPreference
        case 5: return fridayPreference
        case 6: return saturdayPreference
        default: return nil
        }
    }
    
    func configureDifferentWorkHours(){
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 22, weight: .bold),
            .foregroundColor: NSColor.black
        ]
        
        
        // Apply the attributed title
        differentWorkHoursCheckbox.attributedTitle = NSAttributedString(string: differentWorkHoursCheckbox.title, attributes: attributes)
        
        // Set the content tint color (optional, depending on what you want to achieve)
        differentWorkHoursCheckbox.contentTintColor = .blue
        
        differentWorkHoursCheckbox.target = self
        differentWorkHoursCheckbox.action = #selector(actionDifferentWorkHour)
    }
    
    func configureWorkHourItemView(){
        workHourItemView.onValueChanged = { start, end in
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            print("Work Hours: ", formatter.string(from: start), " to ", formatter.string(from: end))
            
            for item in self.workingHours {
                let data = WorkingHour(startHour: start, endHour: end, day: item.day)
                
                self.workingHours.update(with: data)
            }
            
            self.nextButton.isEnabled = true
        }
        
        workHourItemView.snp.makeConstraints{item in
            item.width.equalTo(372.5)
            item.height.equalTo(38.3)
        }
    }
    
    func configureDifferentWorkHoursStackView(){
        let divider = Divider()
        preferenceStack = [
            sundayPreference,
            mondayPreference,
            tuesdayPreference,
            wednesdayPreference,
            thursdayPreference,
            fridayPreference,
            saturdayPreference,
        ]
        
        preferenceStackView.isHidden = true
        preferenceStackView.spacing = 16
        preferenceStackView.alignment = .leading
        
        preferenceStackView.setViews(preferenceStack, in: .center)
        preferenceStackView.orientation = .vertical
        preferenceStackView.distribution = .fillEqually
        
        for item in preferenceStack {
            item.isHidden = true
          item.initialStartValue = initialStartWorkHour
          item.initialEndValue = initialEndWorkHour
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
            
            self.nextButton.isEnabled = true
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
            
            self.nextButton.isEnabled = true
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
            
            self.nextButton.isEnabled = true
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
            self.nextButton.isEnabled = true
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
            self.nextButton.isEnabled = true
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
            self.nextButton.isEnabled = true
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
            self.nextButton.isEnabled = true
        }
    }
    
    private func configureReminderStack() {
        view.addSubview(reminderStack)
        
        let buttons = [ reminder30MinutesButton, reminder60MinutesButton, reminder90MinutesButton, reminder120MinutesButton ]
        let intervals = [30, 60, 90, 120]
        
        for button in buttons {
            button.target = self
            button.action = #selector(actionReminderHandler(_:))
            button.layer?.cornerRadius = 6
            
            button.snp.makeConstraints{button in
                button.width.equalTo(44)
                button.height.equalTo(30)
            }
        }
        
        // Handle the user preference for reminderInterval
        if let interval = userPreferenceData?.reminderInterval {
            if let index = intervals.firstIndex(of: interval) {
                let correspondingButton = buttons[index]
                
                // Programmatically trigger the action as if the user pressed the button
                actionReminderHandler(correspondingButton)
            }
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
        } else{
            launchAtLoginChecBox.state = .off
        }
        
        // Apply the attributed title
        launchAtLoginChecBox.attributedTitle = NSAttributedString(string: launchAtLoginChecBox.title, attributes: attributes)
        
        // Set the content tint color (optional, depending on what you want to achieve)
        launchAtLoginChecBox.contentTintColor = .blue
        launchAtLoginChecBox.target = self
        launchAtLoginChecBox.action = #selector(actionCheckbox)
        
        launchAtLoginChecBox.snp.makeConstraints{ check in
            check.leading.trailing.equalTo(reminderStack)
            check.top.equalTo(reminderStack.snp.bottom).offset(28)
        }
        
    }
    
    func configureNextButton(){
        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.isEnabled = false
        nextButton.target = self
        nextButton.action = #selector(actSaveButton)
        
        nextButton.snp.makeConstraints {next in
            next.trailing.equalTo(launchAtLoginChecBox)
            next.bottom.equalToSuperview().inset(16.67)
            next.width.equalTo(88.34)
            next.height.equalTo(42.5)
        }
    }
    
}

//#Preview(traits: .defaultLayout, body: {
//    SettingVC()
//})
