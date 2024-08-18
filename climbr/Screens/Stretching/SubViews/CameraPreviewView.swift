//
//  CameraPreviewView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 11/08/24.
//

import Cocoa
import AVFoundation

class CameraPreviewView: NSView {
    private var previewLayer: AVCaptureVideoPreviewLayer?
    
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
    
    func setupPreviewLayer(with layer: AVCaptureVideoPreviewLayer?) {
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
        // Ensure the preview layer resizes with the view
        previewLayer?.frame = self.bounds
    }
}
