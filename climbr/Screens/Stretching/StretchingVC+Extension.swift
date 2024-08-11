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
}

extension StretchingVC : PredictorDelegate {
    func predictor(_ predictor: Predictor, didLabelAction action: String, with confidence: Double) {
//        if action == "Cross Body Shoulder Left" && confidence > 0.75 {
//            print("Cross Body Shoulder Left detected")
//        }
        print("\(action) and the confidence is \(confidence)")
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
//            self.isStretch = false
//        }
        
//        DispatchQueue.main.async{
//            AudioServicesPlayAlertSound(SystemSoundID(1322))
//        }
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

