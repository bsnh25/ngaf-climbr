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
    let cameraPreview           = NSView()
    let movementInfoView        = NSView()
    let movementStack           = NSStackView()
    let currentMovementView     = CurrentMovementView()
    let movementDivider         = Divider()
    let nextMovementView        = NextMovementView()
    let skipButton              = CLTextButtonV2(title: "Skip", backgroundColor: .black, foregroundColorText: .white, fontText: .boldSystemFont(ofSize: 16))
    let finishButton            = CLTextButtonV2(title: "Finish Early", backgroundColor: .systemRed, foregroundColorText: .white, fontText: .boldSystemFont(ofSize: 16))
    
    let padding: CGFloat        = 24
    
    @Published var currentIndex: Int               = 0
    @Published var nextIndex: Int                  = 1
    
    var completedMovement: [Movement]   = []
    
    var bags: Set<AnyCancellable> = []

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        configureCameraPreview()
        configureMovementView()
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
        super.viewDidAppear()
        cameraManager.startSession()
    }
    
    override func viewDidDisappear() {
        super.viewDidDisappear()
        cameraManager.stopSession()
    }
    
    private func configureCameraPreview() {
        cameraPreview.wantsLayer = true
        cameraPreview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cameraPreview)
        
        print("Success 1")
        
        if let captureSession = cameraManager.captureSession {
            captureSession.sessionPreset = .high
        }
            
        if let preview = cameraManager.previewLayer {
            preview.videoGravity = .resizeAspectFill
            preview.frame = cameraPreview.bounds
            cameraPreview.layer?.addSublayer(preview)
            print("Success preview")
        }
        
        print("Success 2")
        
//        super.viewDidLoad()
//                cameraView?.wantsLayer = true
//                cameraView?.layer?.backgroundColor = NSColor.black.cgColor
//                session.sessionPreset = AVCaptureSession.Preset.low
//                let input: AVCaptureInput = try! AVCaptureDeviceInput(device: AVCaptureDevice.default(for: .video)!)
//                session.addInput(input)
//                let previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
//                previewLayer.frame = cameraView!.bounds
//                previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//
//                cameraView?.layer?.addSublayer(previewLayer)
        
        
//        cameraPreview.wantsLayer = true
//        cameraPreview.layer?.backgroundColor = NSColor.black.cgColor
//        cameraManager.previewLayer.frame = cameraPreview.bounds
//        cameraPreview.layer?.addSublayer(cameraManager.previewLayer)
        
        
        
//        view.addSubview(cameraPreview)
        
//        cameraPreview.translatesAutoresizingMaskIntoConstraints = false
//         view.addSubview(cameraPreview)
//        cameraPreview.wantsLayer                = true
//        cameraPreview.layer?.backgroundColor    = NSColor.systemGray.cgColor.copy(alpha: 0.1)
        
//        if let previewLayer = cameraManager.previewLayer {
//            cameraPreview.layer?.addSublayer(previewLayer)
//            previewLayer.frame = cameraPreview.frame
//        }
//
//        let sampleText = NSTextField(labelWithString: "Camera Preview Goes Here")
//        
//        sampleText.translatesAutoresizingMaskIntoConstraints = false
//        
//        cameraPreview.addSubview(sampleText)
        
        NSLayoutConstraint.activate([
            cameraPreview.topAnchor.constraint(equalTo: view.topAnchor),
            cameraPreview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cameraPreview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            cameraPreview.trailingAnchor.constraint(equalTo: movementInfoView.leadingAnchor),
//            
//            sampleText.centerXAnchor.constraint(equalTo: cameraPreview.centerXAnchor),
//            sampleText.centerYAnchor.constraint(equalTo: cameraPreview.centerYAnchor),
        ])
//        
//        cameraPreview.wantsLayer = true
//        cameraPreview.layer?.backgroundColor = NSColor.black.cgColor
//        cameraManager.previewLayer.frame = cameraPreview.bounds
//        cameraPreview.layer?.addSublayer(cameraManager.previewLayer)
        print("Success 3")
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
