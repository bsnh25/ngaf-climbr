//
//  StretchingVC+Extension.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import AppKit
import AVFoundation
import AudioToolbox

extension StretchingVC {
    /// Excercise session
    func startExerciseSession(duration: TimeInterval) {
        /// If movement is correct, run the timer based on previous state (start or resume)
        if self.isTimerPaused {
            self.resumeTimer()
        } else {
            self.startTimer(duration: duration)
        }
    }
    
    /// Timer countdown
    func startTimer(duration: TimeInterval?) {
        
        /// If duration exist, it means the app will start timer based on duration.
        /// Otherwise, app will start timer based on previous duration (resume)
        if let duration {
            remainingTime   = duration
            timerInterval   = duration
        }
        
        guard !isTimerRunning, !isTimerPaused else { return }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        isTimerRunning  = true
    }
    
    @objc private func updateTimer() {
        /// If remaining time equals to zero, then stop timer
        guard remainingTime > 0 else {
            stopTimer()
            return
        }
        
        /// Decrease remaining time by 1
        remainingTime -= 1
        
        print("Remaining Time: ", remainingTime)
    }
    
    func stopTimer() {
        /// Make sure the timer is running
        guard isTimerRunning else { return }
        
        /// Set the timer running and paused to false (reset), then invalidate the timer
        isTimerRunning  = false
        isTimerPaused   = false
        timer?.invalidate()
    }
    
    func pauseTimer() {
        /// Make sure the timer is running
        guard isTimerRunning else { return }
        
        /// Invalidate the timer, then set timer pause state to true and timer running to false
        timer?.invalidate()
        isTimerPaused  = true
        isTimerRunning = false
    }
    
    func resumeTimer() {
        /// Make sure the timer paused and timer not runnning
        guard isTimerPaused, !isTimerRunning else { return }
        
        /// Set the timer pause to false
        isTimerPaused   = false
        
        /// The start the timer again
        startTimer(duration: nil)
    }
    
    @objc func skip() {
//        cameraManager.stopSession()
        guard let _ = Movement.items[safe: currentIndex+1] else {
            return
        }
        
        currentIndex += 1
        nextIndex     = currentIndex+1
    }
    
    func next() {
        completedMovement.append(Movement.items[currentIndex])

        skip()
    }
    
    func finishEarly() {
        self.cameraManager.stopSession()
        self.replace(with: StretchingResultVC())
    }
    
    @objc func showEndSessionAlert() {
        let alert                   = NSAlert()
        alert.messageText           = "Leaving So Soon?"
        alert.informativeText       = "Finishing the session early will reduce the amount of reward you will receive"
        alert.alertStyle            = .informational
        alert.icon                  = NSImage.appLogo
        alert.addButton(withTitle: "Stay")
        alert.addButton(withTitle: "End Session")
        
        if #available(macOS 11.0,*) {
            alert.buttons.last?.hasDestructiveAction = true
        }
        
        let result = alert.runModal()
        
        if result == .alertSecondButtonReturn {
            finishEarly()
        }
    }
    
    
}

extension StretchingVC : PredictorDelegate {
    func predictor(_ predictor: Predictor, didLabelAction action: String, with confidence: Double) {
        
        for name in ExerciseName.allCases {
            if name.rawValue == action && confidence > 0.5{
                if exerciseName != name {
                    exerciseName = name
                    print("\(name) and the confidence is \(confidence)")
                }
            }
        }
    }
    
    func predictor(_ predictor: Predictor, didFindNewRecognizedPoints points: [CGPoint]) {
        guard let previewLayer = cameraManager.previewLayer else {return}
        
        let convertedPoints = points.map{
            previewLayer.layerPointConverted(fromCaptureDevicePoint: $0)
        }
        
        let combinePath = CGMutablePath()
        
        for point in convertedPoints {
            let doPath = NSBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: 10, height: 10))
            combinePath.addPath(doPath.cgPath)
        }
        
        pointsLayer.path = combinePath
        
        DispatchQueue.main.async{
            self.pointsLayer.didChangeValue(for: \.path)
        }
    }
    
    
}

