//
//  CameraManager.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import AVFoundation
import AppKit

class CameraManager: NSObject {
    let captureSession: AVCaptureSession
    let videoOutput: AVCaptureVideoDataOutput
    let captureDevice: AVCaptureDevice?
    
    var predictor = Predictor()
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override init() {
        captureSession = AVCaptureSession()
        videoOutput = AVCaptureVideoDataOutput()
        captureDevice = AVCaptureDevice.default(for: .video)
        
        super.init()
        
        setupSession()
    }
    
    private func setupSession() {
        guard let captureDevice = captureDevice,
              let input = try? AVCaptureDeviceInput(device: captureDevice) else {
            return
        }
        
        captureSession.sessionPreset = .high
        captureSession.addInput(input)
        
        videoOutput.alwaysDiscardsLateVideoFrames = true
        captureSession.addOutput(videoOutput)
        
        setupPreviewLayer()
    }
    
    private func setupPreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = .resizeAspectFill
    }
    
    func startSession() {
        guard !captureSession.isRunning else { return }
        
        captureSession.startRunning()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoDispatchQueue"))
    }
    
    func stopSession() {
        guard captureSession.isRunning else { return }
        
        captureSession.stopRunning()
    }
    
    func attachPreview(to view: NSView) {
        guard let previewLayer = previewLayer else { return }
        
        previewLayer.frame = view.bounds
        view.wantsLayer = true
        view.layer?.addSublayer(previewLayer)
    }
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        predictor.estimation(sampleBuffer: sampleBuffer)
    }
}

