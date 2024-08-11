//
//  StretchingVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import AppKit
import Combine

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
    var pointsLayer             = CAShapeLayer()
    
    let padding: CGFloat        = 24
    
    @Published var currentIndex: Int               = 0
    @Published var nextIndex: Int                  = 1
    
    var completedMovement: [Movement]   = []
    
    var bags: Set<AnyCancellable> = []

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        configureCameraPreview()
        configureMovementView()
        cameraManager.predictor.delegate = self
        
        configureButton()
        
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
        
        /// Stream the next index and update on its changed
        $nextIndex.sink { index in
            guard let movement = Movement.items[safe: index] else {
                
                return
            }
            
            self.nextMovementView.updateData(movement)
            
        }
        .store(in: &bags)

    }
    
    override func viewDidAppear() {
        cameraManager.startSession()
        super.viewDidAppear()
        
    }
    
    override func viewDidDisappear() {
        cameraManager.stopSession()
        super.viewDidDisappear()
        
    }
    
    private func setupVideoPreview(){
//        videoCapture.startSession()
//        previewLayer = AVCaptureVideoPreviewLayer(session: cameraManager.captureSession)
        
        guard let previewLayer = cameraManager.previewLayer else {return}
        
        cameraPreview.layer?.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        cameraPreview.layer?.addSublayer(pointsLayer)
        pointsLayer.frame = view.frame
        pointsLayer.strokeColor = NSColor.red.cgColor
    }
    
    private func configureCameraPreview() {
        cameraPreview.wantsLayer = true
        cameraPreview.setupPreviewLayer(with: cameraManager)
        cameraPreview.addOtherSubLayer(layer: pointsLayer)
        
        cameraPreview.translatesAutoresizingMaskIntoConstraints = false
        
        setupVideoPreview()
        
        view.addSubview(cameraPreview)
        
        NSLayoutConstraint.activate([
            cameraPreview.topAnchor.constraint(equalTo: view.topAnchor),
            cameraPreview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cameraPreview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cameraPreview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
//    / Configure the movement sidebar info
//    /
//    / Set the background to white, width equal to 0.3 of the window width
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
            movementStack.topAnchor.constraint(equalTo: movementInfoView.topAnchor, constant: padding),
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
        finishButton.action = #selector(skip)
        
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
}
