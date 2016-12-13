//
//  FloatingPoint+Extensions.swift
//  SeamgenKit
//
//  Created by Sam Gerardi on 12/12/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import Foundation


extension FloatingPoint {
    
    /// Returns the current value (assumed to be degrees) in radians.
    public var degreesToRadians: Self {
        return Self.pi * self / Self(180)
    }
    
    /// Returns the current value (assumed to be radians) to degrees.
    public var radiansToDegrees: Self {
        return self * Self(180) / Self.pi
    }
}

