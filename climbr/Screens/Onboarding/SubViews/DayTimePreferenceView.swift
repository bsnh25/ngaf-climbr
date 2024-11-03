//
//  DayTimePreference.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 29/10/24.
//

import AppKit
import SnapKit




class DayTimePreferenceView: NSStackView {
    
    private lazy var calendar = Calendar.current
    var day: String!
    private var dayName: CLTextLabelV2!
    private var startWorkPicker: CLDatePicker = CLDatePicker(
      backgroundColor: .white.withAlphaComponent(0.5),
      textColor: .black,
      datePickerStyleElement: .hourMinute,
      font: NSFont.systemFont(ofSize: 18.3)
    )
    private var toLabel: CLTextLabelV2 = CLTextLabelV2(sizeOfFont: 18, weightOfFont: .regular, contentLabel: "to")
    private var endWorkPicker: CLDatePicker = CLDatePicker(
      backgroundColor: .white.withAlphaComponent(0.5),
      textColor: .black,
      datePickerStyleElement: .hourMinute,
      font: NSFont.systemFont(ofSize: 18.3)
    )
    private var gapTextAndPicker: CGFloat!
    private var switchButton: NSSwitch = NSSwitch()
  
    lazy var currentStartWorkHour: Date = {
        var components = calendar.dateComponents([.year,.month,.day,.hour,.minute], from: Date())
      components.hour = 8
      components.minute = 0
      
      return calendar.date(from: components)!
    }()
    lazy var currentEndWorkHour: Date = {
      currentStartWorkHour.addingTimeInterval(2 * 60 * 60)
    }()
  
    var initialStartValue: Date?
    var initialEndValue: Date?
  
    var onValueChanged: ((_ startHour: Date, _ endHour: Date) -> Void)?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    // Custom initializer
    init(dayName: String) {
        super.init(frame: .zero)
        self.dayName = CLTextLabelV2(sizeOfFont: 18, weightOfFont: .bold, contentLabel: dayName)
        day = dayName
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func configure(){
        
        let pickerStack = NSStackView(views: [startWorkPicker, toLabel, endWorkPicker])
        pickerStack.spacing = 12
        
        setViews([dayName, NSView(), pickerStack], in: .center)
        distribution = .equalSpacing
      
        setupStartPicker()
        setupEndPicker()
      
        onValueChanged?(currentStartWorkHour, currentEndWorkHour)
    }
    
    private func setupStartPicker(){
        startWorkPicker.dateValue = initialStartValue ?? currentStartWorkHour
        startWorkPicker.datePickerElements = [.hourMinute]
      
        // Set the minimum date (00:00)
        var minComponents = calendar.dateComponents([.year,.month,.day,.hour,.minute], from: Date())
        minComponents.hour = 0
        minComponents.minute = 0
        if let minDate = calendar.date(from: minComponents) {
            startWorkPicker.minDate = minDate
        }
        
//         Set the maximum date (21:59)
        var maxComponents = calendar.dateComponents([.year,.month,.day,.hour,.minute], from: Date())
        maxComponents.hour = 21
        maxComponents.minute = 59
        if let maxDate = calendar.date(from: maxComponents) {
            startWorkPicker.maxDate = maxDate
        }
        startWorkPicker.target = self
        startWorkPicker.action = #selector(startWorkHourChanged)
    }
    
    private func setupEndPicker(){
        endWorkPicker.datePickerElements = [.hourMinute]
        
        endWorkPicker.minDate = currentStartWorkHour.addingTimeInterval(2 * 60 * 60)
        endWorkPicker.dateValue = (initialStartValue ?? currentStartWorkHour).addingTimeInterval(2 * 60 * 60)
        currentEndWorkHour = endWorkPicker.dateValue
        
        var maxStopComponents = calendar.dateComponents([.year,.month,.day,.hour,.minute], from: Date())
        maxStopComponents.hour = 23
        maxStopComponents.minute = 59
        
        if let maxStopDate = calendar.date(from: maxStopComponents) {
            endWorkPicker.maxDate = maxStopDate
        }
      
        endWorkPicker.target = self
        endWorkPicker.action = #selector(stopWorkHourChanged)
    }
    
    @objc func stopWorkHourChanged(_ sender: NSDatePicker) {
      currentEndWorkHour = sender.dateValue
      
      onValueChanged?(currentStartWorkHour, currentEndWorkHour)
    }
    
    
    @objc func startWorkHourChanged(_ sender: NSDatePicker) {
        let difference = calendar.dateComponents([.minute], from: sender.dateValue, to: currentEndWorkHour)
//
        if difference.minute! < 120 {
          endWorkPicker.dateValue = sender.dateValue.addingTimeInterval(2 * 60 * 60)
        }
      
      endWorkPicker.minDate = sender.dateValue.addingTimeInterval(2 * 60 * 60)
      currentStartWorkHour = sender.dateValue
      
      currentEndWorkHour = endWorkPicker.dateValue
      
      onValueChanged?(currentStartWorkHour, currentEndWorkHour)
    }
  
    func reset() {
      if let date = initialStartValue {
        startWorkPicker.dateValue = date
      }
      
      if let date = initialEndValue {
        endWorkPicker.dateValue = date
      }
    }
    
}
