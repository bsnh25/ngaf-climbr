//
//  DayTimePreference.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 29/10/24.
//

import AppKit
import SnapKit




class DayTimePreferenceView: NSStackView {
    
//    var divider: Divider = Divider()
    var day: String!
    private var dayName: CLTextLabelV2!
    private var startWorkPicker: CLDatePicker!
    private var toLabel: CLTextLabelV2 = CLTextLabelV2(sizeOfFont: 18, weightOfFont: .regular, contentLabel: "to")
    private var endWorkPicker: CLDatePicker!
    private var gapTextAndPicker: CGFloat!
    private var switchButton: NSSwitch = NSSwitch()
//    var lastStartValue: Date!
//    var lastStopValue: Date!
  
    var currentStartWorkHour: Date!
    var currentEndWorkHour: Date!
  
    var onValueChanged: ((_ startHour: Date, _ endHour: Date) -> Void)?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    // Custom initializer
    init(dayName: String, startWorkPicker: CLDatePicker, endWorkPicker: CLDatePicker, gapTextAndPicker: CGFloat) {
        super.init(frame: .zero)
        self.dayName = CLTextLabelV2(sizeOfFont: 18, weightOfFont: .bold, contentLabel: dayName)
        self.startWorkPicker = startWorkPicker
        self.endWorkPicker = endWorkPicker
        self.gapTextAndPicker = gapTextAndPicker
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
    }
    
    private func setupStartPicker(){
        
        let calendar = Calendar.current
        var components = calendar.dateComponents([.hour, .minute], from: Date())
        components.hour = 8
        components.minute = 0
        
        if let date = calendar.date(from: components) {
            startWorkPicker.dateValue = date
            currentStartWorkHour = date
        }
//        lastStartValue = startWorkPicker.dateValue
        startWorkPicker.datePickerElements = [.hourMinute]
      
        // Set the minimum date (01:00)
        var minComponents = calendar.dateComponents([.hour, .minute], from: Date())
        minComponents.hour = 0
        minComponents.minute = 0
        if let minDate = calendar.date(from: minComponents) {
            startWorkPicker.minDate = minDate
        }
        
//         Set the maximum date (21:00)
        var maxComponents = calendar.dateComponents([.hour, .minute], from: Date())
        maxComponents.hour = 21
        maxComponents.minute = 59
        if let maxDate = calendar.date(from: maxComponents) {
            startWorkPicker.maxDate = maxDate
        }
        startWorkPicker.target = self
        startWorkPicker.action = #selector(startWorkHourChanged)
        
//        updateStopWorkHour()
    }
    
    private func setupEndPicker(){
        
//        lastStopValue = endWorkPicker.dateValue
        endWorkPicker.datePickerElements = [.hourMinute]
        
        endWorkPicker.minDate = startWorkPicker.dateValue.addingTimeInterval(2 * 60 * 60)
        endWorkPicker.dateValue = startWorkPicker.dateValue.addingTimeInterval(2 * 60 * 60)
        currentEndWorkHour = endWorkPicker.dateValue
        
        var maxStopComponents = Calendar.current.dateComponents([.hour, .minute], from: Date())
        maxStopComponents.hour = 23
        maxStopComponents.minute = 59
        
        if let maxStopDate = Calendar.current.date(from: maxStopComponents) {
            endWorkPicker.maxDate = maxStopDate
        }
      
        endWorkPicker.target = self
        endWorkPicker.action = #selector(stopWorkHourChanged)
//        updateStopWorkHour()
    }
    
    @objc func stopWorkHourChanged(_ sender: NSDatePicker) {
//        let calendar = Calendar.current
//        let difference = calendar.dateComponents([.minute], from: lastStartValue, to: lastStopValue)
        
//        if handleSpecialCases(oldTime: lastStopValue, newTime: endWorkPicker.dateValue){
//            endWorkPicker.dateValue = lastStopValue
//            return
//        }
//        
//        if difference.minute == 120 && isTimeDecreased(from: lastStopValue, to: endWorkPicker.dateValue) {
//            updateStartWorkHour()
//        }
//        
//        lastStopValue = endWorkPicker.dateValue
      
//      print("End Work Hours: ", sender.dateValue)
      currentEndWorkHour = sender.dateValue
      
      onValueChanged?(startWorkPicker.dateValue, endWorkPicker.dateValue)
    }
    
    
    @objc func startWorkHourChanged(_ sender: NSDatePicker) {
        let calendar = Calendar.current
        let difference = calendar.dateComponents([.minute], from: sender.dateValue, to: currentEndWorkHour)
//
        if difference.minute! < 120 {
          endWorkPicker.dateValue = sender.dateValue.addingTimeInterval(2 * 60 * 60)
        }
      
      endWorkPicker.minDate = sender.dateValue.addingTimeInterval(2 * 60 * 60)
//      print("Start Work Hours: ", sender.dateValue)
      currentStartWorkHour = sender.dateValue
      currentEndWorkHour = endWorkPicker.dateValue
      
      onValueChanged?(startWorkPicker.dateValue, endWorkPicker.dateValue)
    }
    
//    func updateStopWorkHour() {
//        let calendar = Calendar.current
//        let twoHours = DateComponents(hour: 2)
//        if let stopDate = calendar.date(byAdding: twoHours, to: startWorkPicker.dateValue) {
//            endWorkPicker.dateValue = stopDate
////            lastStopValue = stopDate
//        }
//    }
//    
//    func updateStartWorkHour() {
//        let calendar = Calendar.current
//        let minusTwoHours = DateComponents(hour: -2)
//        if let startDate = calendar.date(byAdding: minusTwoHours, to: endWorkPicker.dateValue) {
//            startWorkPicker.dateValue = startDate
////            lastStart7Value = startDate
//        }
//    }
//    
//    func isTimeIncreased(from oldTime: Date, to newTime: Date) -> Bool {
//        let calendar = Calendar.current
//        let oldComponents = calendar.dateComponents([.hour, .minute], from: oldTime)
//        let newComponents = calendar.dateComponents([.hour, .minute], from: newTime)
//        
//        let oldMinutes = oldComponents.hour! * 60 + oldComponents.minute!
//        let newMinutes = newComponents.hour! * 60 + newComponents.minute!
//        
//        let difference = (newMinutes - oldMinutes + 1440) % 1440
//        
//        return difference <= 720
//    }
//
//    func isTimeDecreased(from oldTime: Date, to newTime: Date) -> Bool {
//        return !isTimeIncreased(from: oldTime, to: newTime)
//    }
//    
//    func handleSpecialCases(oldTime: Date, newTime: Date) -> Bool {
//            let calendar = Calendar.current
//            let oldComponents = calendar.dateComponents([.hour, .minute], from: oldTime)
//            let newComponents = calendar.dateComponents([.hour, .minute], from: newTime)
//            
//            let oldHour = oldComponents.hour!
//            let newHour = newComponents.hour!
//            
//            // Special case: from 23:00-23:59 to 00:00-00:59 (next day)
//            if oldHour == 23 && newHour == 3 {
//                return true
//            }
//            
//            // Special case: from 00:00-00:59 to 23:00-23:59 (same day)
//            if oldHour == 3 && newHour == 23 {
//                return false
//            }
//            
//            // No special case detected
//            return false
//        }
//    
//    
//    override func hitTest(_ point: NSPoint) -> NSView? {
//            // Konversi titik dari superview ke koordinat view ini
//            let myPoint = convert(point, from: superview)
//            
//            // Cek startWorkPicker terlebih dahulu
//            if let startWorkPicker = startWorkPicker, startWorkPicker.frame.contains(myPoint) {
//                let pickerPoint = convert(myPoint, to: startWorkPicker)
//                if let hitView = startWorkPicker.hitTest(pickerPoint) {
//                    return hitView
//                }
//            }
//            
//            // Cek endWorkPicker jika startWorkPicker tidak meng-handle event
//            if let endWorkPicker = endWorkPicker, endWorkPicker.frame.contains(myPoint) {
//                let pickerPoint = convert(myPoint, to: endWorkPicker)
//                if let hitView = endWorkPicker.hitTest(pickerPoint) {
//                    return hitView
//                }
//            }
//            
//            // Jika tidak ada yang terkena, kembalikan hitTest default
//            return super.hitTest(point)
//        }
    
}


//#Preview(traits: .defaultLayout, body: {
//    DayTimePreference?(NSCoder())
//})
