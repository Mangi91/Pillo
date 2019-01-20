//
//  NSLayoutConstraint+DevicePriority.swift
//  Pillo
//
//  Created by Manuel Cubillo on 1/20/19.
//  Copyright © 2019 Manuel Cubillo. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    func iPhoneXPriority(maxPriority:Float, minPriority:Float) {
        let device = UIDevice.current.name
        self.priority = device != "iPhone X" ? UILayoutPriority(maxPriority) : UILayoutPriority(minPriority)
    }
}
