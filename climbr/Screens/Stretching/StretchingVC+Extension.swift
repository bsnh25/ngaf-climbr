//
//  StretchingVC+Extension.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Foundation

extension StretchingVC {
    @objc func skip() {
        guard let _ = Movement.items[safe: nextIndex+1] else {
            return
        }
        
        currentIndex = nextIndex
        nextIndex += 1
    }
}
