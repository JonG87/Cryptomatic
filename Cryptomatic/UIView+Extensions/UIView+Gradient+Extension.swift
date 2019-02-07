//
//  UIView+Gradient+Extension.swift
//  Cryptomatic
//
//  Created by Jonathan Grajkowski on 2019-02-06.
//  Copyright © 2019 Jonathan Grajkowski. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    open func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
