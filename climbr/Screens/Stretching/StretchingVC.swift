//
//  StretchingVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import AppKit

class StretchingVC: NSViewController {
    let cameraPreview = NSView()
    let excerciseInfoView = NSView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureExcerciseInfoView()
        configureCameraPreview()
    }
    
    private func configureCameraPreview() {
        view.addSubview(cameraPreview)
        
        cameraPreview.translatesAutoresizingMaskIntoConstraints = false
        cameraPreview.wantsLayer                = true
        cameraPreview.layer?.backgroundColor    = NSColor.systemGreen.cgColor
        
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
    
}
