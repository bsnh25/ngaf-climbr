//
//  StretchingVC+Extension.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import AppKit
import AVFoundation
import Swinject

extension StretchingVC {
    func updateMovementData() {
        /// Stream the current index and update on its changed
        $currentIndex.sink { index in
            guard let movement = self.setOfMovements[safe: index] else {
                return
            }
            
            self.currentMovementView.updateData(movement)
            
            /// Disable skip button and remove next movement view
            /// if next index equals to items last index
            if index == self.setOfMovements.count - 1 {
                self.skipButton.isEnabled = false
                
                self.movementStack.removeView(self.movementDivider)
                self.movementStack.removeView(self.nextMovementView)
            }
        }
        .store(in: &bags)
        
        /// Stream the next index and update on its changed
        $nextIndex.sink { index in
            guard let movement = self.setOfMovements[safe: index] else {
                return
            }
            
            self.nextMovementView.updateData(movement)
            
        }
        .store(in: &bags)
    }
    
    func updateMovementState() {
        $exerciseName.sink { name in
            /// Get current movement data
            guard let movement = self.setOfMovements[safe: self.currentIndex] else {
                return
            }
            
            /// Return true if the name equals to current movement
            let positionState   = name == movement.name
            
            DispatchQueue.main.async {
                
                /// Make sure to unhide the movement state view
                self.movementStateView.unhide()
                
                if !positionState {
                    /// Pause the timer if movement incorrect
                    self.pauseTimer()
                    
                    /// Set label, foreground, and background color based on each state
                    var label: String = "Please move according to the guidance"
                    
                    if name == .Still {
                        label = "Please move according to the guidance"
                        self.movementStateView.setForegroundColor(.black)
                        self.movementStateView.setBackgroundColor(.white)
                    } else {
                        label = "Position Incorrect"
                        self.movementStateView.setForegroundColor(.white)
                        self.movementStateView.setBackgroundColor(.systemRed)
                        
                        self.playSfx("incorrect")
                    }
                    
                    self.movementStateView.setLabel(label)
                } else {
                    self.playSfx("correct")
                    self.startExerciseSession(duration: movement.duration)
                    self.movementStateView.hide()
                }
            }
        }.store(in: &bags)
        
        $remainingTime.sink { time in
            
            /// Cancel code execution below if timer not running and timer is paused
            guard self.isTimerRunning, !self.isTimerPaused else { return }
            
            /// If remaining time equals to zero, then hide the movement state view and
            /// next to the next movement
            ///
            /// Assume that if remaining time is zero, it means the movement has done
            guard time > 0 else {
                self.movementStateView.hide()
                
                self.next()
                
                return
            }
            
            self.currentMovementView.setDuration(time)
        }
        .store(in: &bags)
    }
    
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
        guard !isTimerRunning, !isTimerPaused else { return }
        
        /// If duration exist, it means the app will start timer based on duration.
        /// Otherwise, app will start timer based on previous duration (resume)
        if let duration {
            remainingTime   = duration
            timerInterval   = duration
        }
        
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
    
    @objc func skip() -> Bool {
        guard let _ = setOfMovements[safe: currentIndex+1] else {
            return false
        }
        
        currentIndex += 1
        nextIndex     = currentIndex+1
        stopTimer()
        movementStateView.hide()
        
        return true
    }
    
    func next() {
        /// Make sure movement index is not out of range
        guard let movement = setOfMovements[safe: currentIndex] else {
            return
        }
        
        self.completedMovement.append(movement)
        
        self.playSfx("next-move")

        let canSkip = skip()
        
        guard canSkip else {
            finishSession()
            return
        }
    }
    
    func finishSession() {
        self.cameraService?.stopSession()
        
        if let stretchingResult = Container.shared.resolve(StretchingResultVC.self) {
            stretchingResult.movementList = self.completedMovement
            self.replace(with: stretchingResult)
        }
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
            finishSession()
        }
    }
    
    
}

extension StretchingVC : PredictorDelegate {
    func predictor(_ predictor: Predictor, didLabelAction action: String, with confidence: Double) {
        
        for name in ExerciseName.allCases {
            if name.rawValue == action && confidence > 0.5{
                if exerciseName != name {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.exerciseName = name
                    }
                    print("\(name) and the confidence is \(confidence)")
                }
            }
        }
    }
    
    func predictor(_ predictor: Predictor, didFindNewRecognizedPoints points: [CGPoint]) {
        guard let previewLayer = cameraService?.previewLayer else {return}
        
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
    
    func playSfx(_ file: String) {
        guard let audioService else { return }
        
        audioService.playSFX(fileName: file)
    }
    
}

extension StretchingVC : AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if connection.isVideoMirroringSupported && !connection.isVideoMirrored {
            connection.isVideoMirrored = true
        }
        predictor.estimation(sampleBuffer: sampleBuffer)
    }
}
