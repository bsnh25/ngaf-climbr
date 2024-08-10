//
//  NextExcerciseVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 10/08/24.
//

import AppKit

class NextExcerciseVC: NSViewController {

    let imageView           = NSImageView()
    let nextLabel           = NSTextField(labelWithString: "Next")
    let excerciseLabel      = NSTextField(labelWithString: "Neck Deep Right")
    let durationIcon        = NSImageView()
    let durationLabel       = NSTextField(labelWithString: "15 seconds")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureImage()
        configureLabel()
    }
    
    private func configureUI() {
        let views = [imageView, nextLabel, excerciseLabel, durationIcon, durationLabel]
        
        for item in views {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureImage() {
        imageView.wantsLayer                = true
        imageView.layer?.backgroundColor    = NSColor.systemBlue.cgColor
        imageView.layer?.cornerRadius       = 10
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func configureLabel() {
        
        nextLabel.font                      = NSFont.systemFont(ofSize: 12, weight: .bold)
        nextLabel.textColor                 = .gray
        
        excerciseLabel.font                 = NSFont.systemFont(ofSize: 16, weight: .bold)
        
        let iconConfig                      = NSImage.SymbolConfiguration(pointSize: 16, weight: .bold)
        durationIcon.image                  = NSImage(systemSymbolName: "timer", accessibilityDescription: "Duration")
        durationIcon.symbolConfiguration    = iconConfig
        
        durationLabel.font                  = NSFont.systemFont(ofSize: 16, weight: .bold)
        
        NSLayoutConstraint.activate([
            nextLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 16),
            nextLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            
            excerciseLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            excerciseLabel.leadingAnchor.constraint(equalTo: nextLabel.leadingAnchor),
            
            durationIcon.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -16),
            durationIcon.leadingAnchor.constraint(equalTo: nextLabel.leadingAnchor),
            
            durationLabel.centerYAnchor.constraint(equalTo: durationIcon.centerYAnchor),
            durationLabel.leadingAnchor.constraint(equalTo: durationIcon.trailingAnchor, constant: 8),

        ])
    }
    
}
