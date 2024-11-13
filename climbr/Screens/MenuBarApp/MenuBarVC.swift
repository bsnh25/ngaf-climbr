//
//  MenuBarVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 28/10/24.
//

import AppKit
import Swinject
import Combine

class MenuBarVC: NSViewController, NotificationDelegate {
    
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
    let button = CLTextButtonV2(title: "Quit", borderColor: .labelColor, font: .preferredFont(forTextStyle: .body))
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
  
  init(
    onOpenStretchNow: @escaping (() -> Void),
    onQuitApp: @escaping (() -> Void)
  ) {
    
    openStretchNowHandler = onOpenStretchNow
    quitAppHandler = onQuitApp
    
    super.init(nibName: nil, bundle: nil)
      
    notifManager.notifDelegate = self
      userPreference = userManager.getPreferences()
      
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
                self.observeNotification()
            }
        }
  }
  
  private func observeNotification() {
    let notifCount: Int = UserDefaults.standard.integer(forKey: UserDefaultsKey.kNotificationCount)
    
    print("Current session: ", UserDefaults.standard.object(forKey: UserDefaultsKey.kCurrentSessionReminder))
    
    if notifCount > 0 {
      stateLabel.setText("Tired")
      stateLabel.setTextColor(.kGreen)
    } else {
      stateLabel.setText("Fit")
      stateLabel.setTextColor(.cNewButton)
    }
  }
    
    private func calculateNextSessionTime() -> String {
        guard let reminderInterval = userPreference?.reminderInterval,
              let workingHours = userPreference?.workingHours else {
            return "No Session Set"
        }

        // Get the current day of the week (1 = Sunday, 2 = Monday, etc.)
        let calendar = Calendar.current
        let todayWeekday = calendar.component(.weekday, from: Date())
        
        // Look for today's working hour in the array
        for workingHour in workingHours {
            if workingHour.day == todayWeekday {
                if workingHour.isEnabled {
                    // Today is a working day, calculate the next session time
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm"
                    
                    let nextSessionTime = getNextSessionTime(from: lastSessionTime,
                                                             interval: reminderInterval,
                                                             workingHour: workingHour)
                    sessionLabel.setTextColor(.kGreen)
                    return formatter.string(from: nextSessionTime)
                } else {
                    // Today is not a working day
                    sessionLabel.setTextColor(.cNewButton)
                    return "Tomorrow"
                }
            }
        }

        // Fallback if no matching day is found (shouldn't happen with exactly 7 items)
        sessionLabel.setTextColor(.cNewButton)
        return "No Session Set"
    }

    /// Determines the next session time constrained within today's working hours
    private func getNextSessionTime(from baseTime: Date, interval: Int, workingHour: WorkingHour) -> Date {
        var nextTime = baseTime.addingTimeInterval(TimeInterval(interval * 60))
        let calendar = Calendar.current

        // Define the start and end of today's working hours
        let startOfWorkday = calendar.date(bySettingHour: calendar.component(.hour, from: workingHour.startHour),
                                           minute: calendar.component(.minute, from: workingHour.startHour),
                                           second: 0, of: nextTime)!
        let endOfWorkday = calendar.date(bySettingHour: calendar.component(.hour, from: workingHour.endHour),
                                         minute: calendar.component(.minute, from: workingHour.endHour),
                                         second: 0, of: nextTime)!
        
        // Check if `nextTime` is within working hours
        if nextTime >= startOfWorkday && nextTime < endOfWorkday {
            // If within working hours, return `nextTime`

            return nextTime
        } else if nextTime >= endOfWorkday {
            // If after working hours, set `nextTime` to tomorrow's start hour
    
            return startOfWorkday.addingTimeInterval(24 * 60 * 60) // move to the next day's start if needed
        } else {
            // If before working hours, set `nextTime` to today’s start hour
       
            return startOfWorkday
        }
    }
      
  
        private func updateSessionTime() {
            sessionLabel.stringValue = calculateNextSessionTime()
        }
  
        func resetSessionAfterStretching() {
            updateSessionTime()
        }
  
  private func configureViews() {
    view.addSubview(stateStackView)
    view.addSubview(sessionStackView)
    view.addSubview(buttonStackView)
    view.addSubview(imageView)
    
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
    
    imageView.snp.makeConstraints { make in
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
