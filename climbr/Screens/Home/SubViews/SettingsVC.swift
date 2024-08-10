//
//  SettingsVC.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 09/08/24.
//

import AppKit

class SettingsView: NSViewController {
    
    private let settingText = CLTextLabelV2(sizeOfFont: 20, weightOfFont: .bold, contentLabel: "Setting Preference")
    private let subTitleA = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .bold, contentLabel: "Your work hours")
    private let subTitleB = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .bold, contentLabel: "When do you want to be reminded")
    private let fromText = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .regular, contentLabel: "From")
    private let startTime = NSDatePicker()
    private let toText = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .regular, contentLabel: "to")
    private let endTime = NSDatePicker()
    private let everyText = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .regular, contentLabel: "Every")
    private let min30 = CLTextButtonV2(title: "30", backgroundColor: .black, foregroundColorText: .white, fontText: NSFont.systemFont(ofSize: 13.68, weight: .bold))
    private let min60 = NSButton()
    private let min90 = NSButton()
    private let min120 = NSButton()
    private let minutesText = CLTextLabelV2(sizeOfFont: 17, weightOfFont: .regular, contentLabel: "minutes")
    private let checkboxButton = NSButton(checkboxWithTitle: "Launch Limbr on startup", target: SettingsView.self, action: #selector(actionCheckbox))
    
    private var startTimeValue: Date?
    private var endTimeValue: Date?
    
    var isTapped: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.wantsLayer = true
        view.layer?.backgroundColor = .white
        
    }
    
    private func configureUI(){
//        configureStackA()
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
        
        //MARK: Start Time Picker
        startTime.datePickerMode = .single
        startTime.datePickerStyle = .textField
        startTime.datePickerElements = .hourMinute
        startTime.wantsLayer = true
        startTime.layer?.backgroundColor = CGColor(red: 118, green: 118, blue: 128, alpha: 12)
        startTime.layer?.cornerRadius = 5
        startTime.isBezeled = false
        startTime.maxDate = .distantFuture
        startTime.minDate = .now
        startTimeValue = startTime.dateValue
        startTime.font = NSFont.systemFont(ofSize: 17)
        
        //MARK: End Time Picker
        endTime.datePickerMode = .single
        endTime.datePickerStyle = .textField
        endTime.datePickerElements = .hourMinute
        endTime.wantsLayer = true
        endTime.layer?.backgroundColor = CGColor(red: 118, green: 118, blue: 128, alpha: 12)
        endTime.layer?.cornerRadius = 5
        endTime.isBezeled = false
        endTime.maxDate = .distantFuture
        endTime.minDate = startTimeValue
        endTimeValue = endTime.dateValue
        endTime.font = NSFont.systemFont(ofSize: 17)
        
//        min30.title = "30"
//        min30.bezelColor = .black
//        min30.bezelStyle = .flexiblePush
//        min30.isHighlighted = true
//        min30.font = NSFont.systemFont(ofSize: 13.68, weight: .bold)
//        min30.layer?.opacity = 0.8
        min30.isEnabled = isTapped
        min30.target = self
        min30.action = #selector(action30min)
        
        min60.title = "60"
        min60.bezelColor = .black
        min60.bezelStyle = .flexiblePush
        min60.isHighlighted = false
        min60.font = NSFont.systemFont(ofSize: 13.68, weight: .bold)
        
        checkboxButton.font = NSFont.systemFont(ofSize: 17, weight: .bold)
        
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
            min90.height.width.equalTo(17)
        }

        min120.snp.makeConstraints { min120 in
            min120.top.equalTo(subTitleB.snp.bottom).offset(padding)
            min120.leading.equalTo(min90.snp.trailing).offset(padding)
            min120.height.width.equalTo(17)
        }
        
        minutesText.snp.makeConstraints { minutes in
            minutes.top.equalTo(subTitleB.snp.bottom).offset(padding)
            minutes.leading.equalTo(min120.snp.trailing).offset(padding)
        }
        
        checkboxButton.snp.makeConstraints { chx in
            chx.leading.equalTo(settingText.snp.leading)
            chx.top.equalTo(everyText.snp.bottom).offset(padding)
        }
    }
    
    @objc
    private func actionCheckbox(){
        
    }
    
    @objc
    private func action30min(){
        isTapped = true
        print(isTapped)
    }
    
}

#Preview(traits: .defaultLayout, body: {
    SettingsView()
})

//
//class SettingsVC: NSWindowController {
//    
//    convenience init() {
//        let contentRect = NSRect(x: 0, y: 0, width: 300, height: 200)
//        let panel = NSPanel(contentRect: contentRect,
//                            styleMask: [.titled, .closable],
//                            backing: .buffered,
//                            defer: false)
//        
//        self.init(window: panel)
//        self.window?.title = "Pop-up Window"
//        
////        let settingView = SettingsView(frame: panel.contentView!.bounds)
//        let settingView = SettingsView()
////        settingView.autoresizingMask = [.width, .height]
////        panel.contentView?.addSubview(settingView)
//        
////        disableMainWindowControls()
//        self.window?.contentViewController = settingView
//        
//    }
//    
////    func show() {
////        self.window?.makeKeyAndOrderFront(nil)
////        self.window?.beginSheet(self.window!) { _ in
////            //Thre sheet is dismissed, and main window becomes active again
////        }
////    }
//    
////    private func disableMainWindowControls() {
//////        mainWindow?.isEnabled = false
////    }
////
////    private func enableMainWindowControls() {
//////        mainWindow?.isEnabled = true
////    }
//}
//
////extension SettingsVC: NSWindowDelegate {
////    func windowWillClose(_ notification: Notification) {
////        enableMainWindowControls()
////    }
////}
