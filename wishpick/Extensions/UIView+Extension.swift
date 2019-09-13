//
//  UIView+Extension.swift
//  wishpick
//
//  Created by Ryan Nguyen on 8/7/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

extension UIView {
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds // Same size as the object we are applying it
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0] // A point where the color blends
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 2.0) // Color Starts
        gradientLayer.endPoint = CGPoint(x: 0.4, y: 0.0) // Ends
        
        layer.insertSublayer(gradientLayer, at: 0)
        
    }
}
