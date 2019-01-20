//
//  Platform.swift
//  Pillo
//
//  Created by Manuel Cubillo on 1/10/19.
//  Copyright © 2019 Manuel Cubillo. All rights reserved.
//

import Foundation

struct Platform {
    static var isSimulator: Bool {
        get {
            var isSim = false
            
            #if targetEnvironment(simulator)
                isSim =  true
            #endif
            
            return isSim
        }
    }
}
