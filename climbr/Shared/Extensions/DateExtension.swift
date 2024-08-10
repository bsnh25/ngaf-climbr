//
//  DateExtension.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Foundation

extension Date {
    private func formatTimeToGMT7(date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            
            // Set the time zone to GMT+7
            if let gmt7 = TimeZone(secondsFromGMT: 7 * 3600) {
                formatter.timeZone = gmt7
            }
            
            return formatter.string(from: date)
        }
}
