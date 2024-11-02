//
//  AudioService.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import Foundation
import AVFAudio

protocol AudioService {
    func playBackgroundMusic(fileName: String)
    func playSFX(fileName: String)
    func speech(_ text: String)
    func stopSpeech(at boundary: AVSpeechBoundary)
    func muteSound()
    func unmuteSound()
    func stopBackground()
}
