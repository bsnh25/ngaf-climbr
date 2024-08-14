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
    let skipButton              = CLTextButtonV2(title: "Skip This Movement", backgroundColor: .black, foregroundColorText: .white, fontText: .boldSystemFont(ofSize: 14))
    let finishButton            = CLTextButtonV2(title: "Finish Early", backgroundColor: .systemRed, foregroundColorText: .white, fontText: .boldSystemFont(ofSize: 14))
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
    
    /// Dependencies
    var audioService: AudioService!
    
    init(audioService: AudioService) {
        super.init(nibName: nil, bundle: nil)
        
        self.audioService = audioService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

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
        
        updateMovementData()
        updateMovementState()

    }
    
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
        buttonStack.orientation     = .vertical
        
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
            
            skipButton.heightAnchor.constraint(equalToConstant: 38),
            skipButton.widthAnchor.constraint(equalTo: buttonStack.widthAnchor),
            
            finishButton.heightAnchor.constraint(equalToConstant: 38),
            finishButton.widthAnchor.constraint(equalTo: buttonStack.widthAnchor),
            
            divider.leadingAnchor.constraint(equalTo: buttonStack.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: buttonStack.trailingAnchor),
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
