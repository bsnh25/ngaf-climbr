//
//  CameraTesting.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 11/08/24.
//

import Cocoa
import AVFoundation

class CameraTesting: NSViewController, AVCapturePhotoCaptureDelegate {
    
    var imageView: NSImageView!
    var button: NSButton!
    var cameraView: NSView!
    
    var captureSession: AVCaptureSession!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var stillImageOutput: AVCapturePhotoOutput!
    var captureDevice: AVCaptureDevice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraView = NSView()
        cameraView.wantsLayer = true
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cameraView)
        
        imageView = NSImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        
        button = NSButton(title: "Capture Photo", target: self, action: #selector(capturePhoto(_:)))
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)

        cameraView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        cameraView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cameraView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        cameraView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        imageView.topAnchor.constraint(equalTo: cameraView.bottomAnchor, constant: 20).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        
        setupCamera()
    }
    
    @objc func capturePhoto(_ sender: NSButton) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                let settings = AVCapturePhotoSettings()
                self.stillImageOutput.capturePhoto(with: settings, delegate: self)
            } else {
                debugPrint("Camera cannot be accessed")
            }
        }
    }

    func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back)
        if discoverySession.devices.count > 0 {
            captureDevice = discoverySession.devices.first
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            captureSession.addInput(input)
            
            stillImageOutput = AVCapturePhotoOutput()
            captureSession.addOutput(stillImageOutput)
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer.videoGravity = .resizeAspectFill
            videoPreviewLayer.frame = cameraView.bounds
            cameraView.layer?.addSublayer(videoPreviewLayer)
            
            captureSession.startRunning()
        } catch {
            debugPrint("Error setting up camera: \(error)")
        }
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            if let image = NSImage(data: imageData) {
                imageView.image = image
                captureSession.stopRunning()
            }
        }
    }

    
}
