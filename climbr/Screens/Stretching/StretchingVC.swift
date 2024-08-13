//
//  StretchingVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import AppKit
import Combine
import AVFoundation

class StretchingVC: NSViewController {
    let cameraManager           = CameraManager()
    let cameraPreview           = CameraPreviewView()
    let movementInfoView        = NSView()
    let movementStack           = NSStackView()
    let currentMovementView     = CurrentMovementView()
    let movementDivider         = Divider()
    let nextMovementView        = NextMovementView()
    let skipButton              = CLTextButtonV2(title: "Skip", backgroundColor: .black, foregroundColorText: .white, fontText: .boldSystemFont(ofSize: 16))
    let finishButton            = CLTextButtonV2(title: "Finish Early", backgroundColor: .systemRed, foregroundColorText: .white, fontText: .boldSystemFont(ofSize: 16))
    let positionStateView       = NSView()
    let positionStateLabel      = CLLabel(fontSize: 16, fontWeight: .bold)
    let movementStateView       = MovementStateView()
    let predictor               = Predictor()
    
    var pointsLayer             = CAShapeLayer()
    let padding: CGFloat        = 24
    
    
    @Published var exerciseName : ExerciseName = .Still
    
    @Published var currentIndex: Int               = 0
    @Published var nextIndex: Int                  = 1
    
    var completedMovement: [Movement]   = []
    
    var bags: Set<AnyCancellable> = []
    
    @Published var remainingTime: TimeInterval = TimeInterval()
    var timerInterval: TimeInterval = TimeInterval()
    var timer: Timer?
    var isTimerRunning: Bool = false
    var isTimerPaused: Bool = false
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        cameraManager.startSession()
        configureCameraPreview()
        configureMovementView()
        predictor.delegate = self
        cameraManager.videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoDispatchQueue"))
        
        configureButton()
        configurePositionStateLabel()
        
        view.wantsLayer = true
        
        /// Stream the current index and update on its changed
        $currentIndex.sink { index in
            let movement = Movement.items[index]
            
            self.currentMovementView.updateData(movement)
            
            /// Disable skip button and remove next movement view
            /// if next index equals to items last index
            if index == Movement.items.count - 1 {
                self.skipButton.isEnabled = false
                
                self.movementStack.removeView(self.movementDivider)
                self.movementStack.removeView(self.nextMovementView)
            }
        }
        .store(in: &bags)
        
        $exerciseName.sink { name in
            /// Get current movement data
            let movement = Movement.items[self.currentIndex]
            
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
                    }
                    
                    self.movementStateView.setLabel(label)
                } else {
                    
                    self.startExerciseSession(duration: movement.duration)
                    /// Hide the movement state view if the movement is correct
//                    self.movementStateView.hide()
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
            
            /// Set the label for current remaining time
            let label = "Hold for \(time) seconds"
            self.movementStateView.setLabel(label)
            
            self.movementStateView.setForegroundColor(.white)
            self.movementStateView.setBackgroundColor(.systemGreen)
        }
        .store(in: &bags)
        
        /// Stream the next index and update on its changed
        $nextIndex.sink { index in
            guard let movement = Movement.items[safe: index] else {
                
                return
            }
            
            self.nextMovementView.updateData(movement)
            
        }
        .store(in: &bags)

    }
    
//    override func viewDidAppear() {
//        super.viewDidAppear()
//        cameraManager.startSession()
//    }
//    
    override func viewDidDisappear() {
        super.viewDidDisappear()
        cameraManager.stopSession()
        
        stopTimer()
    }
    
    private func setupVideoPreview(){
        
        guard let previewLayer  = cameraManager.previewLayer else {return}
        
        cameraPreview.layer?.addSublayer(previewLayer)
        previewLayer.frame      = view.frame
        
        pointsLayer.frame       = view.frame
        pointsLayer.strokeColor = NSColor.red.cgColor
    }
    
    private func configureCameraPreview() {
        cameraPreview.wantsLayer                = true
        cameraPreview.layer?.backgroundColor    = .black
        
        cameraPreview.setupPreviewLayer(with: cameraManager)
        cameraPreview.addOtherSubLayer(layer: pointsLayer)
        
        cameraPreview.translatesAutoresizingMaskIntoConstraints = false
        
        setupVideoPreview()
        
        view.addSubview(cameraPreview)
        
        NSLayoutConstraint.activate([
            cameraPreview.topAnchor.constraint(equalTo: view.topAnchor),
            cameraPreview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -300),
            cameraPreview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cameraPreview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    /// Configure the movement sidebar info
    /// Set the background to white, width equal to 0.3 of the window width
    
    private func configureMovementView() {
        view.addSubview(movementInfoView)
        
        movementInfoView.translatesAutoresizingMaskIntoConstraints = false
        movementInfoView.wantsLayer                = true
        movementInfoView.layer?.backgroundColor    = .white
        
        NSLayoutConstraint.activate([
            movementInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movementInfoView.topAnchor.constraint(equalTo: view.topAnchor),
            movementInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movementInfoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
        ])
        
        configureMovementStack()
    }
    
    private func configureMovementStack() {
        /// Arrange current movement view, divider, and next movement vertically
        movementStack.setViews([currentMovementView, movementDivider, nextMovementView], in: .leading)
        movementStack.orientation       = .vertical
        movementStack.spacing           = 24
        movementStack.alignment         = .leading
        movementStack.translatesAutoresizingMaskIntoConstraints = false
        
        movementInfoView.addSubview(movementStack)
        
        NSLayoutConstraint.activate([
            movementStack.topAnchor.constraint(equalTo: movementInfoView.safeAreaLayoutGuide.topAnchor, constant: padding),
            movementStack.leadingAnchor.constraint(equalTo: movementInfoView.leadingAnchor, constant: padding),
            movementStack.trailingAnchor.constraint(equalTo: movementInfoView.trailingAnchor, constant: -padding),
            
            currentMovementView.leadingAnchor.constraint(equalTo: movementStack.leadingAnchor),
            currentMovementView.trailingAnchor.constraint(equalTo: movementStack.trailingAnchor),
            
            nextMovementView.leadingAnchor.constraint(equalTo: movementStack.leadingAnchor),
            nextMovementView.trailingAnchor.constraint(equalTo: movementStack.trailingAnchor),
            
            movementDivider.leadingAnchor.constraint(equalTo: movementStack.leadingAnchor),
            movementDivider.trailingAnchor.constraint(equalTo: movementStack.trailingAnchor),
        ])
    }
    
    /// Configure button horizontally
    private func configureButton() {
        let divider                 = Divider()
        let buttonStack             = NSStackView(views: [skipButton, finishButton])
        
        buttonStack.distribution    = .fillEqually
        buttonStack.spacing         = 10
        
        view.addSubview(buttonStack)
        view.addSubview(divider)
        
        buttonStack.translatesAutoresizingMaskIntoConstraints   = false
        
        skipButton.translatesAutoresizingMaskIntoConstraints    = false
        finishButton.translatesAutoresizingMaskIntoConstraints  = false
        
        /// Configure target button
        skipButton.target = self
        skipButton.action = #selector(skip)
        
        finishButton.target = self
        finishButton.action = #selector(showEndSessionAlert)
        finishButton.hasDestructiveAction = true
        
        NSLayoutConstraint.activate([
            buttonStack.leadingAnchor.constraint(equalTo: movementInfoView.leadingAnchor, constant: padding),
            buttonStack.bottomAnchor.constraint(equalTo: movementInfoView.bottomAnchor, constant: -padding),
            buttonStack.trailingAnchor.constraint(equalTo: movementInfoView.trailingAnchor, constant:  -padding),
            
            skipButton.heightAnchor.constraint(equalToConstant: 48),
            finishButton.heightAnchor.constraint(equalToConstant: 48),
            
            divider.leadingAnchor.constraint(equalTo: movementInfoView.leadingAnchor, constant: padding),
            divider.trailingAnchor.constraint(equalTo: movementInfoView.trailingAnchor, constant: -padding),
            divider.bottomAnchor.constraint(equalTo: buttonStack.topAnchor, constant: -padding),
        ])
    }
    
    private func configurePositionStateLabel() {
        cameraPreview.addSubview(movementStateView)
        
        NSLayoutConstraint.activate([
            movementStateView.topAnchor.constraint(equalTo: cameraPreview.safeAreaLayoutGuide.topAnchor, constant: padding),
            movementStateView.centerXAnchor.constraint(equalTo: cameraPreview.centerXAnchor),
            movementStateView.widthAnchor.constraint(equalTo: cameraPreview.widthAnchor, multiplier: 0.3),
            movementStateView.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}
