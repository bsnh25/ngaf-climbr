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
    let durationContainerView   = NSStackView()
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
        let views = [currentExcerciseLabel, excerciseVideoPreview, durationContainerView]
        
        for itemView in views {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureCurrentExcerciseLabel() {
        currentExcerciseLabel.translatesAutoresizingMaskIntoConstraints = false
        currentExcerciseLabel.font = NSFont.systemFont(ofSize: 20, weight: .bold)
        
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
        excerciseVideoPreview.layer?.backgroundColor    = NSColor.systemGray.cgColor.copy(alpha: 0.5)
        excerciseVideoPreview.layer?.cornerRadius       = 10
        
        NSLayoutConstraint.activate([
            excerciseVideoPreview.topAnchor.constraint(equalTo: currentExcerciseLabel.bottomAnchor, constant: 16),
            excerciseVideoPreview.trailingAnchor.constraint(equalTo: currentExcerciseLabel.trailingAnchor),
            excerciseVideoPreview.leadingAnchor.constraint(equalTo: currentExcerciseLabel.leadingAnchor),
            excerciseVideoPreview.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureDurationLabel() {
//        durationContainerView.addSubview(durationImageView)
//        durationContainerView.addSubview(durationLabel)
        
        let iconConfig                          = NSImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        durationImageView.image                 = NSImage(systemSymbolName: "timer", accessibilityDescription: "Duration")
        durationImageView.symbolConfiguration   = iconConfig
        
        durationContainerView.setViews([durationImageView, durationLabel], in: .center)
        durationContainerView.spacing           = 8
        durationContainerView.orientation       = .horizontal
        
        durationLabel.font                      = NSFont.systemFont(ofSize: 20, weight: .bold)
        
        NSLayoutConstraint.activate([
            durationContainerView.centerXAnchor.constraint(equalTo: excerciseVideoPreview.centerXAnchor),
            durationContainerView.topAnchor.constraint(equalTo: excerciseVideoPreview.bottomAnchor, constant: 16),
            durationContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            durationContainerView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
}

#Preview(traits: .defaultLayout, body: {
    ExcerciseVideoVC()
})
