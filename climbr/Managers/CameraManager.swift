//
//  CameraManager.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import AVFoundation
import AppKit

class CameraManager: NSObject {
    var previewLayer: AVCaptureVideoPreviewLayer!
    var captureSession: AVCaptureSession!
    var cameraDevice: AVCaptureDevice!
    
    var videoOutput: AVCaptureVideoDataOutput
//    let captureDevice: AVCaptureDevice?
    
//    private let containerView: NSView
    
    private let cameraQueue: DispatchQueue
    
    var predictor = Predictor()
    
    override init() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        videoOutput = AVCaptureVideoDataOutput()
        cameraQueue = DispatchQueue(label: "sample buffer delegate", attributes: [])
//        captureDevice = AVCaptureDevice.default(for: .video)
        
        super.init()
        
        setupSession()
    }
    
    deinit {
        previewLayer = nil
        captureSession = nil
    }
    
    private func setupSession() {
//        guard let captureDevice = captureDevice,
//              let input = try? AVCaptureDeviceInput(device: captureDevice) else {
//            return
//        }
        
        guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .unspecified).devices.first else {
            fatalError("No front-facing camera found")
        }
        
        do {
            let cameraInput = try AVCaptureDeviceInput(device: device)
            if captureSession.canAddInput(cameraInput) {
                captureSession.addInput(cameraInput)
            }
        } catch {
            fatalError("Camera input could not be added: \(error.localizedDescription)")
        }
        
        captureSession.sessionPreset = .high
        videoOutput.alwaysDiscardsLateVideoFrames = true
        captureSession.addOutput(videoOutput)
        
        setupPreviewLayer()
        
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoDispatchQueue"))
        if captureSession.canAddOutput(videoOutput){
            captureSession.addOutput(videoOutput)
        }
    }
    
    private func setupPreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = .resizeAspectFill
//        previewLayer?.contentsGravity = .resizeAspectFill
//        previewLayer.frame = containerView.bounds
//        containerView.layer = previewLayer
//        containerView.wantsLayer = true
        
        
    }
    
    func startSession() {
//        guard !captureSession.isRunning else { return }
        
        if let captureSession = captureSession {
            if !captureSession.isRunning{
                cameraQueue.async {
                    captureSession.startRunning()
                }
            }
        }
//        captureSession.startRunning()
//        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoDispatchQueue"))
    }
    
    func stopSession() {
//        guard captureSession.isRunning else { return }
        
        if let captureSession = captureSession {
            if captureSession.isRunning{
                cameraQueue.async {
                    captureSession.stopRunning()
                }
            }
        }
        
//        captureSession.stopRunning()
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

