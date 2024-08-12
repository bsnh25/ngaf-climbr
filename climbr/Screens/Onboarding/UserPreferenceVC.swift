//
//  UserPreferenceVC.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 10/08/24.
//

import Cocoa

class UserPreferenceVC: NSViewController {
    
    private let bgContainer = NSView()
    private let pathImage = NSImageView(image: NSImage(resource: .mountainPath))
    private let appLogoImage = NSImageView(image: NSImage(resource: .appLogo))
    private let workHoursLabel = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .bold, contentLabel: "Your work hours")
    private let reminderLabel = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .bold, contentLabel: "When do you want to be reminded")
    private let nextButton = CLTextButtonV2(title: "Next", backgroundColor: .black, foregroundColorText: .white, fontText: .systemFont(ofSize: 26, weight: .bold))
    private let text1Line1 = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .regular, contentLabel: "From")
    private let text2Line1 = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .regular, contentLabel: "To")
    private let text1Line2 = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .regular, contentLabel: "Every")
    private let text2Line2 = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .regular, contentLabel: "Minutes")
    private let startWorkHour = CLDatePicker(backgroundColor: .lightGray, textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 22))
    private let stopWorkHour = CLDatePicker(backgroundColor: .lightGray, textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 22))
    private lazy var buttonManager: ButtonManager = ButtonManager(viewController: self)
    private let button1 = CLTextButtonV2(title: "30", backgroundColor: .lightGray, foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    private let button2 = CLTextButtonV2(title: "60", backgroundColor: .lightGray, foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    private let button3 = CLTextButtonV2(title: "90", backgroundColor: .lightGray, foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    private let button4 = CLTextButtonV2(title: "120", backgroundColor: .lightGray, foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    private let checkboxButton = NSButton(checkboxWithTitle: "Launch Limbr on startup", target: nil, action: #selector(actionCheckbox))
    var isChecked: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
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
    
    private func configureBgContainer(){
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
    
    private func configureImagePath(){
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
    
    private func configureAppLogo(){
        view.addSubview(appLogoImage)
        appLogoImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appLogoImage.widthAnchor.constraint(equalToConstant: 252),
            appLogoImage.heightAnchor.constraint(equalToConstant: 78.57),
                appLogoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                appLogoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -115)
            ])
        
    }
    
    private func configureWorkHoursLabel(){
        view.addSubview(workHoursLabel)
        workHoursLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            workHoursLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 382),
            workHoursLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 360),
        
        ])
    }
    
    private func configureReminderLabel(){
        view.addSubview(reminderLabel)
        reminderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reminderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 382),
            reminderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 484),
        
        ])
    }
    
    private func configureNextButton(){
        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextButton.widthAnchor.constraint(equalToConstant: 143),
            nextButton.heightAnchor.constraint(equalToConstant: 60),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 720)
        ])
    }
    
    private func configureTextLine1(){
        view.addSubview(text1Line1)
        text1Line1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            text1Line1.topAnchor.constraint(equalTo: workHoursLabel.bottomAnchor, constant: 20),
            text1Line1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 382)
        ])
    }
    
    private func configureStartWorkHour(){
        view.addSubview(startWorkHour)
        startWorkHour.maxDate = .distantFuture
        startWorkHour.minDate = .now
        
        NSLayoutConstraint.activate([
            startWorkHour.topAnchor.constraint(equalTo: workHoursLabel.bottomAnchor, constant: 20),
            startWorkHour.leadingAnchor.constraint(equalTo: text1Line1.trailingAnchor, constant: 25),
            startWorkHour.widthAnchor.constraint(equalToConstant: 65),
            startWorkHour.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    private func configureText2Line1(){
        view.addSubview(text2Line1)
        text2Line1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            text2Line1.topAnchor.constraint(equalTo: workHoursLabel.bottomAnchor, constant: 20),
            text2Line1.leadingAnchor.constraint(equalTo: startWorkHour.trailingAnchor, constant: 25)
        ])
    }
    
    private func configureStopWorkHour(){
        view.addSubview(stopWorkHour)
        stopWorkHour.maxDate = .distantFuture
        if let startMinDate = startWorkHour.minDate {
            let calendar = Calendar.current
            let oneHourLater = calendar.date(byAdding: .hour, value: 2, to: startMinDate)
            stopWorkHour.minDate = oneHourLater
        }
        
        NSLayoutConstraint.activate([
            stopWorkHour.topAnchor.constraint(equalTo: workHoursLabel.bottomAnchor, constant: 20),
            stopWorkHour.leadingAnchor.constraint(equalTo: text2Line1.trailingAnchor, constant: 25),
            stopWorkHour.widthAnchor.constraint(equalToConstant: 65),
            stopWorkHour.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    private func configureText1Line2(){
        view.addSubview(text1Line2)
        text1Line2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            text1Line2.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 20),
            text1Line2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 382)
        ])
    }
    
    private func configureButton1(){
        view.addSubview(button1)
        buttonManager.addButton(button1, action: #selector(func30min))
       
        button1.shouldRespondToHighlight = false
        
        NSLayoutConstraint.activate([
            button1.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 20),
            button1.leadingAnchor.constraint(equalTo: text1Line2.trailingAnchor, constant: 25),
            button1.widthAnchor.constraint(equalToConstant: 47),
            button1.heightAnchor.constraint(equalToConstant: 36)
        ])
    }

    private func configureButton2(){
        view.addSubview(button2)
        buttonManager.addButton(button2, action: #selector(func60min))
        button2.shouldRespondToHighlight = false
        
        NSLayoutConstraint.activate([
            button2.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 20),
            button2.leadingAnchor.constraint(equalTo: button1.trailingAnchor, constant: 25),
            button2.widthAnchor.constraint(equalToConstant: 47),
            button2.heightAnchor.constraint(equalToConstant: 36)
        ])
    }

    private func configureButton3(){
        view.addSubview(button3)
        buttonManager.addButton(button3, action: #selector(func90min))
        button3.shouldRespondToHighlight = false
        
        NSLayoutConstraint.activate([
            button3.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 20),
            button3.leadingAnchor.constraint(equalTo: button2.trailingAnchor, constant: 25),
            button3.widthAnchor.constraint(equalToConstant: 47),
            button3.heightAnchor.constraint(equalToConstant: 36)
        ])
    }

    private func configureButton4(){
        view.addSubview(button4)
        buttonManager.addButton(button4, action: #selector(func120min))
        button4.shouldRespondToHighlight = false
        
        NSLayoutConstraint.activate([
            button4.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 20),
            button4.leadingAnchor.constraint(equalTo: button3.trailingAnchor, constant: 25),
            button4.widthAnchor.constraint(equalToConstant: 47),
            button4.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    private func configureText2Line2(){
        view.addSubview(text2Line2)
        text2Line2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            text2Line2.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 20),
            text2Line2.leadingAnchor.constraint(equalTo: button4.trailingAnchor, constant: 25)
        
        ])
    }
    
    private func configureCheckBox(){
        view.addSubview(checkboxButton)
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        checkboxButton.font = NSFont.systemFont(ofSize: 22, weight: .bold)
        checkboxButton.contentTintColor = .black
        
        NSLayoutConstraint.activate([
            checkboxButton.topAnchor.constraint(equalTo: text1Line2.bottomAnchor, constant: 55),
            checkboxButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 382)
        ])
        
    }
    
    @objc private func func30min() {
        print("30 minutes selected")
    }

    @objc private func func60min() {
        print("60 minutes selected")
    }

    @objc private func func90min() {
        print("90 minutes selected")
    }

    @objc private func func120min() {
        print("120 minutes selected")
    }
    
    @objc
    private func actionCheckbox(){
        // Check the state of the checkbox
        isChecked = checkboxButton.state == .on
        
        // Perform actions based on checkbox state
        if isChecked {
            print("Checkbox is checked")
            // Handle the case when the checkbox is checked
        } else {
            print("Checkbox is unchecked")
            // Handle the case when the checkbox is unchecked
        }
    }
}




#Preview(traits: .defaultLayout, body: {
    UserPreferenceVC()
})
