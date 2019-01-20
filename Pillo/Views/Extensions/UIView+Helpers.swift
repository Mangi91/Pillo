//
//  UIView+GradientLayer.swift
//  Pillo
//
//  Created by Manuel Cubillo on 1/20/19.
//  Copyright © 2019 Manuel Cubillo. All rights reserved.
//

import UIKit

extension UIView {
    func addGradientLayer(colors:[CGColor], locations:[NSNumber]?) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func roundedCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
