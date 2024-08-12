//
//  StretchingVC+Extension.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import AppKit
import AVFoundation
import AudioToolbox

extension StretchingVC {
    @objc func skip() {
        guard let _ = Movement.items[safe: currentIndex+1] else {
            return
        }
        
        currentIndex += 1
        nextIndex     = currentIndex+1
    }
    
    func finishEarly() {
        self.replace(with: StretchingResultVC())
    }
    
    @objc func showEndSessionAlert() {
        let alert                   = NSAlert()
        alert.messageText           = "Leaving So Soon?"
        alert.informativeText       = "Finishing the session early will reduce the amount of reward you will receive"
        alert.alertStyle            = .informational
        alert.icon                  = NSImage.appLogo
        alert.addButton(withTitle: "Stay")
        alert.addButton(withTitle: "End Session")
        
        if #available(macOS 11.0,*) {
            alert.buttons.last?.hasDestructiveAction = true
        }
        
        let result = alert.runModal()
        
        if result == .alertSecondButtonReturn {
            finishEarly()
        }
    }
    
    
}

extension StretchingVC : PredictorDelegate {
    func predictor(_ predictor: Predictor, didLabelAction action: String, with confidence: Double) {
        
        for name in ExerciseName.allCases {
            if name.rawValue == action && confidence > 0.5{
                if exerciseName != name {
                    exerciseName = name
                    print("\(name) and the confidence is \(confidence)")
                }
            }
        }
    }
    
    func predictor(_ predictor: Predictor, didFindNewRecognizedPoints points: [CGPoint]) {
        guard let previewLayer = cameraManager.previewLayer else {return}
        
        let convertedPoints = points.map{
            previewLayer.layerPointConverted(fromCaptureDevicePoint: $0)
        }
        
        let combinePath = CGMutablePath()
        
        for point in convertedPoints {
            let doPath = NSBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: 10, height: 10))
            combinePath.addPath(doPath.cgPath)
        }
        
        pointsLayer.path = combinePath
        
        DispatchQueue.main.async{
            self.pointsLayer.didChangeValue(for: \.path)
        }
    }
    
    
}

