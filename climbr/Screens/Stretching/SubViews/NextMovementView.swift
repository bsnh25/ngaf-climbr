//
//  NextMovementView.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 10/08/24.
//

import AppKit

class NextMovementView: NSStackView {
    
    let labelContainer      = NSStackView()
    
    let imageView           = NSImageView()
    let nextLabel           = CLLabel(text: "Up Next", foregroundColor: .gray)
    let movementLabel       = CLLabel(text: "Neck Deep Right", foregroundColor: .black)
    
    let durationContainerView   = NSStackView()
    let durationIcon            = CLSFSymbol(symbolName: "timer", description: "Duration")
    let durationLabel           = CLLabel(text: "15 seconds", foregroundColor: .black)
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let views = [imageView, labelContainer]
        
        setViews(views, in: .center)
        orientation     = .horizontal
        spacing         = 12
        
        disableTAMIC()
        configureImage()
        configureLabel()
        
        heightAnchor.constraint(equalToConstant: 88).isActive = true
    }
    
    func updateData(_ data: Movement) {
        movementLabel.setText(data.name.rawValue)
        durationLabel.setText("\(String(format: "%.f", data.duration)) seconds")
        imageView.image = data.thumbnail
        imageView.frame = NSRect(x: 0, y: 0, width: 88, height: 88)
    }
    
    private func disableTAMIC() {
        let views = [labelContainer, imageView, nextLabel, movementLabel, durationContainerView]
        
        for item in views {
            item.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureImage() {
        imageView.wantsLayer                = true
        imageView.layer?.backgroundColor    = NSColor.systemBlue.cgColor
        imageView.layer?.cornerRadius       = 10
        
        
        imageView.image?.size               = NSSize(width: 88, height: 88)
        imageView.imageScaling              = .scaleAxesIndependently
        imageView.imageAlignment            = .alignCenter
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.widthAnchor.constraint(equalTo: heightAnchor),
        ])
    }
    
    private func configureLabel() {
        /// Configure the label container
        let views = [nextLabel, movementLabel, durationContainerView]
        labelContainer.setViews(views, in: .center)
        labelContainer.orientation          = .vertical
        labelContainer.alignment            = .leading
        labelContainer.spacing              = 10
        
        /// Next label
        nextLabel.setFont(ofSize: 12, weight: .bold)
        
        /// Movement label
        movementLabel.setFont(ofSize: 16, weight: .bold)
        
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
            labelContainer.topAnchor.constraint(equalTo: topAnchor),
            labelContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            labelContainer.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
