//
//  UserPreferenceVC.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 10/08/24.
//

import Cocoa
import Swinject



class UserPreferenceVC: NSViewController {
    
    let bgContainer = NSView()
    let pathImage = NSImageView(image: NSImage(resource: .mountainPath))
    let appLogoImage = NSImageView(image: NSImage(resource: .appLogo))
    let workHoursLabel = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .bold, contentLabel: "Your work hours")
    let reminderLabel = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .bold, contentLabel: "When do you want to be reminded")
    let nextButton = CLTextButtonV2(title: "Next", backgroundColor: .black, foregroundColorText: .white, fontText: .systemFont(ofSize: 26, weight: .bold))
    let text1Line1 = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .regular, contentLabel: "From")
    let text2Line1 = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .regular, contentLabel: "To")
    let text1Line2 = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .regular, contentLabel: "Every")
    let text2Line2 = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .regular, contentLabel: "Minutes")
    let startWorkHour = CLDatePicker(backgroundColor: .lightGray, textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 20))
    let stopWorkHour = CLDatePicker(backgroundColor: .lightGray, textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 20))
    let button1 = CLPickerButton(title: "30", backgroundColor: .white.withAlphaComponent(0.5), foregroundColorText: .white, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    let button2 = CLPickerButton(title: "60", backgroundColor: .white.withAlphaComponent(0.5), foregroundColorText: .white, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    let button3 = CLPickerButton(title: "90", backgroundColor: .white.withAlphaComponent(0.5), foregroundColorText: .white, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    let button4 = CLPickerButton(title: "120", backgroundColor: .white.withAlphaComponent(0.5), foregroundColorText: .white, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    let checkboxButton = NSButton(checkboxWithTitle: "Launch Limbr on startup", target: nil, action: #selector(actionCheckbox))
    var isChecked: Bool = false
    var intervalReminder: Int64 = 0
    var userService: UserService?
    var notifService: NotificationService?
    
    
    init(userService: UserService?, notifService: NotificationService?) {
        super.init(nibName: nil, bundle: nil)
        self.userService = userService
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
        notifService?.askUserPermission()
        //        notif?.sendNotification(title: "Test Title", body: "This is notification user", reminder: UserPreferences())
    }
    
    
    func configure(){
        configureBgContainer()
        configureImagePath()
        configureAppLogo()
        configureWorkHoursLabel()
        configureReminderLabel()
        configureNextButton()
        configureTextLine1()
        configureStartWorkHour()
        configureText2Line1()
        configureStopWorkHour()
        configureText1Line2()
        configureButton1()
        configureButton2()
        configureButton3()
        configureButton4()
        configureText2Line2()
        configureCheckBox()
    }
    
    func configureBgContainer(){
        view.addSubview(bgContainer)
        bgContainer.wantsLayer = true
        bgContainer.layer?.backgroundColor = NSColor.white.cgColor
        bgContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bgContainer.topAnchor.constraint(equalTo: view.topAnchor),
            bgContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureImagePath(){
        view.addSubview(pathImage)
        pathImage.wantsLayer = true
        pathImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pathImage.topAnchor.constraint(equalTo: view.topAnchor),
            pathImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pathImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pathImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureAppLogo(){
        view.addSubview(appLogoImage)
        appLogoImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appLogoImage.widthAnchor.constraint(equalToConstant: 252),
            appLogoImage.heightAnchor.constraint(equalToConstant: 78.57),
            appLogoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appLogoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -115)
        ])
        
    }
    
    func configureWorkHoursLabel(){
        view.addSubview(workHoursLabel)
        workHoursLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            workHoursLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 382),
            workHoursLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 360),
            
        ])
    }
    
    func configureReminderLabel(){
        view.addSubview(reminderLabel)
        reminderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reminderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 382),
            reminderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 484),
            
        ])
    }
    
    func configureNextButton(){
        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.isEnabled = false
        nextButton.target = self
        nextButton.action = #selector(actNextButton)
        
        NSLayoutConstraint.activate([
            nextButton.widthAnchor.constraint(equalToConstant: 143),
            nextButton.heightAnchor.constraint(equalToConstant: 60),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 720)
        ])
    }
    
    func configureTextLine1(){
        view.addSubview(text1Line1)
        text1Line1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            text1Line1.topAnchor.constraint(equalTo: workHoursLabel.bottomAnchor, constant: 20),
            text1Line1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 382)
        ])
    }
    
    func configureStartWorkHour() {
        view.addSubview(startWorkHour)
        
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        components.hour = 8
        components.minute = 0
        
        if let date = calendar.date(from: components) {
            startWorkHour.dateValue = date
        }
        
        startWorkHour.datePickerElements = [.hourMinute]
        startWorkHour.target = self
        startWorkHour.action = #selector(startWorkHourChanged)
        
        NSLayoutConstraint.activate([
            startWorkHour.topAnchor.constraint(equalTo: workHoursLabel.bottomAnchor, constant: 20),
            startWorkHour.leadingAnchor.constraint(equalTo: text1Line1.trailingAnchor, constant: 25),
            startWorkHour.widthAnchor.constraint(equalToConstant: 65),
            startWorkHour.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        updateStopWorkHour()
    }
    
    func configureText2Line1(){
        view.addSubview(text2Line1)
        text2Line1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            text2Line1.topAnchor.constraint(equalTo: workHoursLabel.bottomAnchor, constant: 20),
            text2Line1.leadingAnchor.constraint(equalTo: startWorkHour.trailingAnchor, constant: 25)
        ])
    }
    
    func configureStopWorkHour() {
        view.addSubview(stopWorkHour)
        
        stopWorkHour.datePickerElements = [.hourMinute]
        
        NSLayoutConstraint.activate([
            stopWorkHour.topAnchor.constraint(equalTo: workHoursLabel.bottomAnchor, constant: 20),
            stopWorkHour.leadingAnchor.constraint(equalTo: text2Line1.trailingAnchor, constant: 25),
            stopWorkHour.widthAnchor.constraint(equalToConstant: 65),
            stopWorkHour.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        updateStopWorkHour()
    }
    
    func configureText1Line2(){
        view.addSubview(text1Line2)
        text1Line2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            text1Line2.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 20),
            text1Line2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 382)
        ])
    }
    
    func configureButton1(){
        view.addSubview(button1)
        button1.target = self
        button1.action = #selector(action30min)
        
        NSLayoutConstraint.activate([
            button1.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 20),
            button1.leadingAnchor.constraint(equalTo: text1Line2.trailingAnchor, constant: 25),
            button1.widthAnchor.constraint(equalToConstant: 47),
            button1.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    func configureButton2(){
        view.addSubview(button2)
        button2.target = self
        button2.action = #selector(action60min)
        
        NSLayoutConstraint.activate([
            button2.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 20),
            button2.leadingAnchor.constraint(equalTo: button1.trailingAnchor, constant: 25),
            button2.widthAnchor.constraint(equalToConstant: 47),
            button2.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    func configureButton3(){
        view.addSubview(button3)
        button3.target = self
        button3.action = #selector(action90min)
        
        NSLayoutConstraint.activate([
            button3.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 20),
            button3.leadingAnchor.constraint(equalTo: button2.trailingAnchor, constant: 25),
            button3.widthAnchor.constraint(equalToConstant: 47),
            button3.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    func configureButton4(){
        view.addSubview(button4)
        button4.target = self
        button4.action = #selector(action120min)
        
        NSLayoutConstraint.activate([
            button4.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 20),
            button4.leadingAnchor.constraint(equalTo: button3.trailingAnchor, constant: 25),
            button4.widthAnchor.constraint(equalToConstant: 47),
            button4.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    func configureText2Line2(){
        view.addSubview(text2Line2)
        text2Line2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            text2Line2.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 20),
            text2Line2.leadingAnchor.constraint(equalTo: button4.trailingAnchor, constant: 25)
            
        ])
    }
    
    func configureCheckBox(){
        view.addSubview(checkboxButton)
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        checkboxButton.font = NSFont.systemFont(ofSize: 22, weight: .bold)
        checkboxButton.contentTintColor = .black
        checkboxButton.target = self
        checkboxButton.action = #selector(actionCheckbox)
        
        NSLayoutConstraint.activate([
            checkboxButton.topAnchor.constraint(equalTo: text1Line2.bottomAnchor, constant: 55),
            checkboxButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 382)
        ])
        
    }
    
    func processSavePreference() -> Int64{
        
        if button1.isSelected {
            return 30
        }else if button2.isSelected{
            return 60
        }else if button3.isSelected{
            return 90
        } else if button4.isSelected{
            return 120
        }else {
            print("ERR: at user preference (reminder)")
            return 0
        }
        
    }
    
    
    func resetButtonColors() {
        // Reset all buttons to gray
        button1.layer?.backgroundColor = NSColor.white.withAlphaComponent(0.5).cgColor
        button2.layer?.backgroundColor = NSColor.white.withAlphaComponent(0.5).cgColor
        button3.layer?.backgroundColor = NSColor.white.withAlphaComponent(0.5).cgColor
        button4.layer?.backgroundColor = NSColor.white.withAlphaComponent(0.5).cgColor
        
        button1.foregroundColorText = .white
        button2.foregroundColorText = .white
        button3.foregroundColorText = .white
        button4.foregroundColorText = .white
        
        button1.isSelected = false
        button2.isSelected = false
        button3.isSelected = false
        button4.isSelected = false
    }
}




//#Preview(traits: .defaultLayout, body: {
//    UserPreferenceVC()
//})
