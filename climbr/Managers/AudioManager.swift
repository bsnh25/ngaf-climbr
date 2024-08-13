//
//  AudioManager.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import Foundation
import CoreAudio
import AVFoundation

private let kBackgroundVolume = "kBackgroundVolume"
private let kSFXVolume = "kSFXVolume"

class AudioManager: AudioService {
    
    static let shared = AudioManager()
    private var backgroundPlayer: AVAudioPlayer?
    private var effectPlayer: AVAudioPlayer?
    private var deviceVolume: Float?
    
    private init(){
        deviceVolume = getVolumeDevice()
        if UserDefaults.standard.object(forKey: kBackgroundVolume) == nil {
            UserDefaults.standard.set(1, forKey: kBackgroundVolume) // Default volume 100%
        }
        if UserDefaults.standard.object(forKey: kSFXVolume) == nil {
            UserDefaults.standard.set(1, forKey: kSFXVolume) // Default volume 100%
        }
    }
    
    var backgroundMusicVolume: Float {
        get {
            guard let bgVolume = getVolumeDevice() else { return 0 }
            return bgVolume
        }
        set {
            backgroundPlayer?.volume = newValue
            UserDefaults.standard.set(newValue, forKey: kBackgroundVolume)
            print("Background volume set to \(newValue)")
        }
    }
    
    var sfxVolume: Float {
        get {
            guard let bgVolume = getVolumeDevice() else { return 0 }
            return (bgVolume + 1)/2
        }
        set {
            effectPlayer?.volume = newValue
            UserDefaults.standard.set(newValue, forKey: kSFXVolume)
            print("SFX volume set to \(newValue)")
        }
    }

    ///This function not running if user using earphone
    private func getVolumeDevice() -> Float? {
        var volume: Float = 0.0
        var defaultOutputDeviceID = AudioObjectID(0)
        var size = UInt32(MemoryLayout<AudioObjectID>.size)

        // Get the default output device ID
        var address = AudioObjectPropertyAddress(
            mSelector: kAudioHardwarePropertyDefaultOutputDevice,
            mScope: kAudioObjectPropertyScopeGlobal,
            mElement: kAudioObjectPropertyElementMain
        )

        let status = AudioObjectGetPropertyData(AudioObjectID(kAudioObjectSystemObject), &address, 0, nil, &size, &defaultOutputDeviceID)
        guard status == noErr else {
            print("Failed to get default output device ID with OSStatus: \(status)")
            return nil
        }

        // Get the volume from the default output device
        var volumeAddress = AudioObjectPropertyAddress(
            mSelector: kAudioDevicePropertyVolumeScalar,
            mScope: kAudioDevicePropertyScopeOutput,
            mElement: kAudioObjectPropertyElementMain
        )

        size = UInt32(MemoryLayout<Float>.size)
        let volumeStatus = AudioObjectGetPropertyData(defaultOutputDeviceID, &volumeAddress, 0, nil, &size, &volume)
        guard volumeStatus == noErr else {
            print("Failed to get volume with OSStatus: \(volumeStatus)")
            return nil
        }
        print("volume init : \(volume)")
        return volume
    }
    
    func muteSound(){
        backgroundPlayer?.volume = 0
        effectPlayer?.volume = 0
    }
    
    func unmuteSound(){
        backgroundMusicVolume = self.backgroundMusicVolume
        sfxVolume = self.sfxVolume
    }
    
    func stopBackground() {
        backgroundPlayer?.stop()
    }
    
    func playBackgroundMusic(fileName: String) {
        guard let path = Bundle.main.url(forResource: fileName, withExtension: "mp3") else { return }
        
        do {
            backgroundPlayer = try AVAudioPlayer(contentsOf: path)
            backgroundPlayer?.numberOfLoops = -1 // Loop indefinitely
            backgroundPlayer?.volume = backgroundMusicVolume
            backgroundPlayer?.play()
            print("Background music started")
        } catch {
            print("Error playing background sound: \(error.localizedDescription)")
        }
    }
    
    func playSFX(fileName: String) {
        guard let path = Bundle.main.url(forResource: fileName, withExtension: nil) else { return }
        
        do {
            effectPlayer = try AVAudioPlayer(contentsOf: path)
            effectPlayer?.volume = sfxVolume
            effectPlayer?.play()
            print("Effect sound played")
        } catch {
            print("Error playing effect sound: \(error.localizedDescription)")
        }
    }
}
