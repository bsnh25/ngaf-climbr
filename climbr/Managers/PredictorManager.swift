//
//  GuideMovementManager.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 11/08/24.
//

import Foundation
import Vision

typealias stretchClassifier = ModelFixV2

protocol PredictorDelegate: AnyObject {
    func predictor(didFindNewRecognizedPoints points: [CGPoint])
    func predictor(didLabelAction action: String, with confidence: Double)
    func predictor(didDetectUpperBody value: Bool, with joints: [VNHumanBodyPoseObservation.JointName])
}

class PredictorManager: PredictorService {
    
    weak var delegate : PredictorDelegate?
    
    let predictionWindowSize = 30
    var detectedJoints: [VNHumanBodyPoseObservation.JointName] = []
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
    
    private func bodyPoseHandler(request: VNRequest, error: Error?){
        guard let observations = request.results as? [VNHumanBodyPoseObservation] else {return}
        
        observations.forEach {
            processObservation($0)
        }
        
        if let result = observations.first{
            storeObservation(result)
            
            labelActionType()
        }
    }
    
    private func labelActionType() {
        guard let stretchingClassifier = try? stretchClassifier(configuration: MLModelConfiguration()),
            let poseMultiArray = prepareInputWithObservations(posesWindow),
            let predictions = try? stretchingClassifier.prediction(poses: poseMultiArray)
        else {return}
        
        let label = predictions.label
        let confident = predictions.labelProbabilities[label] ?? 0
        
        if detectUpperBody() {
            delegate?.predictor(didLabelAction: label, with: confident)
        }
        
        delegate?.predictor(didDetectUpperBody: detectUpperBody(), with: detectedJoints)
        
    }
    
    private func detectUpperBody() -> Bool {
        (detectedJoints.contains(.rightShoulder) || detectedJoints.contains(.leftShoulder)) &&
        (detectedJoints.contains(.rightEye) || detectedJoints.contains(.leftEye)) &&
        (detectedJoints.contains(.leftEar) || detectedJoints.contains(.rightEar)) &&
        (detectedJoints.contains(.rightElbow) || detectedJoints.contains(.leftElbow)) &&
        detectedJoints.contains(.neck) || detectedJoints.contains(.nose) ||
        detectedJoints.contains(.leftWrist) || detectedJoints.contains(.rightWrist)
    }
    
    private func prepareInputWithObservations(_ observations: [VNHumanBodyPoseObservation])->MLMultiArray?{
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
    
    private func resetMultiArray(_ predictionWindow: MLMultiArray, with value: Double = 0.0) throws{
        let pointer = try UnsafeMutableBufferPointer<Double>(predictionWindow )
        pointer.initialize(repeating: value)
    }
    
    private func storeObservation(_ observation: VNHumanBodyPoseObservation){
        if posesWindow.count >= predictionWindowSize {
            posesWindow.removeFirst()
        }
        
        posesWindow.append(observation)
    }
    
    private func processObservation(_ observation: VNHumanBodyPoseObservation){
        
        self.detectedJoints = observation.availableJointNames.compactMap { joint in
            do {
                let point = try observation.recognizedPoint(joint)
                
                if point.confidence > 0.5 {
                    return joint
                }
                
                return nil
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
        
        do{
            let recognizedPoints = try observation.recognizedPoints(forGroupKey: .all)
            
            let displayedPoints = recognizedPoints.map{
                CGPoint(x: $0.value.x, y: 1-$0.value.y)
//                print("x: \($0.value.x), y: \(1-$0.value.y) ")
            }
            
            delegate?.predictor(didFindNewRecognizedPoints: displayedPoints)
        }catch{
            print("error finding recognized points")
        }
    }
}
