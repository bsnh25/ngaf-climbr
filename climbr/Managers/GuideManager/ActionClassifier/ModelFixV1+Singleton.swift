//
//  ModelFixV1+Singleton.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 09/08/24.
//

import CoreML


extension ModelFixV1{
    
    static let shared: ModelFixV1 = {
        let defaultConfig = MLModelConfiguration()
        
        guard let modelFixV1 = try? ModelFixV1(configuration: defaultConfig) else {
            fatalError("Model failed to initialize.")
        }
        
        modelFixV1.checkLabels()
        
        return modelFixV1
    }()
    
    
}
