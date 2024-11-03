//
//  NotificationManager.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import Foundation

class NotificationManager: NotificationService {
    
    static let shared = NotificationManager()
    var overlayWindow: OverlayWindow?
    var checkTimer: DispatchSourceTimer?
    var overlayTimer: DispatchSourceTimer?
    
    func startOverlayScheduler(userPreference: UserPreferenceModel) {
        stopOverlayScheduler()
        
        checkTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global(qos: .background))
        checkTimer?.schedule(deadline: .now(), repeating: .seconds(60))
        checkTimer?.setEventHandler { [weak self] in
            self?.checkWorkingHoursAndStartOverlay(userPreference: userPreference)
        }
        checkTimer?.resume()
    }
    
    func stopOverlayScheduler() {
        checkTimer?.cancel()
        overlayTimer?.cancel()
        checkTimer = nil
        overlayTimer = nil
    }
    
    private func checkWorkingHoursAndStartOverlay(userPreference: UserPreferenceModel) {
        let calendar = Calendar.current
        let now = Date()
        
        // Mendapatkan komponen hari dan waktu saat ini
        let currentDay = calendar.component(.weekday, from: now)
        let currentHour = calendar.component(.hour, from: now)
        let currentMinute = calendar.component(.minute, from: now)
        
        
        if userPreference.isFlexibleWorkHour {
            
            for workingHour in userPreference.workingHours {
                // Periksa apakah jadwal aktif dan hari sesuai
                guard workingHour.isEnabled && workingHour.day == currentDay else {
                    continue // Lewati jika hari tidak cocok atau tidak aktif
                }
                
                // Dapatkan komponen jam dan menit dari `startHour` dan `endHour`
                let startComponents = calendar.dateComponents([.hour, .minute], from: workingHour.startHour)
                let endComponents = calendar.dateComponents([.hour, .minute], from: workingHour.endHour)
                
                guard let startHour = startComponents.hour, let startMinute = startComponents.minute,
                      let endHour = endComponents.hour, let endMinute = endComponents.minute else {
                    continue
                }
                
                // Periksa apakah waktu saat ini berada dalam rentang jam kerja
                if (currentHour > startHour || (currentHour == startHour && currentMinute >= startMinute)) &&
                    (currentHour < endHour || (currentHour == endHour && currentMinute <= endMinute)) {
                    
                    // Waktu sesuai, mulai `overlayTimer` jika belum aktif
                    if overlayTimer == nil {
                        startOverlayTimer(interval: TimeInterval(userPreference.reminderInterval * 60))
                    }
                    return
                }
            }
            
        } else {
            for workingHour in userPreference.workingHours {
                
                let startComponents = calendar.dateComponents([.hour, .minute], from: workingHour.startHour)
                let endComponents = calendar.dateComponents([.hour, .minute], from: workingHour.endHour)
                
                guard let startHour = startComponents.hour, let startMinute = startComponents.minute,
                      let endHour = endComponents.hour, let endMinute = endComponents.minute else {
                    continue
                }
                
                
                if (currentHour > startHour || (currentHour == startHour && currentMinute >= startMinute)) &&
                    (currentHour < endHour || (currentHour == endHour && currentMinute <= endMinute)) {
                    
                    
                    if overlayTimer == nil {
                        startOverlayTimer(interval: TimeInterval(userPreference.reminderInterval * 60))
                    }
                    return
                }
            }
        }
        
        // Jika tidak dalam waktu kerja atau tidak memenuhi kriteria, matikan overlayTimer jika aktif
        overlayTimer?.cancel()
        overlayTimer = nil
        var count = UserDefaults.standard.integer(forKey: UserDefaultsKey.kNotificationCount)
        
        count = 0
        
        UserDefaults.standard.setValue(count, forKey: UserDefaultsKey.kNotificationCount)
    }
    
    
    private func startOverlayTimer(interval: TimeInterval) {
        overlayTimer?.cancel()
        overlayTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global(qos: .background))
        overlayTimer?.schedule(deadline: .now() + interval, repeating: interval)
        overlayTimer?.setEventHandler { [weak self] in
            self?.showOverlay()
        }
        overlayTimer?.resume()
    }
    
    /// Triggerd Overlay base on notification
    func showOverlay() {
        overlayWindow = OverlayWindow()
        overlayWindow?.addViewContoller(OverlayView())
        overlayWindow?.show()
        
        var count = UserDefaults.standard.integer(forKey: UserDefaultsKey.kNotificationCount)
        
        count += 1
        
        UserDefaults.standard.setValue(count, forKey: UserDefaultsKey.kNotificationCount)
    }
}
