//
//  CameraPreview.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 11/08/24.
//

import Cocoa
import AVFoundation

//class CameraPreviewView: NSView {
//    
//    private var previewLayer: AVCaptureVideoPreviewLayer?
//    
//    override init(frame frameRect: NSRect) {
//        super.init(frame: frameRect)
//        setupLayer()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupLayer()
//    }
//    
//    // Method to configure the preview layer with a capture session
//    func setupPreviewLayer(with session: AVCaptureSession) {
//        previewLayer = AVCaptureVideoPreviewLayer(session: session)
//        previewLayer?.videoGravity = .resizeAspectFill
//        previewLayer?.frame = self.bounds
//        if let previewLayer = previewLayer {
//            self.layer?.addSublayer(previewLayer)
//        }
//    }
//    
//    // Method to set up the view's layer
//    private func setupLayer() {
//        self.wantsLayer = true
//    }
//    
//    override func layout() {
//        super.layout()
//        // Ensure the preview layer resizes with the view
//        previewLayer?.frame = self.bounds
//    }
//}
//
//class CustomVideoView: NSView {
//    
//    private var previewLayer: AVCaptureVideoPreviewLayer?
//    
//    override init(frame frameRect: NSRect) {
//        super.init(frame: frameRect)
//        self.wantsLayer = true
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        self.wantsLayer = true
//    }
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.wantsLayer = true
//    }
//    
//    func setupPreviewLayer(with session: AVCaptureSession) {
//        previewLayer = AVCaptureVideoPreviewLayer(session: session)
//        previewLayer?.videoGravity = .resizeAspectFill
//        
//        if let previewLayer = previewLayer {
//            previewLayer.frame = self.bounds
//            self.layer?.addSublayer(previewLayer)
//        }
//    }
//    
//    override func layout() {
//        super.layout()
//        // Ensure the preview layer resizes with the view
//        previewLayer?.frame = self.bounds
//    }
//}

