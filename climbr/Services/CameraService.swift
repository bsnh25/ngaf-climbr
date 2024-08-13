//
//  CameraService.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 13/08/24.
//

import Foundation

protocol CameraService {
    func startSession()
    func stopSession()
    func setupPreviewLayer()
}
