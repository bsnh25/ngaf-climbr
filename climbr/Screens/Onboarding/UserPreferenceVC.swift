//
//  UserPreferenceVC.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 10/08/24.
//

import Cocoa
import Swinject
import SnapKit


class UserPreferenceVC: NSViewController, NSStackViewDelegate {
  
  private lazy var workHoursStack: NSStackView = NSStackView()
  private lazy var reminderStack: NSStackView = NSStackView()
  
  let bgContainer = NSView()
  let warnContainer = NSView()
  let boxContainer = NSView()
  let pathImage = NSImageView(image: .onboardingmountain)
  let appLogoImage = NSImageView(image: NSImage(resource: .appLogoWhite))
  let preferenceStackView = NSStackView()
  var preferenceStack: [NSView] = []
  
  let workHourItemView = DayTimePreferenceView(dayName: "Work Hours")
  let mondayPreference = DayTimePreferenceView(dayName: "Monday")
  let tuesdayPreference = DayTimePreferenceView(dayName: "Tuesday")
  let wednesdayPreference = DayTimePreferenceView(dayName: "Wednesday")
  let thursdayPreference = DayTimePreferenceView(dayName: "Thursday")
  let fridayPreference = DayTimePreferenceView(dayName: "Friday")
  let saturdayPreference = DayTimePreferenceView(dayName: "Saturday")
  let sundayPreference = DayTimePreferenceView(dayName: "Sunday")
  
  let daysButtonStack = DaysButtonStackView()
  
  let differentWorkHoursCheckbox = NSButton(checkboxWithTitle: "I have different daily work hours", target: nil, action: #selector(actionDifferentWorkHour))
  
  let reminderLabel = CLTextLabelV2(sizeOfFont: 18.3, weightOfFont: .bold, contentLabel: "Choose When do you want to be reminded")
  
  let reminder30MinutesButton = CLPickerButton(title: "30", backgroundColor: .white.withAlphaComponent(0.5), foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
  let reminder60MinutesButton = CLPickerButton(title: "60", backgroundColor: .white.withAlphaComponent(0.5), foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
  let reminder90MinutesButton = CLPickerButton(title: "90", backgroundColor: .white.withAlphaComponent(0.5), foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
  let reminder120MinutesButton = CLPickerButton(title: "120", backgroundColor: .white.withAlphaComponent(0.5), foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
  
  let launchAtLoginChecBox = NSButton(checkboxWithTitle: "Launch Limbr on startup", target: nil, action: #selector(actionCheckbox))
  
  
  
//  let workHoursLabel = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .bold, contentLabel: "Type in your work hours in a 24hr format")
//  let warnLabel = CLTextLabelV2(sizeOfFont: 16, weightOfFont: .light, contentLabel: "􀇾 Work hour should be more than 2 (two) hours")
  
  let nextButton = CLTextButtonV2(title: "Next", backgroundColor: .cButton, foregroundColorText: .white, fontText: .systemFont(ofSize: 26, weight: .bold))
  
  var workingHours: [WorkingHour] = []
  var lastStartValue: Date!
  var lastStopValue: Date!
  var isChecked: Bool = false
  var intervalReminder: Int64 = 0
  var charService: CharacterService?
  var notifService: NotificationService?
  
  
  init(charService: CharacterService?, notifService: NotificationService?) {
    super.init(nibName: nil, bundle: nil)
    self.charService = charService
    self.notifService = notifService
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureBgContainer()
    configureImagePath()
    configureAppLogo()
    configureBoxContainer()
    configureDifferentWorkHours()
    configureWorkHourItemView()
    configureDifferentWorkHoursStackView()
    configureWorkHoursStack()
    configureReminderStack()
    configureLaunchAtLoginCheckBox()
    configureNextButton()
  }
  
  override func viewDidAppear() {
    super.viewDidAppear()
    UserDefaults.standard.setValue(0, forKey: UserDefaultsKey.kProgressSession)
    UserDefaults.standard.setValue(0, forKey: UserDefaultsKey.kNotificationCount)
    daysButtonStack.daysButtonDelegate = self
    notifService?.askUserPermission()
  }
  
  private func configureWorkHoursStack() {
    boxContainer.addSubview(workHoursStack)
    
    
    let workDayLabel = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .bold, contentLabel: "Your Work Day:")
    
    workHoursStack.setViews([workDayLabel, daysButtonStack, differentWorkHoursCheckbox, workHourItemView, preferenceStackView], in: .center)
    workHoursStack.spacing = 16
    workHoursStack.alignment = .leading
    workHoursStack.orientation = .vertical
    
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
      
      button.snp.makeConstraints{button in
        button.width.equalTo(37.5)
        button.height.equalTo(25)
      }
    }
    
    
    let everyLabel = CLTextLabelV2(sizeOfFont: 18.3, weightOfFont: .regular, contentLabel: "Every")
    let minutesLabel = CLTextLabelV2(sizeOfFont: 18.3, weightOfFont: .regular, contentLabel: "Minutes")
    
    let componentStack: NSStackView = NSStackView(views: [ everyLabel, reminder30MinutesButton, reminder60MinutesButton, reminder90MinutesButton, reminder120MinutesButton, minutesLabel ])
    componentStack.spacing = 16
    componentStack.alignment = .leading
    componentStack.orientation = .horizontal
    
    reminderStack.setViews([reminderLabel, componentStack], in: .center)
    reminderStack.spacing = 16
    reminderStack.alignment = .leading
    reminderStack.orientation = .vertical
    
    reminderStack.snp.makeConstraints { make in
      make.top.equalTo(workHoursStack.snp.bottom).offset(28)
      make.leading.trailing.equalTo(workHoursStack)
    }
  }
  
  func configureBgContainer(){
    view.addSubview(bgContainer)
    bgContainer.wantsLayer = true
    bgContainer.layer?.backgroundColor = NSColor.onboardingBackground.cgColor
    bgContainer.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      bgContainer.topAnchor.constraint(equalTo: view.topAnchor),
      bgContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      bgContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      bgContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
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
  
  func configureImagePath(){
    view.addSubview(pathImage)
    pathImage.wantsLayer = true
    pathImage.translatesAutoresizingMaskIntoConstraints = false
    
    let padding = CGFloat(-1 * (view.bounds.width * 0.15))
    
    NSLayoutConstraint.activate([
      pathImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: padding),
      pathImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
  func configureAppLogo(){
    view.addSubview(appLogoImage)
    appLogoImage.translatesAutoresizingMaskIntoConstraints = false
    
    let width = CGFloat(1 * (view.frame.width * 0.475))
    print("width adalah: \(width)")
    
    NSLayoutConstraint.activate([
      appLogoImage.widthAnchor.constraint(equalToConstant: width),
      appLogoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 147),
      appLogoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    
  }
  
  func configureBoxContainer(){
    view.addSubview(boxContainer)
    
    boxContainer.wantsLayer = true
    boxContainer.translatesAutoresizingMaskIntoConstraints = false
    let blurEffect = CLBlurEffectView(frame: boxContainer.bounds)
    boxContainer.addSubview(blurEffect, positioned: .below, relativeTo: nil)
    
    boxContainer.snp.makeConstraints{ box in
      box.trailing.equalToSuperview()
      box.width.equalTo(439)
      box.height.equalToSuperview()
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
    differentWorkHoursCheckbox.contentTintColor = .white
    
    differentWorkHoursCheckbox.target = self
    differentWorkHoursCheckbox.action = #selector(actionDifferentWorkHour)
  }
  
  func configureWorkHourItemView(){
    workHourItemView.onValueChanged = { start, end in
      
      let formatter = DateFormatter()
      formatter.dateFormat = "HH:mm"
      print("Work Hours: ", formatter.string(from: start), " to ", formatter.string(from: end))
    }
  }
  
  func configureDifferentWorkHoursStackView(){
    let divider = Divider()
    preferenceStack = [
      //        Divider(),
      mondayPreference,
      //        Divider(),
      tuesdayPreference,
      //        Divider(),
      wednesdayPreference,
      //        Divider(),
      thursdayPreference,
      //        Divider(),
      fridayPreference,
      //        Divider(),
      saturdayPreference,
      //        Divider(),
      sundayPreference,
      //        Divider(),
    ]
    
    preferenceStackView.isHidden = true
    preferenceStackView.spacing = 16
    preferenceStackView.alignment = .leading
    
    preferenceStackView.setViews(preferenceStack, in: .center)
    preferenceStackView.orientation = .vertical
    preferenceStackView.distribution = .fillEqually
    
    for item in preferenceStack {
      if let item = item as? DayTimePreferenceView {
        item.isHidden = item.day != "Monday"
        
        item.snp.makeConstraints{item in
          item.height.equalTo(38.3)
        }
      }
    }
    
    mondayPreference.onValueChanged = { start, end in
      
      let formatter = DateFormatter()
      formatter.dateFormat = "HH:mm"
      print("Monday: ", formatter.string(from: start), " to ", formatter.string(from: end))
    }
    
    tuesdayPreference.onValueChanged = { start, end in
      
      let formatter = DateFormatter()
      formatter.dateFormat = "HH:mm"
      print("Tuesday: ", formatter.string(from: start), " to ", formatter.string(from: end))
    }
    
    wednesdayPreference.onValueChanged = { start, end in
      
      let formatter = DateFormatter()
      formatter.dateFormat = "HH:mm"
      print("Wednesday: ", formatter.string(from: start), " to ", formatter.string(from: end))
    }
    
    thursdayPreference.onValueChanged = { start, end in
      
      let formatter = DateFormatter()
      formatter.dateFormat = "HH:mm"
      print("Thursday: ", formatter.string(from: start), " to ", formatter.string(from: end))
    }
    
    fridayPreference.onValueChanged = { start, end in
      
      let formatter = DateFormatter()
      formatter.dateFormat = "HH:mm"
      print("Friday: ", formatter.string(from: start), " to ", formatter.string(from: end))
    }
    
    saturdayPreference.onValueChanged = { start, end in
      
      let formatter = DateFormatter()
      formatter.dateFormat = "HH:mm"
      print("Saturday: ", formatter.string(from: start), " to ", formatter.string(from: end))
    }
    
    sundayPreference.onValueChanged = { start, end in
      
      let formatter = DateFormatter()
      formatter.dateFormat = "HH:mm"
      print("Sunday: ", formatter.string(from: start), " to ", formatter.string(from: end))
    }
    
  }
  
  func configureLaunchAtLoginCheckBox(){
    view.addSubview(launchAtLoginChecBox)
    
    let attributes: [NSAttributedString.Key: Any] = [
      .font: NSFont.systemFont(ofSize: 18.34, weight: .bold),
      .foregroundColor: NSColor.black
    ]
    
    // Apply the attributed title
    launchAtLoginChecBox.attributedTitle = NSAttributedString(string: launchAtLoginChecBox.title, attributes: attributes)
    
    // Set the content tint color (optional, depending on what you want to achieve)
    launchAtLoginChecBox.contentTintColor = .blue
    if isChecked{
      launchAtLoginChecBox.state = .on
    } else {
      launchAtLoginChecBox.state = .off
    }
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
    nextButton.action = #selector(actNextButton)
    
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




//#Preview(traits: .defaultLayout, body: {
//    UserPreferenceVC()
//})
