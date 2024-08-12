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
    
    private let settingText = CLTextLabelV2(sizeOfFont: 20, weightOfFont: .bold, contentLabel: "Setting Preference")
    private let subTitleA = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .bold, contentLabel: "Your work hours")
    private let subTitleB = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .bold, contentLabel: "When do you want to be reminded")
    private let fromText = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .regular, contentLabel: "From")
    private let startTime = CLDatePicker(backgroundColor: .lightGray, textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 17))
    private let toText = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .regular, contentLabel: "to")
    private let endTime = CLDatePicker(backgroundColor: .lightGray, textColor: .black, datePickerStyleElement: .hourMinute, font: NSFont.systemFont(ofSize: 17))
    private let everyText = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .regular, contentLabel: "Every")
    private let min30 = CLTextButtonV2(title: "30", backgroundColor: .gray, foregroundColorText: .white, fontText: NSFont.systemFont(ofSize: 13.68, weight: .bold))
    private let min60 = CLTextButtonV2(title: "60", backgroundColor: .gray, foregroundColorText: .white, fontText: NSFont.systemFont(ofSize: 13.68, weight: .bold))
    private let min90 = CLTextButtonV2(title: "90", backgroundColor: .gray, foregroundColorText: .white, fontText: NSFont.systemFont(ofSize: 13.68, weight: .bold))
    private let min120 = CLTextButtonV2(title: "120", backgroundColor: .gray, foregroundColorText: .white, fontText: NSFont.systemFont(ofSize: 13.68, weight: .bold))
    private let minutesText = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .regular, contentLabel: "minutes")
    private let checkboxButton = NSButton(checkboxWithTitle: "Launch Limbr on startup", target: nil, action: #selector(actionCheckbox))
    private let saveButton = CLTextButtonV2(title: "Save", backgroundColor: .black, foregroundColorText: .white, fontText: NSFont.systemFont(ofSize: 13, weight: .regular))
    
    var isChecked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.wantsLayer = true
        view.layer?.backgroundColor = .white
        
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
        
        //MARK: Start Time Picker
        startTime.maxDate = .distantFuture
        startTime.minDate = .now
        
        //MARK: End Time Picker
        endTime.maxDate = .distantFuture
        if let startMinDate = startTime.minDate {
            let calendar = Calendar.current
            let oneHourLater = calendar.date(byAdding: .hour, value: 2, to: startMinDate)
            endTime.minDate = oneHourLater
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
    
    @objc
    private func action30min(){
        resetButtonColors()
        min30.layer?.backgroundColor = .black
        print("\(min30.title) choose")
    }
    
    @objc
    private func action60min(){
        resetButtonColors()
        min60.layer?.backgroundColor = .black
        print("\(min60.title) choose")
    }
    
    @objc
    private func action90min(){
        resetButtonColors()
        min90.layer?.backgroundColor = .black
        print("\(min90.title) choose")
    }
    
    @objc
    private func action120min(){
        resetButtonColors()
        min120.layer?.backgroundColor = .black
        print("\(min120.title) choose")
    }
    
    private func resetButtonColors() {
        // Reset all buttons to gray
        min30.layer?.backgroundColor = NSColor.gray.cgColor
        min60.layer?.backgroundColor = NSColor.gray.cgColor
        min90.layer?.backgroundColor = NSColor.gray.cgColor
        min120.layer?.backgroundColor = NSColor.gray.cgColor
    }
    
    @objc
    private func actionSave(){
        self.dismiss(self)
    }
}

#Preview(traits: .defaultLayout, body: {
    SettingVC()
})
