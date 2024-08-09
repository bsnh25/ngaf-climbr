//
//  ExcerciseVideoVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 09/08/24.
//

import AppKit

class ExcerciseVideoVC: NSViewController {
    let currentExcerciseLabel   = NSTextField(labelWithString: "Now: Upper Back Stretch")
    let excerciseVideoPreview   = NSView()
    let durationImageView       = NSImageView()
    let durationLabel           = NSTextField(labelWithString: "15 seconds")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureCurrentExcerciseLabel()
        configureExcerciseVideoPreview()
        configureDurationLabel()
    }
    
    private func configureUI() {
        let views = [currentExcerciseLabel, excerciseVideoPreview, durationImageView, durationLabel]
        
        for itemView in views {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureCurrentExcerciseLabel() {
        currentExcerciseLabel.translatesAutoresizingMaskIntoConstraints = false
        currentExcerciseLabel.font = NSFont.systemFont(ofSize: 22, weight: .bold)
        
        NSLayoutConstraint.activate([
            currentExcerciseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currentExcerciseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currentExcerciseLabel.topAnchor.constraint(equalTo: view.topAnchor),
            currentExcerciseLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func configureExcerciseVideoPreview() {
        excerciseVideoPreview.translatesAutoresizingMaskIntoConstraints = false
        excerciseVideoPreview.wantsLayer                = true
        excerciseVideoPreview.layer?.backgroundColor    = NSColor.systemGray.cgColor
        excerciseVideoPreview.layer?.cornerRadius       = 10
        
        NSLayoutConstraint.activate([
            excerciseVideoPreview.topAnchor.constraint(equalTo: currentExcerciseLabel.bottomAnchor, constant: 24),
            excerciseVideoPreview.trailingAnchor.constraint(equalTo: currentExcerciseLabel.trailingAnchor),
            excerciseVideoPreview.leadingAnchor.constraint(equalTo: currentExcerciseLabel.leadingAnchor),
            excerciseVideoPreview.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureDurationLabel() {
        let iconConfig                          = NSImage.SymbolConfiguration(pointSize: 26, weight: .bold)
        durationImageView.image                 = NSImage(systemSymbolName: "timer", accessibilityDescription: "Duration")
        durationImageView.symbolConfiguration   = iconConfig
        
        durationLabel.font                      = NSFont.systemFont(ofSize: 26, weight: .bold)
        
        NSLayoutConstraint.activate([
            durationImageView.leadingAnchor.constraint(equalTo: excerciseVideoPreview.leadingAnchor),
            durationImageView.topAnchor.constraint(equalTo: excerciseVideoPreview.bottomAnchor, constant: 24),
            durationImageView.widthAnchor.constraint(equalToConstant: 32),
            durationImageView.heightAnchor.constraint(equalToConstant: 32),
            
            durationLabel.leadingAnchor.constraint(equalTo: durationImageView.trailingAnchor, constant: 8),
            durationLabel.centerYAnchor.constraint(equalTo: durationImageView.centerYAnchor),
            durationLabel.trailingAnchor.constraint(equalTo: excerciseVideoPreview.trailingAnchor)
        ])
    }
    
}

#Preview(traits: .defaultLayout, body: {
    ExcerciseVideoVC()
})
