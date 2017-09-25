//
//  Bool+Extensions.swift
//  SeamgenKit
//
//  Created by Sam Gerardi on 12/12/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import Foundation

public struct BoolStringFormat {
    /// The string representation of a true value.
    public let trueString: String
    /// The string representation of a false value.
    public let falseString: String
    
    
    /// Initializes the formatter with string representations for true and false.
    ///
    /// - Parameters:
    ///   - t: The string representation of a true value.
    ///   - f: The string representation of a false value.
    public init(t: String, f: String) {
        trueString = t
        falseString = f
    }
    
    /// Returns the string representation of the current value.
    public func stringFor(_ value: Bool) -> String {
        return value ? trueString : falseString
    }
}


extension BoolStringFormat {
    /// Returns "true" or "false".
    static let trueFalse = BoolStringFormat(t: "true", f: "false")
    /// Returns "yes" or "no"
    static let yesNo = BoolStringFormat(t: "yes", f: "no")
    /// Returns "t" or "f"
    static let yN = BoolStringFormat(t: "y", f: "n")
}


public extension Bool {
    
    /// Returns 1 for true, 0 for false.
    public var intValue: Int {
        return self ? 1 : 0
    }
    
    /// Returns a string representation of the boolean value.
    ///
    /// - Parameter format: The format of the string.  Defaults to .trueFalse
    /// - Returns: The string representation of the current value.
    public func stringValue(as format: BoolStringFormat) -> String {
        return format.stringFor(self)
    }
}

