//
//  AudioService.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import Foundation

protocol AudioService {
    func playBackgroundMusic(fileName: String)
    func playSFX(fileName: String)
    func speech(_ text: String)
    func stopSpeech()
    func muteSound()
    func unmuteSound()
    func stopBackground()
}
