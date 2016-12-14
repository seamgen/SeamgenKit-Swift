//
//  String+Extensions.swift
//  SeamgenKit
//
//  Created by Sam Gerardi on 12/12/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import Foundation


public extension String {
    
    /// Returns the integer value of the string or 0.
    public var intValue: Int {
        return Int(self) ?? 0
    }
    
    /// Returns the double value of the string or 0.
    public var doubleValue: Double {
        return Double(self) ?? 0
    }
    
    /// Returns the float value of the string or 0.
    public var floatValue: Float {
        return Float(self) ?? 0
    }
    
    /// Returns the boolean value of the string or false.
    /// Valid true values are "true", "yes", "y".
    /// The check is case insensitive.
    public var boolValue: Bool {
        if let boolValue = Bool(self) {
            return boolValue
        }
        
        if let intValue = Int(self) {
            return intValue > 0
        }
        
        if caseInsensitiveCompare("true") == .orderedSame
            || caseInsensitiveCompare("yes") == .orderedSame
            || caseInsensitiveCompare("y") == .orderedSame {
            return true
        }
        
        return false
    }
}


extension String {
    
    /// True if the string contains numbers.
    public var containsNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .numeric, range: nil) != nil
    }
    
    /// True if the string contains letters.
    public var containsLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .literal, range: nil) != nil
    }
    
    /// True if the string contains only numbers.
    public var isNumeric: Bool {
        return containsNumbers && !containsLetters
    }
    
    /// True if the string contains only letters.
    public var isAlphabetic: Bool {
        return !containsNumbers && containsLetters
    }
    
    /// True if the string contains only numbers and letters.
    public var isAlphaNumeric: Bool {
        return containsLetters && containsNumbers
    }
    
    /// Returns only the numbers from the string.
    public var numbers: String? {
        return self.includingCharactersIn(.decimalDigits)
    }
    
    /// Returns a string containing only the characters in the given character set.
    public func includingCharactersIn(_ characterSet: CharacterSet) -> String? {
        let unicodeScalars = self.unicodeScalars.filter { return characterSet.contains($0) }
        let scalarView = String.UnicodeScalarView(unicodeScalars)
        let result = String(scalarView)
        return result.isEmpty ? nil : result
    }
}

