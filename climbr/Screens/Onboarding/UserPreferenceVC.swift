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
    
    let bgContainer = NSView()
    let warnContainer = NSView()
    let boxContainer = NSView()
    let pathImage = NSImageView(image: .onboardingmountain)
    let appLogoImage = NSImageView(image: NSImage(resource: .appLogoWhite))
    let preferenceStackView = NSStackView()
    var preferenceStack: [DayTimePreferenceView] = []
    let samePreference = DayTimePreferenceView(dayName: "Work Hours", startWorkPicker: CLDatePicker(backgroundColor: .white.withAlphaComponent(0.5), textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 18.3)), endWorkPicker: CLDatePicker(backgroundColor: .white.withAlphaComponent(0.5), textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 18.3)), gapTextAndPicker: 84.167)
    let mondayPreference = DayTimePreferenceView(dayName: "Monday", startWorkPicker: CLDatePicker(backgroundColor: .white.withAlphaComponent(0.5), textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 18.3)), endWorkPicker: CLDatePicker(backgroundColor: .white.withAlphaComponent(0.5), textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 18.3)), gapTextAndPicker: 115)
    let tuesdayPreference = DayTimePreferenceView(dayName: "Tuesday", startWorkPicker: CLDatePicker(backgroundColor: .white.withAlphaComponent(0.5), textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 18.3)), endWorkPicker: CLDatePicker(backgroundColor: .white.withAlphaComponent(0.5), textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 18.3)), gapTextAndPicker: 113)
    let wednesdayPreference = DayTimePreferenceView(dayName: "Wednesday", startWorkPicker: CLDatePicker(backgroundColor: .white.withAlphaComponent(0.5), textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 18.3)), endWorkPicker: CLDatePicker(backgroundColor: .white.withAlphaComponent(0.5), textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 18.3)), gapTextAndPicker: 85)
    let thursdayPreference = DayTimePreferenceView(dayName: "Thursday", startWorkPicker: CLDatePicker(backgroundColor: .white.withAlphaComponent(0.5), textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 18.3)), endWorkPicker: CLDatePicker(backgroundColor: .white.withAlphaComponent(0.5), textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 18.3)), gapTextAndPicker: 104)
    let fridayPreference = DayTimePreferenceView(dayName: "Friday", startWorkPicker: CLDatePicker(backgroundColor: .white.withAlphaComponent(0.5), textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 18.3)), endWorkPicker: CLDatePicker(backgroundColor: .white.withAlphaComponent(0.5), textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 18.3)), gapTextAndPicker: 131)
    let saturdayPreference = DayTimePreferenceView(dayName: "Saturday", startWorkPicker: CLDatePicker(backgroundColor: .white.withAlphaComponent(0.5), textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 18.3)), endWorkPicker: CLDatePicker(backgroundColor: .white.withAlphaComponent(0.5), textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 18.3)), gapTextAndPicker: 107)
    let sundayPreference = DayTimePreferenceView(dayName: "Sunday", startWorkPicker: CLDatePicker(backgroundColor: .white.withAlphaComponent(0.5), textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 18.3)), endWorkPicker: CLDatePicker(backgroundColor: .white.withAlphaComponent(0.5), textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 18.3)), gapTextAndPicker: 120)
    let textUrWorkDay = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .bold, contentLabel: "Your Work Day:")
    let daysButtonStack = DaysButtonStackView()
    let differentWorkHoursCheckbox = NSButton(checkboxWithTitle: "I have different daily work hours", target: nil, action: #selector(actionDifferentWorkHour))
    let reminderLabel = CLTextLabelV2(sizeOfFont: 18.3, weightOfFont: .bold, contentLabel: "Choose When do you want to be reminded")
    let text1Line2 = CLTextLabelV2(sizeOfFont: 18.3, weightOfFont: .regular, contentLabel: "Every")
    let text2Line2 = CLTextLabelV2(sizeOfFont: 18.3, weightOfFont: .regular, contentLabel: "Minutes")
    var isDifferentChecked: Bool = false
    let button1 = CLPickerButton(title: "30", backgroundColor: .white.withAlphaComponent(0.5), foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    let button2 = CLPickerButton(title: "60", backgroundColor: .white.withAlphaComponent(0.5), foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    let button3 = CLPickerButton(title: "90", backgroundColor: .white.withAlphaComponent(0.5), foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    let button4 = CLPickerButton(title: "120", backgroundColor: .white.withAlphaComponent(0.5), foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    let checkboxButton = NSButton(checkboxWithTitle: "Launch Limbr on startup", target: nil, action: #selector(actionCheckbox))
    
    
    
    let workHoursLabel = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .bold, contentLabel: "Type in your work hours in a 24hr format")
    let warnLabel = CLTextLabelV2(sizeOfFont: 16, weightOfFont: .light, contentLabel: "􀇾 Work hour should be more than 2 (two) hours")
    let nextButton = CLTextButtonV2(title: "Next", backgroundColor: .cButton, foregroundColorText: .white, fontText: .systemFont(ofSize: 26, weight: .bold))
    let text1Line1 = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .regular, contentLabel: "From")
    let text2Line1 = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .regular, contentLabel: "To")
    
    let startWorkHour = CLDatePicker(backgroundColor: .white.withAlphaComponent(0.5), textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 20))
    let stopWorkHour = CLDatePicker(backgroundColor: .white.withAlphaComponent(0.5), textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 20))
    
    
    
    
    
    
    
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
        configure()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        UserDefaults.standard.setValue(0, forKey: UserDefaultsKey.kProgressSession)
        UserDefaults.standard.setValue(0, forKey: UserDefaultsKey.kNotificationCount)
        daysButtonStack.daysButtonDelegate = self
        notifService?.askUserPermission()
    }
    
    
    func configure(){
        configureBgContainer()
        configureImagePath()
        configureAppLogo()
        configureBoxContainer()
        configureTextUrWorkDay()
        configureDaysButtonStackView()
        configureDifferentWorkHours()
        configureSamePreference()
        configureReminderLabel(anchorObject: samePreference)
        configureText1Line2()
        configureButton1()
        configureButton2()
        configureButton3()
        configureButton4()
        configureText2Line2()
        configureCheckBox()
        configureNextButton()
        
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
    
    
    func configureTextUrWorkDay(){
        view.addSubview(textUrWorkDay)
        
        textUrWorkDay.snp.makeConstraints{urWork in
            urWork.top.equalTo(boxContainer.snp.top).offset(20)
            urWork.leading.equalTo(boxContainer.snp.leading).offset(40)
        }
    }
    
    func configureDaysButtonStackView(){
        view.addSubview(daysButtonStack)
        
        daysButtonStack.snp.makeConstraints{days in
            days.top.equalTo(textUrWorkDay.snp.bottom).offset(13.4)
            days.leading.equalTo(boxContainer.snp.leading).offset(33.4)
        }
    }
    
    func configureDifferentWorkHours(){
        view.addSubview(differentWorkHoursCheckbox)
        differentWorkHoursCheckbox.translatesAutoresizingMaskIntoConstraints = false
       
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 22, weight: .bold),
            .foregroundColor: NSColor.black
        ]
        
        // Apply the attributed title
        differentWorkHoursCheckbox.attributedTitle = NSAttributedString(string: differentWorkHoursCheckbox.title, attributes: attributes)
        
        // Set the content tint color (optional, depending on what you want to achieve)
        differentWorkHoursCheckbox.contentTintColor = .white
        
        if isDifferentChecked{
            differentWorkHoursCheckbox.state = .on
        } else {
            differentWorkHoursCheckbox.state = .off
        }
        differentWorkHoursCheckbox.target = self
        differentWorkHoursCheckbox.action = #selector(actionDifferentWorkHour)
        
        differentWorkHoursCheckbox.snp.makeConstraints{ different in
            different.top.equalTo(daysButtonStack.snp.bottom).offset(13.4)
            different.leading.equalTo(boxContainer.snp.leading).offset(33.4)
        }
    }
    
    func configureSamePreference(){
        view.addSubview(samePreference)
        samePreference.translatesAutoresizingMaskIntoConstraints = false
        
        samePreference.snp.makeConstraints{ same in
            same.top.equalTo(differentWorkHoursCheckbox.snp.bottom).offset(30)
            same.leading.equalTo(boxContainer.snp.leading).offset(33.4)
            same.height.equalTo(38.3)
        }
    }
    
    func removeSamePreference(){
        samePreference.removeFromSuperview()
    }
    
    func addTappedDays(dayPreference day: DayTimePreferenceView){
        preferenceStack.append(day)
        print("ini stack Days: \(preferenceStack)")
    }
    
    func removeTappedDays(dayPreference day: DayTimePreferenceView){
        preferenceStack.removeAll(where: { $0 === day })
    }
    
    
    func showDaysPreferences(){
        preferenceStack = [mondayPreference, tuesdayPreference, wednesdayPreference, thursdayPreference, fridayPreference, saturdayPreference, sundayPreference]
        
        preferenceStackView.spacing = 15
        preferenceStackView.alignment = .leading
        preferenceStackView.clipsToBounds = false
        
        preferenceStackView.setViews(preferenceStack, in: .top)
        preferenceStackView.orientation = .vertical
        
        for item in preferenceStack{
            item.wantsLayer = true
            item.translatesAutoresizingMaskIntoConstraints = false
            item.isHidden = item.dayName.stringValue != "Monday"
            
            
            item.snp.makeConstraints{item in
                item.height.equalTo(38.3)
            }
        }
        
        view.addSubview(preferenceStackView)
        preferenceStackView.translatesAutoresizingMaskIntoConstraints = false
        preferenceStackView.snp.makeConstraints{stack in
            stack.top.equalTo(differentWorkHoursCheckbox.snp.bottom).offset(30)
            stack.leading.equalTo(boxContainer.snp.leading).offset(33.4)
        }
    }
    
    func configureReminderLabel(anchorObject view: NSView){
        view.addSubview(reminderLabel)
        reminderLabel.translatesAutoresizingMaskIntoConstraints = false
        reminderLabel.textColor = .black
        
        reminderLabel.snp.makeConstraints{ reminder in
            reminder.top.equalTo(view.snp.bottom).offset(32.525)
            reminder.leading.equalTo(boxContainer.snp.leading).offset(33.4)
        }
    }
    
    func configureText1Line2(){
        view.addSubview(text1Line2)
        text1Line2.translatesAutoresizingMaskIntoConstraints = false
        text1Line2.textColor = .black
        
        text1Line2.snp.makeConstraints{every in
            every.top.equalTo(reminderLabel.snp.bottom).offset(10)
            every.leading.equalTo(boxContainer.snp.leading).offset(33.4)
        }
    }
    
    func configureButton1(){
        view.addSubview(button1)
        button1.target = self
        button1.action = #selector(action30min)
        
        button1.snp.makeConstraints{button in
            button.top.equalTo(reminderLabel.snp.bottom).offset(8.34)
            button.leading.equalTo(text1Line2.snp.trailing).offset(13.3)
            button.width.equalTo(37.5)
            button.height.equalTo(25)
        }
    }
    
    func configureButton2(){
        view.addSubview(button2)
        button2.target = self
        button2.action = #selector(action60min)
        
        button2.snp.makeConstraints{button in
            button.top.equalTo(reminderLabel.snp.bottom).offset(8.34)
            button.leading.equalTo(button1.snp.trailing).offset(15.834)
            button.width.equalTo(37.5)
            button.height.equalTo(25)
        }
    }
    
    func configureButton3(){
        view.addSubview(button3)
        button3.target = self
        button3.action = #selector(action90min)
        
        button3.snp.makeConstraints{button in
            button.top.equalTo(reminderLabel.snp.bottom).offset(8.34)
            button.leading.equalTo(button2.snp.trailing).offset(15.834)
            button.width.equalTo(37.5)
            button.height.equalTo(25)
        }
    }
    
    func configureButton4(){
        view.addSubview(button4)
        button4.target = self
        button4.action = #selector(action120min)
        
        button4.snp.makeConstraints{button in
            button.top.equalTo(reminderLabel.snp.bottom).offset(8.34)
            button.leading.equalTo(button3.snp.trailing).offset(15.834)
            button.width.equalTo(37.5)
            button.height.equalTo(25)
        }
    }
    
    func configureText2Line2(){
        view.addSubview(text2Line2)
        text2Line2.translatesAutoresizingMaskIntoConstraints = false
        text2Line2.textColor = .black
        
        text2Line2.snp.makeConstraints{button in
            button.top.equalTo(reminderLabel.snp.bottom).offset(8.34)
            button.leading.equalTo(button4.snp.trailing).offset(13.3)
        }
    }
    
    func removeDaysPreferences(){
        preferenceStackView.removeFromSuperview()
    }
    
    func removeUnderDaysPreference(){
        reminderLabel.removeFromSuperview()
        text1Line2.removeFromSuperview()
        button1.removeFromSuperview()
        button2.removeFromSuperview()
        button3.removeFromSuperview()
        button4.removeFromSuperview()
        text2Line2.removeFromSuperview()
        checkboxButton.removeFromSuperview()
    }
    
    func configureCheckBox(){
        view.addSubview(checkboxButton)
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 18.34, weight: .bold),
            .foregroundColor: NSColor.black
        ]
        
        // Apply the attributed title
        checkboxButton.attributedTitle = NSAttributedString(string: checkboxButton.title, attributes: attributes)
        
        // Set the content tint color (optional, depending on what you want to achieve)
        checkboxButton.contentTintColor = .blue
        if isChecked{
            checkboxButton.state = .on
        } else {
            checkboxButton.state = .off
        }
        checkboxButton.target = self
        checkboxButton.action = #selector(actionCheckbox)
        
        checkboxButton.snp.makeConstraints{ check in
            check.leading.equalTo(boxContainer.snp.leading).offset(33.4)
            check.top.equalTo(button1.snp.bottom).offset(23.34)
        }
        
    }
    
    func configureNextButton(){
        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.isEnabled = false
        nextButton.target = self
        nextButton.action = #selector(actNextButton)
        
        nextButton.snp.makeConstraints {next in
            next.trailing.equalTo(boxContainer.snp.trailing).offset(-33.4)
            next.top.equalTo(checkboxButton.snp.bottom).offset(15)
            next.width.equalTo(88.34)
            next.height.equalTo(42.5)
        }
    }
    
    
    
    
    
    
    
    func configureWorkHoursLabel(){
        view.addSubview(workHoursLabel)
        workHoursLabel.translatesAutoresizingMaskIntoConstraints = false
        workHoursLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            workHoursLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 382),
            workHoursLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 360),
            
        ])
    }
    
    
    func configureTextLine1(){
        view.addSubview(text1Line1)
        text1Line1.translatesAutoresizingMaskIntoConstraints = false
        text1Line1.textColor = .white
        
        NSLayoutConstraint.activate([
            text1Line1.topAnchor.constraint(equalTo: workHoursLabel.bottomAnchor, constant: 20),
            text1Line1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 382)
        ])
    }
    
    func configureStartWorkHour() {
        view.addSubview(startWorkHour)
        startWorkHour.wantsLayer = true
        
        let calendar = Calendar.current
        var components = calendar.dateComponents([.hour, .minute], from: Date())
        components.hour = 8
        components.minute = 0
        
        if let date = calendar.date(from: components) {
            startWorkHour.dateValue = date
        }
        lastStartValue = startWorkHour.dateValue
        startWorkHour.datePickerElements = [.hourMinute]
      
        // Set the minimum date (01:00)
        var minComponents = calendar.dateComponents([.hour, .minute], from: Date())
        minComponents.hour = 1
        minComponents.minute = 0
        if let minDate = calendar.date(from: minComponents) {
            startWorkHour.minDate = minDate
        }
        
        // Set the maximum date (21:00)
        var maxComponents = calendar.dateComponents([.hour, .minute], from: Date())
        maxComponents.hour = 21
        maxComponents.minute = 0
        if let maxDate = calendar.date(from: maxComponents) {
            startWorkHour.maxDate = maxDate
        }
        startWorkHour.target = self
        startWorkHour.action = #selector(startWorkHourChanged)
        
        NSLayoutConstraint.activate([
            startWorkHour.topAnchor.constraint(equalTo: workHoursLabel.bottomAnchor, constant: 15),
            startWorkHour.leadingAnchor.constraint(equalTo: text1Line1.trailingAnchor, constant: 25),
            startWorkHour.widthAnchor.constraint(equalToConstant: 65),
            startWorkHour.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        updateStopWorkHour()
    }
    
    func configureText2Line1(){
        view.addSubview(text2Line1)
        text2Line1.translatesAutoresizingMaskIntoConstraints = false
        text2Line1.textColor = .white
        
        NSLayoutConstraint.activate([
            text2Line1.topAnchor.constraint(equalTo: workHoursLabel.bottomAnchor, constant: 20),
            text2Line1.leadingAnchor.constraint(equalTo: startWorkHour.trailingAnchor, constant: 25)
        ])
    }
    
    func configureStopWorkHour() {
        view.addSubview(stopWorkHour)
        stopWorkHour.wantsLayer = true
        lastStopValue = stopWorkHour.dateValue
        stopWorkHour.datePickerElements = [.hourMinute]
      
        let calendar1 = Calendar.current
        
        
        var minStopComponents = calendar1.dateComponents([.hour, .minute], from: Date())
        minStopComponents.hour = 3
        minStopComponents.minute = 0
        if let minStopDate = calendar1.date(from: minStopComponents) {
            stopWorkHour.minDate = minStopDate
        }
        
        var maxStopComponents = calendar1.dateComponents([.hour, .minute], from: Date())
        maxStopComponents.hour = 23
        maxStopComponents.minute = 0
        if let maxStopDate = calendar1.date(from: maxStopComponents) {
            stopWorkHour.maxDate = maxStopDate
        }
        stopWorkHour.target = self
        stopWorkHour.action = #selector(stopWorkHourChanged)
        
        
        
        NSLayoutConstraint.activate([
            stopWorkHour.topAnchor.constraint(equalTo: workHoursLabel.bottomAnchor, constant: 15),
            stopWorkHour.leadingAnchor.constraint(equalTo: text2Line1.trailingAnchor, constant: 25),
            stopWorkHour.widthAnchor.constraint(equalToConstant: 65),
            stopWorkHour.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        updateStopWorkHour()
    }
    
    
    
    
    func resetButtonColors() {
        // Reset all buttons to gray
        button1.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
        button2.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
        button3.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
        button4.layer?.backgroundColor = .init(gray: 1, alpha: 0.48)
        
        button1.foregroundColorText = .black
        button2.foregroundColorText = .black
        button3.foregroundColorText = .black
        button4.foregroundColorText = .black
        
        button1.isSelected = false
        button2.isSelected = false
        button3.isSelected = false
        button4.isSelected = false
    }
}




//#Preview(traits: .defaultLayout, body: {
//    UserPreferenceVC()
//})
