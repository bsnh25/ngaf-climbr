//
//  Predictor.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 11/08/24.
//

import Foundation
import Vision

typealias stretchClassifier = ModelFixV2

protocol PredictorDelegate: AnyObject {
    func predictor(_ predictor: Predictor, didFindNewRecognizedPoints points: [CGPoint])
    func predictor(_ predictor: Predictor, didLabelAction action: String, with confidence: Double)
}

class Predictor {
    
    weak var delegate : PredictorDelegate?
    
    let predictionWindowSize = 30
    var posesWindow : [VNHumanBodyPoseObservation] = []
    
    init(){
        posesWindow.reserveCapacity(predictionWindowSize)
    }
    
    func estimation(sampleBuffer : CMSampleBuffer){
        let requestHandler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, orientation: .up)
        
        let request = VNDetectHumanBodyPoseRequest(completionHandler: bodyPoseHandler)
        
        do{
            try requestHandler.perform([request])
        }catch{
            print("Unable to perform the request, with error \(error)")
        }
    }
    
    func bodyPoseHandler(request: VNRequest, error: Error?){
        guard let observations = request.results as? [VNHumanBodyPoseObservation] else {return}
        
        observations.forEach {
            processObservation($0)
        }
        
        if let result = observations.first{
            storeObservation(result)
            
            labelActionType()
        }
    }
    
    func labelActionType(){
        guard let stretchingClassifier = try? stretchClassifier(configuration: MLModelConfiguration()),
            let poseMultiArray = prepareInputWithObservations(posesWindow),
            let predictions = try? stretchingClassifier.prediction(poses    : poseMultiArray)
        else {return}
        
        let label = predictions.label
        let confident = predictions.labelProbabilities[label] ?? 0
        
        delegate?.predictor(self, didLabelAction: label, with: confident)
    }
    
    func prepareInputWithObservations(_ observations: [VNHumanBodyPoseObservation])->MLMultiArray?{
        let numAvailableFrames = observations.count
        let observationNeeded = 30
        var multiArrayBuffer = [MLMultiArray]()
        
        for frameindex in 0..<min(numAvailableFrames, observationNeeded){
            let pose = observations[frameindex]
            do{
                let oneFrameMultiArray = try pose.keypointsMultiArray()
                multiArrayBuffer.append(oneFrameMultiArray)
            }catch{
                continue
            }
        }
        
        if numAvailableFrames < observationNeeded {
            for _ in 0 ..< (observationNeeded - numAvailableFrames){
                do{
                    let oneFrameMultiArray = try MLMultiArray(shape: [1,3,18], dataType: .double)
                    try resetMultiArray(oneFrameMultiArray)
                    multiArrayBuffer.append(oneFrameMultiArray)
                }catch{
                    continue
                }
            }
        }
        
        return MLMultiArray(concatenating: [MLMultiArray](multiArrayBuffer), axis: 0, dataType: .float )
    }
    
    func resetMultiArray(_ predictionWindow: MLMultiArray, with value: Double = 0.0) throws{
        let pointer = try UnsafeMutableBufferPointer<Double>(predictionWindow )
        pointer.initialize(repeating: value)
    }
    
    func storeObservation(_ observation: VNHumanBodyPoseObservation){
        if posesWindow.count >= predictionWindowSize {
            posesWindow.removeFirst()
        }
        
        posesWindow.append(observation)
    }
    
    func processObservation(_ observation: VNHumanBodyPoseObservation){
        do{
            let recognizedPoints = try observation.recognizedPoints(forGroupKey: .all)
            
            let displayedPoints = recognizedPoints.map{
                CGPoint(x: $0.value.x, y: 1-$0.value.y)
//                print("x: \($0.value.x), y: \(1-$0.value.y) ")
            }
            
            delegate?.predictor(self, didFindNewRecognizedPoints: displayedPoints)
        }catch{
            print("error finding recognized points")
        }
    }
}
