//
//  UserPreferenceVC.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 10/08/24.
//

import Cocoa
import Swinject
import RiveRuntime
import SnapKit

class UserPreferenceVC: NSViewController, NSStackViewDelegate {
  
  private lazy var workHoursStack: NSStackView = NSStackView()
  private lazy var reminderStack: NSStackView = NSStackView()
  
//  let bgContainer = NSView()
  let warnContainer = NSView()
  let boxContainer = NSView()
//  let pathImage = NSImageView(image: .onboardingmountain)
//  let appLogoImage = NSImageView(image: NSImage(resource: .appLogoWhite))
  let preferenceStackView = NSStackView()
  var preferenceStack: [DayTimePreferenceView] = []
  
  let workHourItemView = DayTimePreferenceView(dayName: "Work Hours")
  let sundayPreference = DayTimePreferenceView(dayName: "Sunday")
  let mondayPreference = DayTimePreferenceView(dayName: "Monday")
  let tuesdayPreference = DayTimePreferenceView(dayName: "Tuesday")
  let wednesdayPreference = DayTimePreferenceView(dayName: "Wednesday")
  let thursdayPreference = DayTimePreferenceView(dayName: "Thursday")
  let fridayPreference = DayTimePreferenceView(dayName: "Friday")
  let saturdayPreference = DayTimePreferenceView(dayName: "Saturday")
  
  
  let daysButtonStack = DaysButtonStackView()
  
  let differentWorkHoursCheckbox = NSButton(checkboxWithTitle: "I have different daily work hours", target: nil, action: #selector(actionDifferentWorkHour))
  
  let reminderLabel = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .bold, contentLabel: "Choose When do you want to be reminded")
  
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
  
  let launchAtLoginChecBox = NSButton(checkboxWithTitle: "Launch Climbr on startup", target: nil, action: #selector(actionCheckbox))
  
  let nextButton = CLTextButtonV2(title: "Next", backgroundColor: .cButton, foregroundColorText: .white, fontText: .systemFont(ofSize: 26, weight: .bold))
  
  lazy var initialStartWorkHour: Date = {
    let calendar = Calendar.current
    
      var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
    components.hour = 8
    components.minute = 0
    
    return calendar.date(from: components)!
  }()
  
  lazy var initialEndWorkHour: Date = {
    initialStartWorkHour.addingTimeInterval(30 * 60)
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
  
  var isLaunchAtLogin: Bool = true
  var isFlexibleWorkHour: Bool = false
  var intervalReminder: Int = 0
  
  var charService: CharacterService = UserManager.shared
  var notifService: NotificationService = NotificationManager.shared
  
  private lazy var animationMain : RiveViewModel = {
    var anima: RiveViewModel = RiveViewModel(fileName: "splash_screen")
    anima.fit = .cover
    
    // Set background input to 1 (for onboarding)
    let background: Double = 1
    anima.setInput("background", value: background)
    
    return anima
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureBgContainer()
    configureBoxContainer()
    configureDifferentWorkHours()
    configureWorkHourItemView()
    configureDifferentWorkHoursStackView()
    configureWorkHoursStack()
    configureReminderStack()
    configureLaunchAtLoginCheckBox()
    configureNextButton()
    daysButtonStack.daysButtonDelegate = self
  }
  
  override func viewDidAppear() {
    super.viewDidAppear()
    UserDefaults.standard.setValue(0, forKey: UserDefaultsKey.kProgressSession)
    UserDefaults.standard.setValue(0, forKey: UserDefaultsKey.kNotificationCount)
  }
  
  func configureBgContainer(){
    
    let riveView = animationMain.createRiveView()
    
    view.addSubview(riveView)
    
    riveView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
//    view.addSubview(bgContainer)
//    bgContainer.wantsLayer = true
//    bgContainer.layer?.backgroundColor = NSColor.onboardingBackground.cgColor
//    bgContainer.translatesAutoresizingMaskIntoConstraints = false
//    
//    NSLayoutConstraint.activate([
//      bgContainer.topAnchor.constraint(equalTo: view.topAnchor),
//      bgContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//      bgContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//      bgContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//    ])
  }
  
  //    func configureWarning(){
  //        configureWarnContainer()
  //        configureWarnLabel()
  //    }
  
  //    func configureWarnContainer(){
  //        view.addSubview(warnContainer)
  //
  //        warnContainer.wantsLayer = true
  //        warnContainer.layer?.backgroundColor = NSColor.red.cgColor.copy(alpha: 0.9)
  //        warnContainer.layer?.cornerRadius = 10
  //        warnContainer.translatesAutoresizingMaskIntoConstraints = false
  //
  //        NSLayoutConstraint.activate([
  //            warnContainer.topAnchor.constraint(equalTo: workHoursLabel.topAnchor, constant: 43),
  //            warnContainer.leadingAnchor.constraint(equalTo: stopWorkHour.trailingAnchor, constant: 12),
  //            warnContainer.widthAnchor.constraint(equalToConstant: 360),
  //            warnContainer.heightAnchor.constraint(equalToConstant: 36)
  //        ])
  //
  //    }
  
  //    func configureWarnLabel(){
  //        warnContainer.addSubview(warnLabel)
  //        warnLabel.translatesAutoresizingMaskIntoConstraints = false
  //        warnLabel.textColor = .white
  //
  //        NSLayoutConstraint.activate([
  //            warnLabel.centerXAnchor.constraint(equalTo: warnContainer.centerXAnchor),
  //            warnLabel.centerYAnchor.constraint(equalTo: warnContainer.centerYAnchor)
  //        ])
  //    }
  
//  func configureImagePath(){
//    view.addSubview(pathImage)
//    pathImage.wantsLayer = true
//    pathImage.translatesAutoresizingMaskIntoConstraints = false
//    
//    let padding = CGFloat(-1 * (view.bounds.width * 0.15))
//    
//    NSLayoutConstraint.activate([
//      pathImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: padding),
//      pathImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//    ])
//  }
//  
//  func configureAppLogo(){
//    view.addSubview(appLogoImage)
//    appLogoImage.translatesAutoresizingMaskIntoConstraints = false
//    
//    let width = CGFloat(1 * (view.frame.width * 0.475))
//    print("width adalah: \(width)")
//    
//    NSLayoutConstraint.activate([
//      appLogoImage.widthAnchor.constraint(equalToConstant: width),
//      appLogoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 147),
//      appLogoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//    ])
//    
//  }
  
  func configureBoxContainer(){
    view.addSubview(boxContainer)
    
    boxContainer.wantsLayer = true
    boxContainer.translatesAutoresizingMaskIntoConstraints = false
    let blurEffect = CLBlurEffectView(frame: boxContainer.bounds)
    boxContainer.addSubview(blurEffect, positioned: .below, relativeTo: nil)
    
    boxContainer.snp.makeConstraints{ box in
      box.trailing.equalToSuperview()
      box.width.equalTo(439)
      box.top.height.equalToSuperview()
    }
  }
  
  private func configureWorkHoursStack() {
    boxContainer.addSubview(workHoursStack)
    
    
    let workDayLabel = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .bold, contentLabel: "Your Work Day:")
    
    workHoursStack.setViews([workDayLabel, daysButtonStack, differentWorkHoursCheckbox, workHourItemView, preferenceStackView], in: .center)
    workHoursStack.spacing = 16
    workHoursStack.alignment = .leading
    workHoursStack.orientation = .vertical
    
    workHourItemView.setAccessibilityElement(true)
    workHourItemView.setAccessibilityTitle("Work Hours")
    workHourItemView.setAccessibilityLabel("Set the start and end work hours")
    
    workHoursStack.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(20)
      make.leading.trailing.equalToSuperview().inset(40)
    }
  }
  
  private func configureReminderStack() {
    boxContainer.addSubview(reminderStack)
    
    let buttons = [ reminder30MinutesButton, reminder60MinutesButton, reminder90MinutesButton, reminder120MinutesButton ]
    
    for button in buttons {
      button.target = self
      button.action = #selector(actionReminderHandler)
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
    
    
    let everyLabel = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .regular, contentLabel: "Every")
    let minutesLabel = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .regular, contentLabel: "Minutes")
    
    let componentStack: NSStackView = NSStackView(views: [ everyLabel, reminder30MinutesButton, reminder60MinutesButton, reminder90MinutesButton, reminder120MinutesButton, minutesLabel ])
    componentStack.spacing = 14
    componentStack.alignment = .leading
    componentStack.orientation = .horizontal
    
    reminderStack.setViews([reminderLabel, componentStack], in: .center)
    reminderStack.spacing = 16
    reminderStack.alignment = .leading
    reminderStack.orientation = .vertical
    
    reminderStack.snp.makeConstraints { make in
      make.top.equalTo(workHoursStack.snp.bottom).offset(28)
        make.leading.equalTo(workHoursStack.snp.leading)
        make.trailing.equalTo(workHoursStack.snp.trailing)
    }
  }
  
  
  func configureDifferentWorkHours(){
    
    let attributes: [NSAttributedString.Key: Any] = [
      .font: NSFont.systemFont(ofSize: 17, weight: .bold),
      .foregroundColor: NSColor.black
    ]
    
    // Apply the attributed title
    differentWorkHoursCheckbox.attributedTitle = NSAttributedString(string: differentWorkHoursCheckbox.title, attributes: attributes)
    
    
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
    workHourItemView.onValueChanged = { start, end in
      
      let formatter = DateFormatter()
      formatter.dateFormat = "HH:mm"
      print("Work Hours: ", formatter.string(from: start), " to ", formatter.string(from: end))
      
      for item in self.workingHours {
        let data = WorkingHour(startHour: start, endHour: end, day: item.day)
        
        self.workingHours.update(with: data)
      }
      
    }
  }
  
  func configureDifferentWorkHoursStackView(){
    let divider = Divider()
    preferenceStack = [
        sundayPreference,
//              Divider(),
      mondayPreference,
//              Divider(),
      tuesdayPreference,
//              Divider(),
      wednesdayPreference,
//              Divider(),
      thursdayPreference,
//              Divider(),
      fridayPreference,
//              Divider(),
      saturdayPreference,
    ]
    
    preferenceStackView.isHidden = true
    preferenceStackView.spacing = 16
    preferenceStackView.alignment = .leading
    
    preferenceStackView.setViews(preferenceStack, in: .center)
    preferenceStackView.orientation = .vertical
    preferenceStackView.distribution = .fillEqually
    
    for item in preferenceStack {
      item.isHidden = item.day != "Sunday"
      item.initialStartValue = initialStartWorkHour
      item.initialEndValue = initialEndWorkHour
      item.snp.makeConstraints{item in
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
    }
    
    
  }
  
  func configureLaunchAtLoginCheckBox(){
    view.addSubview(launchAtLoginChecBox)
    
    let attributes: [NSAttributedString.Key: Any] = [
      .font: NSFont.systemFont(ofSize: 17, weight: .bold),
      .foregroundColor: NSColor.black
    ]
    
    // Apply the attributed title
    launchAtLoginChecBox.attributedTitle = NSAttributedString(string: launchAtLoginChecBox.title, attributes: attributes)
    
    // Set the content tint color (optional, depending on what you want to achieve)
    launchAtLoginChecBox.contentTintColor = .blue
    launchAtLoginChecBox.state = .on
    launchAtLoginChecBox.target = self
    launchAtLoginChecBox.action = #selector(actionCheckbox)
    
    launchAtLoginChecBox.setAccessibilityElement(true)
    launchAtLoginChecBox.setAccessibilityTitle("Launch At StartUp")
    launchAtLoginChecBox.setAccessibilityLabel("Check this if you want to launch Climbr automatically on startup")
    launchAtLoginChecBox.setAccessibilityRole(.checkBox)
    
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
    nextButton.action = #selector(actNextButton)
      
      nextButton.setAccessibilityElement(true)
      nextButton.setAccessibilityTitle("\(nextButton.title)")
      nextButton.setAccessibilityLabel("Save your preference and go to the next page")
      nextButton.setAccessibilityRole(.button)
    
    nextButton.snp.makeConstraints {next in
      next.trailing.equalTo(launchAtLoginChecBox)
      next.top.equalTo(launchAtLoginChecBox.snp.bottom).offset(28)
      next.width.equalTo(88.34)
      next.height.equalTo(42.5)
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
}
