//
//  CurrentMovementView.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 09/08/24.
//

import AppKit

class CurrentMovementView: NSStackView {
    
    let movementLabel           = CLLabel(fontSize: 20, fontWeight: .bold)
    let movementPreview         = NSView()
    let durationContainerView   = NSStackView()
    let durationImageView       = CLSFSymbol(symbolName: "timer", description: "Duration")
    let durationLabel           = CLLabel(fontSize: 20, fontWeight: .bold)
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        orientation       = .vertical
        spacing           = 16
        alignment         = .leading
        
        let views = [movementLabel, movementPreview, durationContainerView]
        setViews(views, in: .center)
        
        for item in views {
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        configureMovementLabel()
        configureMovementPreview()
        configureDurationLabel()
    }
    
    func updateData(_ data: Movement) {
        movementLabel.setText(data.title)
    }
    
    private func configureMovementLabel() {
        movementLabel.setText("Movement Title")
        
        NSLayoutConstraint.activate([
            movementLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            movementLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            movementLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func configureMovementPreview() {
        movementPreview.translatesAutoresizingMaskIntoConstraints = false
        movementPreview.wantsLayer                = true
        movementPreview.layer?.backgroundColor    = NSColor.systemGray.cgColor.copy(alpha: 0.5)
        movementPreview.layer?.cornerRadius       = 10
        
        NSLayoutConstraint.activate([
            movementPreview.trailingAnchor.constraint(equalTo: movementLabel.trailingAnchor),
            movementPreview.leadingAnchor.constraint(equalTo: movementLabel.leadingAnchor),
            movementPreview.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureDurationLabel() {
        durationContainerView.setViews([durationImageView, durationLabel], in: .center)
        durationContainerView.spacing           = 8
        durationContainerView.orientation       = .horizontal
        
        durationLabel.setText("15 seconds")
        durationImageView.setConfiguration(size: 20, weight: .bold)
        
        NSLayoutConstraint.activate([
            durationContainerView.centerXAnchor.constraint(equalTo: movementPreview.centerXAnchor),
            durationContainerView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}

//class ExcerciseVideoVC: NSViewController {
//    let currentExcerciseLabel   = CLLabel(fontSize: 20, fontWeight: .bold)
//    let excerciseVideoPreview   = NSView()
//    let durationContainerView   = NSStackView()
//    let durationImageView       = CLSFSymbol(symbolName: "timer", description: "Duration")
//    let durationLabel           = CLLabel(fontSize: 20, fontWeight: .bold)
//    
//    var movement: Movement! {
//        didSet {
//            currentExcerciseLabel.setText(movement.title)
//        }
//    }
//    
//    init(movement: Movement) {
//        super.init(nibName: nil, bundle: nil)
//        self.movement = movement
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        configureUI()
//        configureCurrentExcerciseLabel()
//        configureExcerciseVideoPreview()
//        configureDurationLabel()
//    }
//    
//    func updateData(_ data: Movement) {
//        movement = data
//        currentExcerciseLabel.setText(data.title)
//    }
//    
//    private func configureUI() {
//        let views = [currentExcerciseLabel, excerciseVideoPreview, durationContainerView]
//        
//        for itemView in views {
//            view.addSubview(itemView)
//            itemView.translatesAutoresizingMaskIntoConstraints = false
//        }
//    }
//    
//    private func configureCurrentExcerciseLabel() {
//        currentExcerciseLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        currentExcerciseLabel.setText(movement.title)
//        
//        NSLayoutConstraint.activate([
//            currentExcerciseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            currentExcerciseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            currentExcerciseLabel.topAnchor.constraint(equalTo: view.topAnchor),
//            currentExcerciseLabel.heightAnchor.constraint(equalToConstant: 32)
//        ])
//    }
//    
//    private func configureExcerciseVideoPreview() {
//        excerciseVideoPreview.translatesAutoresizingMaskIntoConstraints = false
//        excerciseVideoPreview.wantsLayer                = true
//        excerciseVideoPreview.layer?.backgroundColor    = NSColor.systemGray.cgColor.copy(alpha: 0.5)
//        excerciseVideoPreview.layer?.cornerRadius       = 10
//        
//        NSLayoutConstraint.activate([
//            excerciseVideoPreview.topAnchor.constraint(equalTo: currentExcerciseLabel.bottomAnchor, constant: 16),
//            excerciseVideoPreview.trailingAnchor.constraint(equalTo: currentExcerciseLabel.trailingAnchor),
//            excerciseVideoPreview.leadingAnchor.constraint(equalTo: currentExcerciseLabel.leadingAnchor),
//            excerciseVideoPreview.heightAnchor.constraint(equalToConstant: 200)
//        ])
//    }
//    
//    private func configureDurationLabel() {
//        
//        durationContainerView.setViews([durationImageView, durationLabel], in: .center)
//        durationContainerView.spacing           = 8
//        durationContainerView.orientation       = .horizontal
//        
//        durationLabel.setText("\(movement.duration) seconds")
//        durationImageView.setConfiguration(size: 20, weight: .bold)
//        
//        NSLayoutConstraint.activate([
//            durationContainerView.centerXAnchor.constraint(equalTo: excerciseVideoPreview.centerXAnchor),
//            durationContainerView.topAnchor.constraint(equalTo: excerciseVideoPreview.bottomAnchor, constant: 16),
//            durationContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            durationContainerView.heightAnchor.constraint(equalToConstant: 32)
//        ])
//    }
//    
//}
