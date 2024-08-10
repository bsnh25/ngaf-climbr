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
    let excerciseInfoView       = NSView()
    let currentMovementView     = CurrentMovementView()
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
        
        configureExcerciseInfoView()
        configureCameraPreview()
        configureStack()
        configureButton()
        
        $currentIndex.sink { index in
            let movement = Movement.items[index]
            
            self.currentMovementView.updateData(movement)
        }
        .store(in: &bags)
        
        $nextIndex.sink { index in
            let movement = Movement.items[index]
            
            self.nextMovementView.updateData(movement)
        }
        .store(in: &bags)

    }
    
    private func configureStack() {
        /// Create divider
        let divider             = Divider()
        
        /// Arrange video preview, divider, and next excercise vertically
        let stack               = NSStackView(views: [currentMovementView, divider, nextMovementView])
        stack.orientation       = .vertical
        stack.spacing           = 24
        stack.alignment         = .leading
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: excerciseInfoView.topAnchor, constant: padding),
            stack.leadingAnchor.constraint(equalTo: excerciseInfoView.leadingAnchor, constant: padding),
            stack.trailingAnchor.constraint(equalTo: excerciseInfoView.trailingAnchor, constant: -padding),
            
            currentMovementView.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            currentMovementView.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            
            nextMovementView.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            nextMovementView.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            
            divider.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
        ])
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
            cameraPreview.trailingAnchor.constraint(equalTo: excerciseInfoView.leadingAnchor),
            
            sampleText.centerXAnchor.constraint(equalTo: cameraPreview.centerXAnchor),
            sampleText.centerYAnchor.constraint(equalTo: cameraPreview.centerYAnchor),
        ])
    }
    
    private func configureExcerciseInfoView() {
        view.addSubview(excerciseInfoView)
        
        excerciseInfoView.translatesAutoresizingMaskIntoConstraints = false
        excerciseInfoView.wantsLayer                = true
        excerciseInfoView.layer?.backgroundColor    = .white
        
        NSLayoutConstraint.activate([
            excerciseInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            excerciseInfoView.topAnchor.constraint(equalTo: view.topAnchor),
            excerciseInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            excerciseInfoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
        ])
    }
    
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
            buttonStack.leadingAnchor.constraint(equalTo: excerciseInfoView.leadingAnchor, constant: padding),
            buttonStack.bottomAnchor.constraint(equalTo: excerciseInfoView.bottomAnchor, constant: -padding),
            buttonStack.trailingAnchor.constraint(equalTo: excerciseInfoView.trailingAnchor, constant:  -padding),
            
            skipButton.heightAnchor.constraint(equalToConstant: 48),
            finishButton.heightAnchor.constraint(equalToConstant: 48),
            
            divider.leadingAnchor.constraint(equalTo: excerciseInfoView.leadingAnchor, constant: padding),
            divider.trailingAnchor.constraint(equalTo: excerciseInfoView.trailingAnchor, constant: -padding),
            divider.bottomAnchor.constraint(equalTo: buttonStack.topAnchor, constant: -padding),
        ])
    }
}
