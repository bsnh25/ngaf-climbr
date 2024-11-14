//
//  MenuBarVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 28/10/24.
//

import AppKit
import Swinject
import Combine
import RiveRuntime

class MenuBarVC: NSViewController, NotificationDelegate {
    
    let climbrVmMale = RiveViewModel(fileName: "overlay_notification-2", artboardName: "sad")
    let climbrVmFemale = RiveViewModel(fileName: "overlay_notification-2", artboardName: "sad")
    var riveView = RiveView()
    
    private var lastSessionTime: Date = Date()
    
  private lazy var titleStateLabel: CLLabel = {
    let label = CLLabel()
    label.stringValue = "Status"
    label.textColor = .labelColor
    
    return label
  }()
  
  private lazy var stateLabel: CLLabel = {
    let label = CLLabel()
    label.stringValue = "Fit"
    label.textColor = .kGreen
    label.font = .boldSystemFont(ofSize: 22)
    
    return label
  }()
  
  private lazy var stateStackView: NSStackView = {
    let stack = NSStackView(views: [titleStateLabel, stateLabel])
    stack.spacing = 4
    stack.orientation = .vertical
    stack.alignment = .leading
    
    return stack
  }()
  
  private lazy var titleSessionLabel: CLLabel = {
    let label = CLLabel()
    label.stringValue = "Next Session"
    label.textColor = .labelColor
    
    return label
  }()
  
  private lazy var sessionLabel: CLLabel = {
    let label = CLLabel()
    label.stringValue = "13.00"
    label.textColor = .cButton
    label.font = .boldSystemFont(ofSize: 22)
    
    return label
  }()
  
  private lazy var sessionStackView: NSStackView = {
    let stack = NSStackView(views: [titleSessionLabel, sessionLabel])
    stack.spacing = 4
    stack.orientation = .vertical
    stack.alignment = .leading
    
    return stack
  }()
  
  private lazy var stretchNowBtn: CLTextButtonV2 = {
    let button = CLTextButtonV2(title: "Stretch Now", backgroundColor: .cButton, foregroundColorText: .white, fontText: .preferredFont(forTextStyle: .body))
    button.target = self
    button.action = #selector(openStretchNow)
    
    return button
  }()
  
  private lazy var quitBtn: CLTextButtonV2 = {
      let button = CLTextButtonV2(title: "Quit", borderColor: .cQuitButtonMenuBar, font: .preferredFont(forTextStyle: .body) )
    button.target = self
    button.action = #selector(quitApp)
    
    return button
  }()
  
  private lazy var buttonStackView: NSStackView = {
    let stack = NSStackView(views: [stretchNowBtn, quitBtn])
    stack.spacing = 16
    stack.distribution = .fillEqually
    
    return stack
  }()
  
  private lazy var imageView: NSImageView = {
    let imageView = NSImageView()
    imageView.wantsLayer = true
    imageView.layer?.backgroundColor = NSColor.blue.cgColor
    imageView.layer?.cornerRadius = 8
    
    return imageView
  }()
  
  var openStretchNowHandler: (() -> Void)
  var quitAppHandler: (() -> Void)
  
  private var bag: AnyCancellable?
  private var userManager = UserManager.shared
    private var notifManager = NotificationManager.shared
    private var userPreference: UserPreferenceModel?
    private var userCharacterData: CharacterModel?
  
  init(
    onOpenStretchNow: @escaping (() -> Void),
    onQuitApp: @escaping (() -> Void)
  ) {
    
    openStretchNowHandler = onOpenStretchNow
    quitAppHandler = onQuitApp
    
    super.init(nibName: nil, bundle: nil)
      
    notifManager.notifDelegate = self
    userPreference = userManager.getPreferences()
    userCharacterData = userManager.getCharacterData()
      
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViews()
    configureConstraints()
    resetSessionAfterStretching()
      
    
    
      bag = NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)
        .sink { [weak self] _ in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.userPreference = self.userManager.getPreferences()
                self.observeNotification()
                self.updateSessionTime()
            }
        }
    
    
    
  }
  
  private func observeNotification() {
    let notifCount: Int = UserDefaults.standard.integer(forKey: UserDefaultsKey.kNotificationCount)
    
    print("Current session: ", UserDefaults.standard.object(forKey: UserDefaultsKey.kCurrentSessionReminder))
    
    if notifCount > 0 {
      stateLabel.setText("Tired")
        stateLabel.setTextColor(.cNewButton)
    } else {
      stateLabel.setText("Fit")
      stateLabel.setTextColor(.kGreen)
    }
  }
    
    private func getNextEnabledDayName(after day: Int, workingHours: [WorkingHour]) -> String {
        let calendar = Calendar.current
        var currentDay = day

        for _ in 0...6 {
            currentDay = (currentDay + 1)  % 7
            
            
            if let workingHour = workingHours.first(where: { $0.day == currentDay && $0.isEnabled }) {
                print("current day get enabled: \(calendar.weekdaySymbols[currentDay])")
                return calendar.weekdaySymbols[currentDay]
            }
        }

        return "No Working Day Found"
    }

    
    private func calculateNextSessionTime() -> String {
        guard let reminderInterval = userPreference?.reminderInterval,
              let workingHours = userPreference?.workingHours else {
            return "No Session Set"
        }

        let calendar = Calendar.current
        let todayWeekday = calendar.component(.weekday, from: Date()) - 1
        print("todayWeekday: \(todayWeekday)")
        let notifCount = UserDefaults.standard.integer(forKey: UserDefaultsKey.kNotificationCount)
        
        print("workingHours: \(workingHours)")
        
        for workingHour in workingHours {
            print("workingHour day: \(workingHour.day)")
            if workingHour.day == todayWeekday {
                if workingHour.isEnabled {
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm"
                    
                    let nextSessionTime = getNextSessionTime(from: lastSessionTime,
                                                             interval: reminderInterval,
                                                             workingHour: workingHour)
                    
                    sessionLabel.setTextColor(notifCount > 0 ? .cNewButton : .kGreen)
                    
                    return nextSessionTime
                } else {
                    
                    let nextEnabledDayName = getNextEnabledDayName(after: todayWeekday, workingHours: workingHours)
                    sessionLabel.setTextColor(notifCount > 0 ? .cNewButton : .kGreen)
                    return nextEnabledDayName
                }
            }
        }

        sessionLabel.setTextColor(.cNewButton)
        return "No Session Set"
    }

    private func getNextSessionTime(from baseTime: Date, interval: Int, workingHour: WorkingHour) -> String {
        var nextTime = baseTime.addingTimeInterval(TimeInterval(interval * 60))
        let calendar = Calendar.current

       
        let startOfWorkday = calendar.date(bySettingHour: calendar.component(.hour, from: workingHour.startHour),
                                           minute: calendar.component(.minute, from: workingHour.startHour),
                                           second: 0, of: nextTime)!
        let endOfWorkday = calendar.date(bySettingHour: calendar.component(.hour, from: workingHour.endHour),
                                         minute: calendar.component(.minute, from: workingHour.endHour),
                                         second: 0, of: nextTime)!
        
        
        if nextTime >= startOfWorkday && nextTime < endOfWorkday {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: nextTime)
        } else if nextTime >= endOfWorkday {
            
            print("based working hour day: \(workingHour.day)")
            return getNextEnabledDayName(after: workingHour.day, workingHours: userPreference?.workingHours ?? [])
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: startOfWorkday)
        }
    }

  
        private func updateSessionTime() {
            sessionLabel.stringValue = calculateNextSessionTime()
        }
  
        func resetSessionAfterStretching() {
            updateSessionTime()
        }
  
  private func configureViews() {
      if userCharacterData?.gender == .male {
          riveView = climbrVmMale.createRiveView()
      }else {
          riveView = climbrVmFemale.createRiveView()
      }
      
    view.addSubview(stateStackView)
    view.addSubview(sessionStackView)
    view.addSubview(buttonStackView)
      view.addSubview(riveView)
    
    view.wantsLayer = true
    view.layer?.backgroundColor = .white
  }
  
  private func configureConstraints() {
    stateStackView.snp.makeConstraints { make in
      make.leading.top.equalToSuperview().inset(16)
    }
    
    sessionStackView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.top.equalTo(stateStackView.snp.bottom).offset(16)
    }
    
    stretchNowBtn.snp.makeConstraints { make in
      make.height.equalTo(40)
    }
    
    quitBtn.snp.makeConstraints { make in
      make.height.equalTo(40)
    }
    
    buttonStackView.snp.makeConstraints { make in
      make.leading.bottom.trailing.equalToSuperview().inset(16)
    }
    
      riveView.snp.makeConstraints { make in
      make.width.height.equalTo(116)
      make.trailing.top.equalToSuperview().inset(16)
    }
    
  }
  
  @objc private func openStretchNow(_ sender: Any?) {
    openStretchNowHandler()
  }
  
  @objc private func quitApp(_ sender: Any?) {
    quitAppHandler()
  }
    
    func didStartScheduler(_ time: Date) {
        lastSessionTime = time
        resetSessionAfterStretching()
    }
  
}
