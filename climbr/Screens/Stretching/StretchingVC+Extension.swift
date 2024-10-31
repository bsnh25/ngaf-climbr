//
//  StretchingVC+Extension.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import AppKit
import AVFoundation
import Swinject
import Vision

extension StretchingVC {
    func updateMovementData() {
        /// Stream the current index and update on its changed
        $currentIndex.sink { [weak self] index in
            guard let self else { return }
            
            guard let movement = self.setOfMovements[safe: index] else {
                return
            }
            
            self.currentMovementView.updateData(movement)
            self.currentMovementView.getIndexMovement(current: index, maxIndex: self.setOfMovements.count)
            self.speech(movement.name.rawValue)
            
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
        $nextIndex.sink { [weak self] index in
            guard let self else { return }
            
            guard let movement = self.setOfMovements[safe: index] else {
                return
            }
            
            self.nextMovementView.updateData(movement)
            
        }
        .store(in: &bags)
    }
    
    func updateMovementState() {
        
        $showTutorial.sink { value in
                    DispatchQueue.main.async {
                        if !value {
                            self.instructionView.hide()
                        } else {
                            self.instructionView.unhide()
                        }
                    }
                }
                .store(in: &bags)
                
                $exerciseName.sink { [weak self] name in
                    guard let self else { return }
                    
                    /// Get current movement data
                    guard let movement = self.setOfMovements[safe: self.currentIndex] else {
                        return
                    }
                    
                    guard !self.showTutorial else {
                        DispatchQueue.main.async {
                            self.movementStateView.hide()
                        }
                        self.pauseTimer()
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
                            
                            if name == .Still || name == .Negative {
                                label = "Please move according to the guidance"
                                self.movementStateView.setForegroundColor(.black)
                                self.movementStateView.setBackgroundColor(.white)
                            } else {
                                label = "Position Incorrect"
                                self.movementStateView.setForegroundColor(.black)
                                self.movementStateView.setBackgroundColor(.systemRed)
                                
//                                self.speech("incorrect")
                            }
                            
                            self.movementStateView.setLabel(label)
                          
                            self.speech(label)
                        } else {
//                            self.speech("correct")
                            self.speech("Position Correct")
                            self.startExerciseSession(duration: movement.duration)
        //                    self.movementStateView.hide()
                        }
                    }
                }.store(in: &bags)
        
        $remainingTime.sink { [weak self] time in
            guard let self else { return }
            
            /// Cancel code execution below if timer not running and timer is paused
            guard self.isTimerRunning, !self.isTimerPaused else { return }
            
            /// If remaining time equals to zero, then hide the movement state view and
            /// next to the next movement
            ///
            /// Assume that if remaining time is zero, it means the movement has done
            guard time > 0 else {
//                self.movementStateView.hide()
                
                self.next()
                
                return
            }
          
            switch time {
            case 13:
              self.speech("15 seconds countdown started")
            case 8:
              self.speech("\(Int(time)) seconds left")
            case 1...5:
              self.speech(String(Int(time)))
            default:
              break
            }
            
            self.movementStateView.setLabel("\(Int(time)) seconds left")
            self.movementStateView.setForegroundColor(.black)
            self.movementStateView.setBackgroundColor(.white)
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
      
        if currentIndex == setOfMovements.count - 1 {
          self.speech("completed session")
        } else {
          self.speech("next move")
        }
      
        self.updateProgress(movementsPassed: completedMovement)
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
    
    func speech(_ file: String) {
        guard let audioService else { return }

        audioService.speech(file)
    }

    func updateProgress(movementsPassed: [Movement]) {
        
        if movementsPassed.count > 0 {
            let neckMovements = movementsPassed.count { $0.type == .neck}
            let armMovements = movementsPassed.count { $0.type == .arm }
            let backMovements = movementsPassed.count { $0.type == .back }
            
            if neckMovements >= 1 {
                isNeckPassed = true
            } else {
                isNeckPassed = false
            }
            
            if armMovements >= 1 {
                isArmPassed = true
            } else {
                isArmPassed = false
            }
            
            if backMovements >= 1 {
                isBodyPassed = true
            } else {
                isBodyPassed = false
            }
            
        } else {
            print("Movement Passed is empty")
        }
        
    }
    
    func randomizeMovement(movements: [Movement]) -> [Movement] {
        var randomMovement: [Movement] = []
        
        let neckMovements = movements.filter { $0.type == .neck }
        let armMovements = movements.filter { $0.type == .arm }
        let backMovements = movements.filter { $0.type == .back }
        
        let randomizedNeck = neckMovements.shuffled()
        let randomizedArm = armMovements.shuffled()
        let randomizedBack = backMovements.shuffled()
        
        randomMovement.append(contentsOf: randomizedNeck)
        randomMovement.append(contentsOf: randomizedArm)
        randomMovement.append(contentsOf: randomizedBack)
        
        return randomMovement
    }
}


extension StretchingVC : PredictorDelegate {
    func predictor(didDetectUpperBody value: Bool, boundingBox: NSRect) {
        print(boundingBox)
        DispatchQueue.main.async {
//            self.boundingBoxView.updateRect(boundingBox, color: .yellow)
            if value {
                self.showTutorial = false
            }
        }
    }
  
    func predictor(didLabelAction action: String, with confidence: Double) {
        for name in ExerciseName.allCases {
            if name.rawValue == action && confidence > 0.65 {
                if exerciseName != name {
                    self.exerciseName = name
//                    print("\(name) and the confidence is \(confidence)")
                }
            }
        }
    }
    
    func predictor(didFindNewRecognizedPoints points: [CGPoint]) {
    }
    
}

extension StretchingVC : AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if connection.isVideoMirroringSupported && !connection.isVideoMirrored {
            connection.isVideoMirrored = true
        }
        self.predictor?.estimation(sampleBuffer: sampleBuffer)
        self.predictor?.detectHumanUpperBody(sampleBuffer: sampleBuffer)
    }
}
