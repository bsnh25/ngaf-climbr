//
//  CurrentMovementView.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 09/08/24.
//

import AppKit

class CurrentMovementView: NSStackView {
    
    let stretchLabel            = CLLabel(fontSize: 36, fontWeight: .bold)
    let movementLabel           = CLLabel(fontSize: 20, fontWeight: .bold)
    let movementPreview         = NSView()
    let imageView               = NSImageView()
    let durationContainerView   = NSStackView()
    let durationImageView       = CLSFSymbol(symbolName: "timer", description: "Duration")
    let durationLabel           = CLLabel(fontSize: 20, fontWeight: .bold)
    
    var currentIndex: Int?
    var maxIndex: Int?
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
        clipsToBounds = true
        
        let views = [stretchLabel, movementLabel, movementPreview, durationContainerView]
        setViews(views, in: .center)
        
        for item in views {
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        configureMovementLabel()
        configureMovementPreview()
//        configureDurationLabel()
    }
    
    func updateData(_ data: Movement) {
        movementLabel.setText(data.name.rawValue)
        durationLabel.setText("\(String(format: "%.f", data.duration)) seconds")
        imageView.image   = data.thumbnail
        imageView.image?.size           = NSSize(width: 328, height: 200)
    }
    
    func setDuration(_ time: Double) {
        let durationAttributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 20, weight: .bold)
        ]
        
        let leftAttributes = [
            .font: NSFont.systemFont(ofSize: 16, weight: .bold),
            NSAttributedString.Key.foregroundColor: NSColor.systemGray
        ]
        
        let duration    = NSMutableAttributedString(string: "\(String(format: "%.f", time)) ", attributes: durationAttributes)
        let leftString  = NSAttributedString(string: "seconds left", attributes: leftAttributes)
        
        duration.append(leftString)
        
        durationLabel.attributedStringValue = duration
    }
    
    private func configureMovementLabel() {
        
        movementLabel.setText("Movement Title")
        
        NSLayoutConstraint.activate([
            stretchLabel.topAnchor.constraint(equalTo: topAnchor),
            stretchLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            stretchLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            stretchLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            movementLabel.topAnchor.constraint(equalTo: stretchLabel.bottomAnchor),
            movementLabel.leadingAnchor.constraint(equalTo: stretchLabel.leadingAnchor),
            movementLabel.trailingAnchor.constraint(equalTo: stretchLabel.trailingAnchor),
            movementLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func configureMovementPreview() {
        movementPreview.translatesAutoresizingMaskIntoConstraints = false
        movementPreview.wantsLayer                = true
        movementPreview.layer?.backgroundColor    = NSColor.systemGray.cgColor.copy(alpha: 0.5)
        movementPreview.layer?.cornerRadius       = 10
        movementPreview.clipsToBounds             = true
        
        imageView.imageAlignment        = .alignCenter
        imageView.imageScaling          = .scaleProportionallyUpOrDown
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        movementPreview.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            movementPreview.trailingAnchor.constraint(equalTo: movementLabel.trailingAnchor),
            movementPreview.leadingAnchor.constraint(equalTo: movementLabel.leadingAnchor),
            movementPreview.widthAnchor.constraint(equalTo: movementPreview.widthAnchor),
            movementPreview.heightAnchor.constraint(equalToConstant: 200),
            
            imageView.leadingAnchor.constraint(equalTo: movementLabel.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: movementLabel.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: movementPreview.heightAnchor),
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
    
    func getIndexMovement(current: Int, maxIndex: Int){
        let showIndex = current + 1
        stretchLabel.setText("\(showIndex) / \(maxIndex)")
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
