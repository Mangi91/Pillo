//
//  AVAudioPlayer+Helpers.swift
//  Pillo
//
//  Created by Manuel Cubillo on 1/20/19.
//  Copyright © 2019 Manuel Cubillo. All rights reserved.
//

import AVFoundation

extension AVAudioPlayer {
    convenience init?(withResource resource: String, numberOfLoops loops: Int = 0) {
        let path = Bundle.main.path(forResource: resource, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            try self.init(contentsOf: url)
            self.numberOfLoops = loops
            self.prepareToPlay()
        } catch {
           return nil
        }
    }
    
    func play(withDelay delay: Double, completion: (() -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.play()
            if let completion = completion {
                completion()
            }
        }
    }
}

