//
//  StretchingVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import AppKit

class StretchingVC: NSViewController {
    let cameraPreview           = NSView()
    let excerciseInfoView       = NSView()
    let videoPreview            = NSView()
    let nextExcerciseView       = NSView()
    let skipButton              = CLTextButtonV2(title: "Skip", backgroundColor: .black, foregroundColorText: .white, fontText: .boldSystemFont(ofSize: 16))
    let finishButton            = CLTextButtonV2(title: "Finish Early", backgroundColor: .systemRed, foregroundColorText: .white, fontText: .boldSystemFont(ofSize: 16))
    
    let padding: CGFloat        = 24

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureExcerciseInfoView()
        configureCameraPreview()
        configureVideoPreview()
        configureNextExcerciseView()
        configureButton()
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
    
    private func configureVideoPreview() {
        excerciseInfoView.addSubview(videoPreview)
        
        videoPreview.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubViewController(ExcerciseVideoVC(), to: videoPreview)
        
        NSLayoutConstraint.activate([
            videoPreview.topAnchor.constraint(equalTo: excerciseInfoView.topAnchor, constant: padding),
            videoPreview.leadingAnchor.constraint(equalTo: excerciseInfoView.leadingAnchor, constant: padding),
            videoPreview.trailingAnchor.constraint(equalTo: excerciseInfoView.trailingAnchor, constant: -16),
//            videoPreview.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func configureNextExcerciseView() {
        view.addSubview(nextExcerciseView)
        
        nextExcerciseView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubViewController(NextExcerciseVC(), to: nextExcerciseView)
        
        NSLayoutConstraint.activate([
            nextExcerciseView.leadingAnchor.constraint(equalTo: excerciseInfoView.leadingAnchor, constant: padding),
            nextExcerciseView.trailingAnchor.constraint(equalTo: excerciseInfoView.trailingAnchor, constant: -padding),
            nextExcerciseView.topAnchor.constraint(equalTo: videoPreview.bottomAnchor, constant: 32),
            nextExcerciseView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configureButton() {
        let buttonStack = NSStackView(views: [skipButton, finishButton])
        
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 10
        
        view.addSubview(buttonStack)
        
        buttonStack.translatesAutoresizingMaskIntoConstraints   = false
        
        skipButton.translatesAutoresizingMaskIntoConstraints    = false
        finishButton.translatesAutoresizingMaskIntoConstraints  = false
        
        NSLayoutConstraint.activate([
            buttonStack.leadingAnchor.constraint(equalTo: excerciseInfoView.leadingAnchor, constant: padding),
            buttonStack.bottomAnchor.constraint(equalTo: excerciseInfoView.bottomAnchor, constant: -padding),
            buttonStack.trailingAnchor.constraint(equalTo: excerciseInfoView.trailingAnchor, constant:  -padding),
            
            skipButton.heightAnchor.constraint(equalToConstant: 48),
            finishButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
}
