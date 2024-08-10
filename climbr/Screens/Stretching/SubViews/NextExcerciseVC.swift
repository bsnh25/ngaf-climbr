//
//  NextExcerciseVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 10/08/24.
//

import AppKit

class NextExcerciseVC: NSViewController {

    let labelContainer      = NSStackView()
    
    let imageView           = NSImageView()
    let nextLabel           = CLLabel(text: "Up Next", foregroundColor: .gray)
    let excerciseLabel      = CLLabel(text: "Neck Deep Right", foregroundColor: .black)
    
    let durationContainerView   = NSStackView()
    let durationIcon            = CLSFSymbol(symbolName: "timer", description: "Duration")
    let durationLabel           = CLLabel(text: "15 seconds", foregroundColor: .black)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureImage()
        configureLabel()
    }
    
    private func configureUI() {
        view.addSubview(imageView)
        view.addSubview(labelContainer)
        
        let views = [labelContainer, imageView, nextLabel, excerciseLabel, durationContainerView]
        
        for item in views {
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
            imageView.widthAnchor.constraint(equalToConstant: 88),
            imageView.heightAnchor.constraint(equalToConstant: 88),
        ])
    }
    
    private func configureLabel() {
        /// Configure the label container
        let views = [nextLabel, excerciseLabel, durationContainerView]
        labelContainer.setViews(views, in: .center)
        labelContainer.orientation          = .vertical
        labelContainer.alignment            = .leading
        labelContainer.spacing              = 10
        
        /// Next label
        nextLabel.setFont(ofSize: 12, weight: .bold)
        
        /// Excercise label
        excerciseLabel.setFont(ofSize: 16, weight: .bold)
        
        /// Configure the duration label
        durationContainerView.setViews([durationIcon, durationLabel], in: .center)
        durationContainerView.orientation   = .horizontal
        durationContainerView.spacing       = 8
        durationContainerView.distribution  = .fill
        
        /// Duration label
        durationIcon.setConfiguration(size: 16, weight: .bold)
        durationLabel.setFont(ofSize: 16, weight: .bold)
        
        /// Configure the constraint
        NSLayoutConstraint.activate([
            labelContainer.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            labelContainer.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            labelContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}
