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
    let videoView = VideoPreviewView()
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
    var playerView : AVPlayerLayer?
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(loopVideo), name: AVPlayerItem.didPlayToEndTimeNotification, object: player?.currentItem)
    }
    
    @objc private func loopVideo(notification: Notification) {
        print("URL: end video ")
        if let playerItem = notification.object as? AVPlayerItem {
            print("URL: player item ")
            playerItem.seek(to: .zero, completionHandler: nil)
        }
    }
    
    func updateData(_ data: Movement) {
        playVideo(data.preview.rawValue)
        movementLabel.setText(data.name.rawValue)
    }
    
    func playVideo(_ url: String) {
        guard let url = Bundle.main.url(forResource: url, withExtension: "mp4") else { return }
        print("url: ", url)
        player = AVPlayer(url: url)
        
        playerView = AVPlayerLayer(player: player)
        playerView?.frame = videoView.bounds
        playerView?.videoGravity = .resizeAspectFill
        videoView.setupPreviewLayer(with: playerView)
        
        player?.play()
        player?.volume = 0
        player?.actionAtItemEnd = .none
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
        videoView.layer?.backgroundColor = NSColor.darkGray.cgColor
        videoView.clipsToBounds = true
        videoView.layer?.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            videoView.trailingAnchor.constraint(equalTo: movementLabel.trailingAnchor),
            videoView.leadingAnchor.constraint(equalTo: movementLabel.leadingAnchor),
            videoView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    func getIndexMovement(current: Int, maxIndex: Int){
        let showIndex = current + 1
        stretchLabel.setText("\(showIndex) / \(maxIndex)")
    }
    
}

class VideoPreviewView: NSView {
    private var previewLayer: AVPlayerLayer?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.wantsLayer = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.wantsLayer = true
    }
    
    func setupPreviewLayer(with layer: AVPlayerLayer?) {
        previewLayer = layer
        
        if let previewLayer = previewLayer {
            previewLayer.frame = self.bounds
            self.layer?.addSublayer(previewLayer)
        }
    }
    
    func addOtherSubLayer(layer: CAShapeLayer){
        self.layer?.addSublayer(layer)
        layer.frame = self.frame
        layer.strokeColor = NSColor.red.cgColor
    }
    
    override func layout() {
        super.layout()
        previewLayer?.frame = self.bounds
    }
}
