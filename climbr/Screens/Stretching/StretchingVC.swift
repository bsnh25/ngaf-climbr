//
//  StretchingVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import AppKit
import Combine

class StretchingVC: NSViewController {
    let cameraPreview           = NSView()
    let movementInfoView        = NSView()
    let movementStack           = NSStackView()
    let currentMovementView     = CurrentMovementView()
    let movementDivider         = Divider()
    let nextMovementView        = NextMovementView()
    let skipButton              = CLTextButtonV2(title: "Skip", backgroundColor: .black, foregroundColorText: .white, fontText: .boldSystemFont(ofSize: 16))
    let finishButton            = CLTextButtonV2(title: "Finish Early", backgroundColor: .systemRed, foregroundColorText: .white, fontText: .boldSystemFont(ofSize: 16))
    let positionStateLabel      = CLLabel(fontSize: 16, fontWeight: .bold)
    
    let padding: CGFloat        = 24
    
    @Published var currentIndex: Int               = 0
    @Published var nextIndex: Int                  = 1
    
    var completedMovement: [Movement]   = []
    
    var bags: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMovementView()
        configureCameraPreview()
        configureButton()
        configurePositionStateLabel()
        
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
    
    private func configureCameraPreview() {
        view.addSubview(cameraPreview)
        
        cameraPreview.translatesAutoresizingMaskIntoConstraints = false
        cameraPreview.wantsLayer                = true
        cameraPreview.layer?.backgroundColor    = NSColor.systemGray.cgColor.copy(alpha: 0.1)
        
        let sampleText = NSTextField(labelWithString: "Camera Preview Goes Here")
        
        sampleText.translatesAutoresizingMaskIntoConstraints = false
        
        cameraPreview.addSubview(sampleText)
        
        NSLayoutConstraint.activate([
            cameraPreview.topAnchor.constraint(equalTo: view.topAnchor),
            cameraPreview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cameraPreview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cameraPreview.trailingAnchor.constraint(equalTo: movementInfoView.leadingAnchor),
            
            sampleText.centerXAnchor.constraint(equalTo: cameraPreview.centerXAnchor),
            sampleText.centerYAnchor.constraint(equalTo: cameraPreview.centerYAnchor),
        ])
    }
    
    /// Configure the movement sidebar info
    ///
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
        finishButton.action = #selector(finishEarly)
        
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
        let container = NSView()
        cameraPreview.addSubview(container)
        
        container.translatesAutoresizingMaskIntoConstraints          = false
        positionStateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        positionStateLabel.setText("Position Incorrect")
        positionStateLabel.backgroundColor  = .clear
        
        container.addSubview(positionStateLabel)
        container.wantsLayer                = true
        container.layer?.backgroundColor    = .white
        container.layer?.cornerRadius       = 10
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: cameraPreview.safeAreaLayoutGuide.topAnchor, constant: padding),
            container.centerXAnchor.constraint(equalTo: cameraPreview.centerXAnchor),
            container.widthAnchor.constraint(equalTo: cameraPreview.widthAnchor, multiplier: 0.3),
            container.heightAnchor.constraint(equalToConstant: 48),
            
            positionStateLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            positionStateLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
        ])
    }
}
