//
//  OverlayView.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 02/11/24.
//


import Cocoa
import AppKit
import RiveRuntime
import SnapKit
import Swinject

class OverlayView: NSViewController {
    let climbrVm = RiveViewModel(fileName: "overlay_notification-2", artboardName: "sad")
    let boxContent = NSView()
    let notifText = CLTextLabelV2(sizeOfFont: 22, weightOfFont: .bold, contentLabel: "Hey, aren't you tired? I'm feeling sore, can we rest and stretch first?")
    let dismissBtn = CLTextButtonV2(title: "Stretch Now", backgroundColor: .cButton, foregroundColorText: .white, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    let snoozeBtn = CLTextButtonV2(title: "Snooze (5 min)", backgroundColor: .white, foregroundColorText: .black, fontText: NSFont.systemFont(ofSize: 17, weight: .bold))
    var delegate: OverlayNotifServices?
    let notifService = NotificationManager.shared
    var snoozeTimer: DispatchSourceTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    func configure(){
        configureRiveView()
        configureBoxContent()
        configureButtonDismiss()
        configureButtonSnooze()
        configureTextNotif()
    }
    
    
    func configureRiveView(){
        let riveView = climbrVm.createRiveView()
        riveView.frame = view.bounds
        view.addSubview(riveView)
        
        
        riveView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(250)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
    }
    
    func configureBoxContent(){
        view.addSubview(boxContent)
        
        boxContent.wantsLayer = true
        boxContent.layer?.backgroundColor = .init(gray: 0.8, alpha: 1)
        boxContent.layer?.cornerRadius = 10
        boxContent.translatesAutoresizingMaskIntoConstraints = false
        
        boxContent.snp.makeConstraints {box in
            box.leading.equalToSuperview()
            box.bottom.equalToSuperview().inset(181)
            box.width.equalTo(471)
            box.height.equalTo(185)
        }
    }
    
    
    func configureButtonDismiss(){
        boxContent.addSubview(dismissBtn)
        
        dismissBtn.translatesAutoresizingMaskIntoConstraints = false
        dismissBtn.target = self
        dismissBtn.action = #selector(stretchNow)
        
        dismissBtn.snp.makeConstraints {dismiss in
            dismiss.leading.equalTo(boxContent.snp.leading).inset(73.5)
            dismiss.bottom.equalTo(boxContent.snp.bottom).inset(22.5)
            dismiss.width.equalTo(150)
            dismiss.height.equalTo(38)
        }
        
    }
    
    
    func configureButtonSnooze(){
        boxContent.addSubview(snoozeBtn)
        
        snoozeBtn.translatesAutoresizingMaskIntoConstraints = false
        
        snoozeBtn.target = self
        snoozeBtn.action = #selector(snooze)
        
        snoozeBtn.snp.makeConstraints {snooze in
            snooze.leading.equalTo(dismissBtn.snp.trailing).offset(24)
            snooze.bottom.equalTo(boxContent.snp.bottom).inset(22.5)
            snooze.width.equalTo(150)
            snooze.height.equalTo(38)
        }
    }
    
    func configureTextNotif() {
        boxContent.addSubview(notifText)
        
        notifText.translatesAutoresizingMaskIntoConstraints = false
        
        notifText.lineBreakMode = .byWordWrapping
        notifText.usesSingleLineMode = false
        notifText.cell?.wraps = true
        notifText.cell?.isScrollable = false


        notifText.wantsLayer = true
        notifText.alignment = .center
        
        
        notifText.snp.makeConstraints {notif in
            notif.top.equalTo(boxContent.snp.top).inset(22.5)
            notif.leading.equalTo(boxContent.snp.leading).offset(32)
            notif.trailing.equalTo(boxContent.snp.trailing).offset(-32)
        }
    }
    
    @objc private func stretchNow() {
        delegate?.didOverlayDismissed()
        
        var count = UserDefaults.standard.integer(forKey: UserDefaultsKey.kNotificationCount)
        
        count -= 1
        
        UserDefaults.standard.setValue(count, forKey: UserDefaultsKey.kNotificationCount)
        
            if let appDelegate = NSApplication.shared.delegate as? AppDelegate,
               let mainWindow = appDelegate.mainWindow {
                
                if let vc = Container.shared.resolve(StretchingVC.self) {
                  mainWindow.contentViewController?.push(to: vc)
                  print("go to stretching session")
                  mainWindow.orderFrontRegardless()
                }
            }
    }
    
    @objc private func snooze() {
        delegate?.didOverlayDismissed()
        
        snoozeTimer?.cancel()
        snoozeTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global(qos: .background))
        snoozeTimer?.schedule(deadline: .now() + 300)
        snoozeTimer?.setEventHandler { [weak self] in
            DispatchQueue.main.async {
                self?.notifService.showOverlay()
            }
        }
        snoozeTimer?.resume()
    }
}
