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
    
    
    /// Initializes the color with a hex string.
    ///
    /// - Parameter string: A hex string with the format #DEF, #FF00FF, #FF00FF00.  The '#' is not required.
    public convenience init(hex string: String) {
        var hex = string.hasPrefix("#")
            ? String(string.characters.dropFirst())
            : string
        
        guard hex.characters.count == 3 || hex.characters.count == 6 || hex.characters.count == 8 else {
            self.init(white: 0, alpha: 0)
            return
        }
        
        if hex.characters.count == 3 {
            for (index, char) in hex.characters.enumerated() {
                hex.insert(char, at: hex.characters.index(hex.startIndex, offsetBy: index * 2))
            }
        }
        
        if hex.characters.count == 6 {
            hex += "FF"
        }
        
        self.init(
            red:    CGFloat((uint(hex, radix: 16)! >> 24) & 0xFF) / 255.0,
            green:  CGFloat((uint(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
            blue:   CGFloat((uint(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
            alpha:  CGFloat((uint(hex, radix: 16)!) & 0xFF) / 255.0)
    }
}

