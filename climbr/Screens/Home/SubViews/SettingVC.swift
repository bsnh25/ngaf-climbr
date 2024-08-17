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
    
    let settingText = CLTextLabelV2(sizeOfFont: 20, weightOfFont: .bold, contentLabel: "Setting Preference")
    let subTitleA = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .bold, contentLabel: "Your work hours")
    let subTitleB = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .bold, contentLabel: "When do you want to be reminded")
    let fromText = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .regular, contentLabel: "From")
    let startTime = CLDatePicker(backgroundColor: .cHourPicker, textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 17))
    let toText = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .regular, contentLabel: "to")
    let endTime = CLDatePicker(backgroundColor: .cHourPicker, textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 17))
    let everyText = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .regular, contentLabel: "Every")
    let min30 = CLPickerButton(title: "30", backgroundColor: .black.withAlphaComponent(0.05), foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 13.68, weight: .bold))
    let min60 = CLPickerButton(title: "60", backgroundColor: .black.withAlphaComponent(0.05), foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 13.68, weight: .bold))
    let min90 = CLPickerButton(title: "90", backgroundColor: .black.withAlphaComponent(0.05), foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 13.68, weight: .bold))
    let min120 = CLPickerButton(title: "120", backgroundColor: .black.withAlphaComponent(0.05), foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 13.68, weight: .bold))
    let minutesText = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .regular, contentLabel: "minutes")
    let checkboxButton = NSButton(checkboxWithTitle: "Launch Limbr on startup", target: nil, action: #selector(actionCheckbox))
    let saveButton = CLTextButtonV2(title: "Save", backgroundColor: .cButton, foregroundColorText: .white, fontText: NSFont.systemFont(ofSize: 13, weight: .regular))
    
    var isChecked: Bool = false
    var userService: UserService?
    
    init(userService: UserService?) {
        super.init(nibName: nil, bundle: nil)
        self.userService = userService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.cBox.cgColor
        
        configureUI()
        
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
    
    private func configureUI(){
        let userPreferenceData = userService?.getPreferences()
        view.addSubview(settingText)
        view.addSubview(subTitleA)
        view.addSubview(fromText)
        view.addSubview(startTime)
        view.addSubview(toText)
        view.addSubview(endTime)
        
        view.addSubview(subTitleB)
        view.addSubview(everyText)
        view.addSubview(min30)
        view.addSubview(min60)
        view.addSubview(min90)
        view.addSubview(min120)
        view.addSubview(minutesText)
        
        view.addSubview(checkboxButton)
        view.addSubview(saveButton)
        
        //MARK: Start Time Picker - Need Revision
        if let start = userPreferenceData?.startWorkingHour {
            print("\(start)")
            startTime.dateValue = start
        }
        startTime.maxDate = .distantFuture
        startTime.minDate = .distantPast
        
        
        //MARK: End Time Picker - Need Revision
        if let stop = userPreferenceData?.endWorkingHour {
            print("\(stop)")
            endTime.dateValue = stop
        }
        endTime.maxDate = .distantFuture
        endTime.minDate = startTime.dateValue.addingTimeInterval(7200)
//        Calendar.current.date(byAdding: .hour, value: 2, to: value)
        
        
        if let interval = userPreferenceData?.reminderInterval{
            switch interval{
            case 30:
                NSApplication.shared.sendAction(#selector(action30min), to: self, from: nil)
                
            case 60:
                NSApplication.shared.sendAction(#selector(action60min), to: self, from: nil)
                
            case 90:
                NSApplication.shared.sendAction(#selector(action90min), to: self, from: nil)
                
            case 120:
                NSApplication.shared.sendAction(#selector(action120min), to: self, from: nil)
            default:
                break
            }
        }
        
        min30.target = self
        min30.action = #selector(action30min)
        
        min60.target = self
        min60.action = #selector(action60min)
        
        min90.target = self
        min90.action = #selector(action90min)
        
        min120.target = self
        min120.action = #selector(action120min)
        
        checkboxButton.font = NSFont.systemFont(ofSize: 17, weight: .bold)
        checkboxButton.contentTintColor = .black
        
        if let launchAtLogin = userPreferenceData?.launchAtLogin{
            if launchAtLogin{
                checkboxButton.state = .on
            } else{
                checkboxButton.state = .off
            }
        }
        
        
        saveButton.target = self
        saveButton.action = #selector(actionSave)
        
        let topPaddingSetting = view.bounds.height * 0.1
        let leadingPaddingSetting = view.bounds.height * 0.05
        let padding = view.bounds.height * 0.02
        
        settingText.snp.makeConstraints { mainTitle in
            mainTitle.top.equalToSuperview().inset(topPaddingSetting)
            mainTitle.leading.equalToSuperview().inset(leadingPaddingSetting)
        }
        
        subTitleA.snp.makeConstraints { subA in
            subA.top.equalTo(settingText.snp.bottom).offset(padding)
            subA.leading.equalTo(settingText.snp.leading)
        }
        
        fromText.snp.makeConstraints { from in
            from.leading.equalTo(settingText.snp.leading)
            from.top.equalTo(subTitleA.snp.bottom).offset(padding)
        }
        
        startTime.snp.makeConstraints { startTime in
            startTime.top.equalTo(subTitleA.snp.bottom).offset(padding)
            startTime.leading.equalTo(fromText.snp.trailing).offset(padding)
        }
        
        toText.snp.makeConstraints { to in
            to.leading.equalTo(startTime.snp.trailing).offset(padding)
            to.top.equalTo(subTitleA.snp.bottom).offset(padding)
        }
        
        endTime.snp.makeConstraints { endTime in
            endTime.top.equalTo(subTitleA.snp.bottom).offset(padding)
            endTime.leading.equalTo(toText.snp.trailing).offset(padding)
        }
        
        subTitleB.snp.makeConstraints { subB in
            subB.leading.equalTo(settingText.snp.leading)
            subB.top.equalTo(fromText.snp.bottom).offset(padding)
        }
        
        everyText.snp.makeConstraints { every in
            every.leading.equalTo(settingText.snp.leading)
            every.top.equalTo(subTitleB.snp.bottom).offset(padding)
        }
        
        min30.snp.makeConstraints { min30 in
            min30.top.equalTo(subTitleB.snp.bottom).offset(padding)
            min30.leading.equalTo(everyText.snp.trailing).offset(padding)
            min30.width.height.equalTo(30)
        }
        
        min60.snp.makeConstraints { min60 in
            min60.top.equalTo(subTitleB.snp.bottom).offset(padding)
            min60.leading.equalTo(min30.snp.trailing).offset(padding)
            min60.height.width.equalTo(30)
        }
        
        min90.snp.makeConstraints { min90 in
            min90.top.equalTo(subTitleB.snp.bottom).offset(padding)
            min90.leading.equalTo(min60.snp.trailing).offset(padding)
            min90.height.width.equalTo(30)
        }
        
        min120.snp.makeConstraints { min120 in
            min120.top.equalTo(subTitleB.snp.bottom).offset(padding)
            min120.leading.equalTo(min90.snp.trailing).offset(padding)
            min120.height.width.equalTo(30)
        }
        
        minutesText.snp.makeConstraints { minutes in
            minutes.top.equalTo(subTitleB.snp.bottom).offset(padding)
            minutes.leading.equalTo(min120.snp.trailing).offset(padding)
        }
        
        checkboxButton.snp.makeConstraints { chx in
            chx.leading.equalTo(settingText.snp.leading)
            chx.top.equalTo(min30.snp.bottom).offset(padding)
        }
        
        saveButton.snp.makeConstraints { save in
            save.trailing.equalToSuperview().inset(leadingPaddingSetting)
            save.top.equalTo(checkboxButton.snp.bottom).offset(20)
            save.height.equalTo(36)
            save.width.equalTo(80)
        }
    }
    
}

//#Preview(traits: .defaultLayout, body: {
//    SettingVC()
//})
