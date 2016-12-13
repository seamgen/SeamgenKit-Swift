//
//  UIColor+Extensions.swift
//  SeamgenKit
//
//  Created by Sam Gerardi on 12/12/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import UIKit


extension UIColor {
    
    /// Initializes the color with values between 0 and 254
    ///
    /// - Parameters:
    ///   - r: The red component.
    ///   - g: The green component.
    ///   - b: The blue component.
    ///   - alpha: The alpha component (between 0.0 and 1.0)
    public convenience init(r: Int, g: Int, b: Int, alpha: CGFloat) {
        precondition(r >= 0 && r <= 255)
        precondition(g >= 0 && g <= 255)
        precondition(b >= 0 && b <= 255)
        precondition(alpha >= 0 && alpha <= 1)
        
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
}

