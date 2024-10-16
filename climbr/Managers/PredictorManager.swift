//
//  GuideMovementManager.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 11/08/24.
//

import Foundation
import Vision

typealias stretchClassifier = ModelFixV4

protocol PredictorDelegate: AnyObject {
    func predictor(didFindNewRecognizedPoints points: [CGPoint])
    func predictor(didLabelAction action: String, with confidence: Double)
    func predictor(didDetectUpperBody value: Bool, boundingBox: NSRect)
}

class PredictorManager: PredictorService {
    var bufferSize: CGSize = .zero {
        didSet {
            print("BUFF: ", bufferSize)
        }
    }
    
    weak var delegate : PredictorDelegate?
    
    let predictionWindowSize = 30
    var posesWindow : [VNHumanBodyPoseObservation] = []
    var didDetectUpperBody: Bool = false
    
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
        
        if didDetectUpperBody {
            delegate?.predictor(didLabelAction: label, with: confident)
        }
        
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
        
        do{
            let recognizedPoints = try observation.recognizedPoints(forGroupKey: .all)
            
            let displayedPoints = recognizedPoints.map{
                CGPoint(x: $0.value.x, y: 1-$0.value.y)
            }
            
            delegate?.predictor(didFindNewRecognizedPoints: displayedPoints)
        }catch{
            print("error finding recognized points")
        }
      
    }
  
  func detectHumanUpperBody(sampleBuffer : CMSampleBuffer){
    print("detectHumanUpperBody")
    let requestHandler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, orientation: .up)
    
    let request = VNDetectHumanRectanglesRequest(completionHandler: upperBodyHandler)
    
    request.revision = VNDetectHumanRectanglesRequestRevision2
    request.upperBodyOnly = true
     
    // x: 252, y: 0, w: 504, h: 450
    // CGRect(x: 0.28, y: 0, width: 0.56, height: 0.417)
    // TODO: change RoI to dynamic value
    request.regionOfInterest = CGRect(x: 0.28, y: 0, width: 0.56, height: 0.417)
//    request.regionOfInterest = VNNormalizedRectForImageRect(
//      CGRect(x: 250, y: 0, width: 504, height: 450),
//      Int(bufferSize.width),
//      Int(bufferSize.height)
//    )
    
    do{
        try requestHandler.perform([request])
    }catch{
        print("Unable to perform the request, with error \(error)")
    }
  }
  
  private func upperBodyHandler(request: VNRequest, error: Error?){
    print("upperBodyHandler")
    if let error {
      print(error)
      return
    }
    guard let observations = request.results as? [VNHumanObservation] else { return }
    
    if let result = observations.first {
      let objectBounds = VNImageRectForNormalizedRect(result.boundingBox, Int(bufferSize.width), Int(bufferSize.height))
      
      didDetectUpperBody = result.confidence > 0.7
      
      delegate?.predictor(didDetectUpperBody: didDetectUpperBody, boundingBox: objectBounds)
      
      print("View BB: \(objectBounds) - confidence: \(result.confidence)")
      print("ROI BB: \(result.boundingBox) - confidence: \(result.confidence)")
    }
  }
  
}
