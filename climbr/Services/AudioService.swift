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
    func muteSound()
    func unmuteSound()
    func stopBackground()
}
