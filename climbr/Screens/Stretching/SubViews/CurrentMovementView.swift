//
//  CurrentMovementView.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 09/08/24.
//

import AppKit
import AVFoundation
import Combine

class CurrentMovementView: NSStackView {
    
    let stretchLabel = CLLabel(
        fontSize: 36,
        fontWeight: .bold
    )
    let movementLabel = CLLabel(
        fontSize: 20,
        fontWeight: .bold
    )
    let videoView = NSView()
    let durationContainerView = NSStackView()
    let durationImageView = CLSFSymbol(
        symbolName: "timer",
        description: "Duration"
    )
    let durationLabel = CLLabel(
        fontSize: 20,
        fontWeight: .bold
    )
    
    var currentIndex: Int?
    var maxIndex: Int?
    var playerLayer : AVPlayerLayer!
    var player : AVPlayer?
    
    
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
        
        let views = [stretchLabel, movementLabel, videoView]
        setViews(views, in: .center)
        
        for item in views {
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        configureMovementLabel()
        configureMovementPreview()
    }
    
    func updateData(_ data: Movement) {
        
        if playerLayer == nil {
            setupVideo(for: data)
            videoView.layer?.addSublayer(playerLayer)
            print("success setup video")
        }
        
        guard let playerLayer = playerLayer else {
            print("playerLayer is still nil after attempting setup")
            return
        }
        
//        if videoView.layer?.sublayers?.contains(playerLayer) == false {
//            videoView.layer?.addSublayer(playerLayer)
//            print("video view : \(String(describing: videoView.layer?.sublayers?.contains(playerLayer)))")
//        }
        playerLayer.frame = videoView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.player?.play()
        
        movementLabel.setText(data.name.rawValue)
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
        videoView.wantsLayer = true
        videoView.layer?.cornerRadius = 10
        videoView.layer?.borderWidth = 2
        videoView.layer?.borderColor = .black
//        videoView.layer?.backgroundColor = .black
        
        NSLayoutConstraint.activate([
            videoView.trailingAnchor.constraint(equalTo: movementLabel.trailingAnchor),
            videoView.leadingAnchor.constraint(equalTo: movementLabel.leadingAnchor),
            videoView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
//    private func configureDurationLabel() {
//        durationContainerView.setViews([durationImageView, durationLabel], in: .center)
//        durationContainerView.spacing           = 8
//        durationContainerView.orientation       = .horizontal
//        
//        durationLabel.setText("15 seconds")
//        durationImageView.setConfiguration(size: 20, weight: .bold)
//        
//        NSLayoutConstraint.activate([
//            durationContainerView.centerXAnchor.constraint(equalTo: videoView.centerXAnchor),
//            durationContainerView.heightAnchor.constraint(equalToConstant: 32)
//        ])
//    }
    
    func getIndexMovement(current: Int, maxIndex: Int){
        let showIndex = current + 1
        stretchLabel.setText("\(showIndex) / \(maxIndex)")
    }

    func setupVideo(for data: Movement) {
        guard let filePath = Bundle.main.path(forResource: data.preview.rawValue, ofType: "mp4") else {
            print("File path not found for sample.mp4")
            return
        }
        
        let fileURL = URL(fileURLWithPath: filePath)
        player = AVPlayer(url: fileURL)
        
        if let player = player {
            print("AVPlayer initialized successfully.")
            playerLayer = AVPlayerLayer(player: player)
        } else {
            print("Failed to initialize AVPlayer.")
        }
        
        if playerLayer == nil {
            print("AVPlayerLayer initialization failed.")
        } else {
            print("AVPlayerLayer initialized successfully.")
        }
    }
    
}
