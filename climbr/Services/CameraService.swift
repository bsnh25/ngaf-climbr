//
//  CameraService.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 13/08/24.
//

import Foundation
import AVFoundation

protocol CameraService {
    var previewLayer: AVCaptureVideoPreviewLayer! { get }
    
    func startSession()
    func stopSession()
    func setSampleBufferDelegate(delegate: AVCaptureVideoDataOutputSampleBufferDelegate)
}
