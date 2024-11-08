//
//  CameraManager.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import AVFoundation
import AppKit

class CameraManager: NSObject, CameraService {
    var previewLayer: AVCaptureVideoPreviewLayer!
    var bufferSize: CGSize = .zero
    var captureSession: AVCaptureSession!
    var cameraDevice: AVCaptureDevice!
    var videoOutput: AVCaptureVideoDataOutput
    private let cameraQueue: DispatchQueue
    
//    var predictor = Predictor()
    
    override init() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        videoOutput = AVCaptureVideoDataOutput()
        cameraQueue = DispatchQueue(label: "sample buffer delegate", attributes: [])
        
        super.init()
        setupSession()
    }
    
    func setSampleBufferDelegate(delegate: AVCaptureVideoDataOutputSampleBufferDelegate) {
        print("DELEGATE - AVCaptureVideoDataOutputSampleBufferDelegate")
        videoOutput.setSampleBufferDelegate(delegate, queue: DispatchQueue(label: "videoDispatchQueue"))
    }
    
    private func setupSession() {
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
        
//        captureSession.sessionPreset = .high
        videoOutput.alwaysDiscardsLateVideoFrames = true
        
        
        if captureSession.canAddOutput(videoOutput){
            captureSession.addOutput(videoOutput)
        }
        
        do {
            try device.lockForConfiguration()
            let dimensions = CMVideoFormatDescriptionGetDimensions(device.activeFormat.formatDescription)
            
            bufferSize.width = CGFloat(dimensions.width)
            bufferSize.height = CGFloat(dimensions.height)
        } catch {
            print("Error camera: ", error.localizedDescription)
        }

        setupPreviewLayer()
    }
    
    func setupPreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = .resizeAspectFill

        if let connection = previewLayer.connection, connection.isVideoMirroringSupported {
            connection.automaticallyAdjustsVideoMirroring = false
            connection.isVideoMirrored = !connection.isVideoMirrored
        }
        
    }
    
    func startSession() {
        print("start session")
        if let captureSession = captureSession {
            if !captureSession.isRunning{
                cameraQueue.async {
                    captureSession.startRunning()
                }
            }
        }
    }
    
    func stopSession() {
        print("stop session")
        if let captureSession = captureSession {
            if captureSession.isRunning{
                cameraQueue.async {
                    captureSession.stopRunning()
                }
            }
        }
    }
}


//videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoDispatchQueue"))
//extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
//    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        if connection.isVideoMirroringSupported && !connection.isVideoMirrored {
//            connection.isVideoMirrored = true
//        }
//        predictor.estimation(sampleBuffer: sampleBuffer)
//    }
//}



