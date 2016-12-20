//
//  Comparable+Extensions.swift
//  Pods
//
//  Created by Sam Gerardi on 12/18/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import Foundation


/**
 Clamps a value between a min and max.
 - parameter min: The minimum value to clamp to.
 - parameter max: The maximum value to clamp to.
 - returns: A function that takes a value and returns the value clamped to [min, max].
 */
public func clamp <T: Comparable> (min: T, _ max: T) -> (T -> T) {
    assert(min <= max)
    return { value in value < min ? min : value > max ? max : value }
}
