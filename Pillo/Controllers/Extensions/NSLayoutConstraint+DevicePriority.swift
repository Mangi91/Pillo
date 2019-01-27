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
        self.priority = UIDevice.current.device != .iPhoneXXSXRXP ? UILayoutPriority(maxPriority) : UILayoutPriority(minPriority)
    }
}
