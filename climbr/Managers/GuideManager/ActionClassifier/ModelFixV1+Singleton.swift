//
//  ModelFixV1+Singleton.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 09/08/24.
//

import CoreML


extension ModelFixV2{
    
    static let shared: ModelFixV2 = {
        let defaultConfig = MLModelConfiguration()
        
        guard let modelFixV2 = try? ModelFixV2(configuration: defaultConfig) else {
            fatalError("Model failed to initialize.")
        }
        
        modelFixV2.checkLabels()
        
        return modelFixV2
    }()
    
    
}
