//
//  PredictorService.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 18/08/24.
//

import Foundation
import AVFoundation
import Vision

protocol PredictorService {
    var delegate: PredictorDelegate? { get set }
    func estimation(sampleBuffer: CMSampleBuffer)
}
