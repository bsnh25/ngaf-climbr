//
//  EndSessionAlertVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 11/08/24.
//

import Cocoa

class EndSessionAlertVC: NSViewController {
    
    let imageView   = NSImageView()
    
    let titleLabel  = CLLabel(fontSize: 13, fontWeight: .bold)
    let bodyLabel   = CLLabel(fontSize: 11, fontWeight: .regular)
    
    let stayButton  = CLTextButtonV2(
        title: "Stay",
        backgroundColor: .systemBlue,
        foregroundColorText: .white,
        fontText: .preferredFont(forTextStyle: .callout)
    )
    
    let endButton   = CLTextButtonV2(
        title: "End Session",
        backgroundColor: .systemButton,
        foregroundColorText: .black,
        fontText: .preferredFont(forTextStyle: .callout)
    )
    
    let padding: CGFloat    = 16

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureImage()
        configureLabel()
        configureButton()
    }
    
    private func configureImage() {
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = NSImage.appLogo
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
//            imageView.heightAnchor.constraint(equalToConstant: 88),
        ])
    }
    
    private func configureLabel() {
        view.addSubview(titleLabel)
        view.addSubview(bodyLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.setText("Leaving soon?")
        titleLabel.alignment = .center
        
        bodyLabel.setText("Finishing the session early will reduce the amount of reward you will receive")
//        bodyLabel.maximumNumberOfLines = 2
        bodyLabel.alignment = .center
        bodyLabel.usesSingleLineMode = false
        bodyLabel.lineBreakMode = .byWordWrapping
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            titleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bodyLabel.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    private func configureButton() {
        stayButton.translatesAutoresizingMaskIntoConstraints    = false
        endButton.translatesAutoresizingMaskIntoConstraints     = false
        
        view.addSubview(stayButton)
        view.addSubview(endButton)
        
        stayButton.layer?.cornerRadius = 8
        endButton.layer?.cornerRadius = 8
        
        stayButton.target = self
        stayButton.action = #selector(dismissAlert)
        
        endButton.target = self
        endButton.action = #selector(endSession)
        
        NSLayoutConstraint.activate([
            endButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            endButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            endButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            endButton.heightAnchor.constraint(equalToConstant: 28),
            
            stayButton.bottomAnchor.constraint(equalTo: endButton.topAnchor, constant: -10),
            stayButton.leadingAnchor.constraint(equalTo: endButton.leadingAnchor),
            stayButton.trailingAnchor.constraint(equalTo: endButton.trailingAnchor),
            stayButton.heightAnchor.constraint(equalTo: endButton.heightAnchor)
        ])
    }
    
}

extension EndSessionAlertVC {
    @objc func dismissAlert() {
        dismiss(self)
    }
    
    @objc func endSession() {
        self.push(StretchingResultVC())
//        dismissAlert()
    }
}

#Preview(traits: .defaultLayout, body: {
    EndSessionAlertVC()
})
