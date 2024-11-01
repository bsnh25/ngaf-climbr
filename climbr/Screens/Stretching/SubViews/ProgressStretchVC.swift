//
//  ProgressStretchVC.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 31/10/24.
//

import Cocoa
import AVKit
import SnapKit


enum ProgressStretchCondition: CaseIterable {
    case toDo
    case inProgress
    case halfDone
    case done
    case skipped
    
    var statusImage: String {
        switch self {
        case .toDo: return "toDoProgress"
        case .inProgress: return "inProgress"
        case .halfDone: return "halfProgress"
        case .done: return "doneProgress"
        case .skipped: return "skipProgress"
        }
    }
}

class ProgressStretchVC: NSView {
    
    var neckStretchView: SubProgressStretchView = SubProgressStretchView()
    var armStretchView: SubProgressStretchView = SubProgressStretchView()
    var backStretchView: SubProgressStretchView = SubProgressStretchView()
    var stretchMovement : Movement?
    var statusProgress : ProgressStretchCondition = ProgressStretchCondition.toDo
    var armMovement : [Movement] = []
    var neckMovement : [Movement] = []
    var backMovement : [Movement] = []
    var isFirstLoaded: Bool = false
    
    var progressStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .vertical
        stack.spacing = 8
        return stack
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout Section
    
    private func configureUI() {
        addSubview(progressStack)
        let views = [neckStretchView, armStretchView, backStretchView]
        progressStack.setViews(views, in: .leading)
        
//        progressStack.wantsLayer = true
//        progressStack.layer?.borderColor = NSColor.red.cgColor
//        progressStack.layer?.borderWidth = 2
//        
//        neckStretchView.wantsLayer = true
//        neckStretchView.layer?.borderColor = NSColor.green.cgColor
//        neckStretchView.layer?.borderWidth = 2
//        
//        armStretchView.wantsLayer = true
//        armStretchView.layer?.borderColor = NSColor.blue.cgColor
//        armStretchView.layer?.borderWidth = 2
//        
//        backStretchView.wantsLayer = true
//        backStretchView.layer?.borderColor = NSColor.orange.cgColor
//        backStretchView.layer?.borderWidth = 2
        
        progressStack.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.snp.horizontalEdges)
            make.top.equalTo(self.snp.top)
            make.height.equalTo(self.snp.height)
        }
        
        neckStretchView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(progressStack.snp.horizontalEdges)
            make.top.equalTo(progressStack.snp.top)
        }
        
        armStretchView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(progressStack.snp.horizontalEdges)
            make.top.equalTo(neckStretchView.snp.bottom).offset(12)
        }
        
        backStretchView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(progressStack.snp.horizontalEdges)
            make.top.equalTo(armStretchView.snp.bottom).offset(12)
        }
        
    }
    
    // MARK: Update UI -> logic section
    func loadMovement(_ movements: [Movement]) {
        movements.forEach { movement in
            if movement.type == .neck {
                neckMovement.append(movement)
            } else if movement.type == .arm {
                armMovement.append(movement)
            } else if movement.type == .back {
                backMovement.append(movement)
            }
        } // done

        isFirstLoaded = true
//        self.currentMovementCheck(neckMovement.first!)
    }
    
    func updateStretch(_ movement: Movement, _ status: ProgressStretchCondition){
        neckStretchView.loadDataSubView(movement, status)
        armStretchView.loadDataSubView(movement, status)
        backStretchView.loadDataSubView(movement, status)
    }
    
    func currentMovementCheck(_ currentMovement: Movement, _ status: ProgressStretchCondition){
        
        print("current status sebelum : \(status) ==== dari movement : \(currentMovement.type)")
        guard let neckFirstMovement = neckMovement.first else { return }
        guard let armFirstMovement = armMovement.first else { return }
        guard let backFirstMovement = backMovement.first else { return }
        
        if isFirstLoaded {
            neckStretchView.loadDataSubView(neckFirstMovement, .inProgress)
            armStretchView.loadDataSubView(armFirstMovement, .toDo)
            backStretchView.loadDataSubView(backFirstMovement, .toDo)
            isFirstLoaded = false
        }
        
//        if currentMovement.id == neckFirstMovement.id {
//            neckStretchView.loadDataSubView(currentMovement, .inProgress)
//        } else if currentMovement.id == armFirstMovement.id {
//            armStretchView.loadDataSubView(currentMovement, .inProgress)
//        } else if currentMovement.id == backFirstMovement.id {
//            backStretchView.loadDataSubView(currentMovement, .inProgress)
//        }
        
        if currentMovement.type == .neck {
            switch status {
            case .toDo:
                armStretchView.hideView()
                backStretchView.hideView()
                return
            case .done:
                neckStretchView.loadDataSubView(currentMovement, status)
                armStretchView.unHideView()
                neckStretchView.hideView()
                backStretchView.hideView()
                return
            case .inProgress:
                neckStretchView.loadDataSubView(currentMovement, status)
                armStretchView.hideView()
                backStretchView.hideView()
                return
            case .halfDone:
                neckStretchView.loadDataSubView(currentMovement, status)
                armStretchView.hideView()
                backStretchView.hideView()
//                if currentMovement.name == neckMovement.last?.name {
//                    neckStretchView.hideView()
//                    armStretchView.unHideView()
//                    backStretchView.hideView()
//                } else {
//                    armStretchView.hideView()
//                    backStretchView.hideView()
//                }
                return
            case .skipped:
                neckStretchView.loadDataSubView(currentMovement, status)
                armStretchView.unHideView()
                neckStretchView.hideView()
                return
            }
        } else if currentMovement.type == .arm {
            switch status {
            case .toDo:
//                neckStretchView.hideView()
                armStretchView.hideView()
//                backStretchView.hideView()
                return
            case .done:
                armStretchView.loadDataSubView(currentMovement, status)
                armStretchView.hideView()
//                neckStretchView.hideView()
                backStretchView.unHideView()
                return
            case .inProgress:
                armStretchView.unHideView()
                armStretchView.loadDataSubView(currentMovement, status)
                neckStretchView.hideView()
                backStretchView.hideView()
                return
            case .halfDone:
                armStretchView.loadDataSubView(currentMovement, status)
                neckStretchView.hideView()
                backStretchView.hideView()
//                if currentMovement.name == armMovement.last?.name {
////                    neckStretchView.hideView()
//                    backStretchView.unHideView()
//                    armStretchView.hideView()
//                } else {
//                    neckStretchView.hideView()
//                    backStretchView.hideView()
//                }
                return
            case .skipped:
                armStretchView.loadDataSubView(currentMovement, status)
                backStretchView.unHideView()
                armStretchView.hideView()
                return
            }
        } else if currentMovement.type == .back {
            switch status {
            case .toDo:
//                neckStretchView.hideView()
                backStretchView.hideView()
//                backStretchView.hideView()
                return
            case .done:
                backStretchView.loadDataSubView(currentMovement, status)
                backStretchView.hideView()
//                neckStretchView.hideView()
                return
            case .inProgress:
                backStretchView.unHideView()
                backStretchView.loadDataSubView(currentMovement, status)
                neckStretchView.hideView()
                armStretchView.hideView()
                return
            case .halfDone:
                backStretchView.loadDataSubView(currentMovement, status)
//                neckStretchView.hideView()
//                armStretchView.hideView()
                return
            case .skipped:
                backStretchView.unHideView()
                backStretchView.loadDataSubView(currentMovement, status)
//                backStretchView.unHideView()
//                armStretchView.hideView()
                return
            }
        }
        print("current status sesudah : \(status) ==== dari movement : \(currentMovement.type)")
    }
    
}

class SubProgressStretchView: NSView {
    
    var typeStretchLabel = CLLabel(
        fontSize: 22,
        fontWeight: .bold)
    var detailMovementLabel = CLLabel(
        fontSize: 17,
        fontWeight: .regular)
    var imageProgressView : NSImageView = NSImageView()
    var videoView = VideoPreviewView()
    var playerView : AVPlayerLayer?
    var player : AVPlayer?
    let movementDivider : Divider = {
        let devider = Divider()
        devider.fillColor = .black
        return devider
    }()
    var statusImage : ProgressStretchCondition = ProgressStretchCondition.inProgress
    
    /// stack section
    var movementStackView: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .vertical
        stack.spacing = 8
        return stack
    }()
    
    var progressStackView: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .horizontal
        stack.spacing = 12
        return stack
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupSubviews()
        typeStretchLabel.setText("Arm")
        detailMovementLabel.setText("Arm Detail")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout Section

    func setupSubviews() {
        addSubview(progressStackView)
        addSubview(movementDivider)
        addSubview(videoView)
        
        imageProgressView.image = NSImage(named: "\(statusImage)")
        
        movementStacConfig()
        progressStackConfig()
        outterStackConfig()
        observeVideoPlay()
    }
    
    
    private func progressStackConfig(){
        let views = [imageProgressView, movementStackView]
        progressStackView.setViews(views, in: .leading)
        imageProgressView.imageScaling = .scaleAxesIndependently
        
//        progressStackView.wantsLayer = true
//        progressStackView.layer?.borderColor = .black
//        progressStackView.layer?.borderWidth = 2
//
//        imageProgressView.wantsLayer = true
//        imageProgressView.layer?.borderColor = NSColor.purple.cgColor
//        imageProgressView.layer?.borderWidth = 2
//        
//        movementStackView.wantsLayer = true
//        movementStackView.layer?.borderColor = NSColor.red.cgColor
//        movementStackView.layer?.borderWidth = 2
//        
        progressStackView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        imageProgressView.snp.makeConstraints { make in
            make.top.equalTo(progressStackView.snp.top)
            make.height.width.equalTo(50)
        }
        
        movementStackView.snp.makeConstraints { make in
            make.trailing.equalTo(progressStackView.snp.trailing)
            make.height.equalTo(56)
            
        }
    }
    
    private func movementStacConfig() {
        let views = [typeStretchLabel, detailMovementLabel]
        movementStackView.setViews(views, in: .leading)
        typeStretchLabel.wantsLayer = true
        detailMovementLabel.wantsLayer = true
        typeStretchLabel.alignment = .justified
        detailMovementLabel.alignment = .justified
//        
//        typeStretchLabel.layer?.borderColor = NSColor.red.cgColor
//        typeStretchLabel.layer?.borderWidth = 2
//        
//        detailMovementLabel.layer?.borderColor = NSColor.red.cgColor
//        detailMovementLabel.layer?.borderWidth = 2
        
        typeStretchLabel.snp.makeConstraints { make in
            make.top.equalTo(movementStackView.snp.top)
            make.horizontalEdges.equalTo(movementStackView.snp.horizontalEdges)
        }
        
        detailMovementLabel.snp.makeConstraints { make in
            make.top.equalTo(typeStretchLabel.snp.bottom)
            make.bottom.equalTo(movementStackView.snp.bottom)
            make.trailing.equalTo(movementStackView.snp.trailing)
        }
        
    }
    
    private func outterStackConfig() {
        
        videoView.layer?.cornerRadius = 8
        movementDivider.fillColor = .kDarkGray
        
        videoView.wantsLayer = true
        videoView.layer?.borderColor = NSColor.black.cgColor
        videoView.layer?.borderWidth = 2
//        
//        movementDivider.wantsLayer = true
//        movementDivider.layer?.borderColor = NSColor.black.cgColor
//        movementDivider.layer?.borderWidth = 2
        
        movementDivider.snp.makeConstraints { make in
            make.top.equalTo(imageProgressView.snp.bottom).offset(20)
            make.centerX.equalTo(imageProgressView.snp.centerX)
            make.height.equalTo(160)
            make.width.equalTo(1)
        }
        
        videoView.snp.makeConstraints { make in
            make.top.equalTo(detailMovementLabel.snp.bottom).offset(25)
            make.leading.equalTo(movementDivider.snp.trailing).offset(37)
            make.trailing.equalTo(self.snp.trailing).inset(20)
            make.bottom.equalTo(self.snp.bottom).inset(20)
            make.width.equalTo(249)
            make.height.equalTo(136)
        }
        
    }
    
    // MARK: Update UI -> logic section
    
    func loadDataSubView(_ movement: Movement, _ status: ProgressStretchCondition) {
        typeStretchLabel.setText("\(movement.type.exerciseString)")
        playVideo(movement.preview.rawValue)
        detailMovementLabel.setText(movement.name.rawValue)
        imageProgressView.image = NSImage(named: "\(status.statusImage)")
    }
    
    func updateData(_ data: Movement) {
        playVideo(data.preview.rawValue)
        detailMovementLabel.setText(data.name.rawValue)
    }
    
    func hideView(){
        movementDivider.removeFromSuperview()
        videoView.removeFromSuperview()
        
//        videoView.wantsLayer = true
//        videoView.layer?.borderColor = NSColor.black.cgColor
//        videoView.layer?.borderWidth = 2
//        
//        movementDivider.wantsLayer = true
//        movementDivider.layer?.borderColor = NSColor.black.cgColor
//        movementDivider.layer?.borderWidth = 2
//        
//        movementDivider.snp.makeConstraints { make in
//            make.height.equalTo(0)
//            make.width.equalTo(0)
//        }
//        
//        videoView.snp.makeConstraints { make in
//            make.width.equalTo(0)
//            make.height.equalTo(0)
//        }
    }
    
    func unHideView(){
//        movementDivider.isHidden = false
//        videoView.isHidden = false
        
        addSubview(movementDivider)
        addSubview(videoView)
        outterStackConfig()
        
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
    
    private func observeVideoPlay(){
        NotificationCenter.default.addObserver(self, selector: #selector(loopVideo), name: AVPlayerItem.didPlayToEndTimeNotification, object: player?.currentItem)
    }
    
    @objc private func loopVideo(notification: Notification) {
        if let playerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: .zero, completionHandler: nil)
        }
    }
    
}

