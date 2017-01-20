//
//  EmptyValueRepresentable.swift
//  Pods
//
//  Created by Sam Gerardi on 1/20/17.
//  Copyright © 2017 Seamgen. All rights reserved.
//

import Foundation


/// A type that has an empty value representation, as opposed to `nil`.
/// More information available at: http://www.russbishop.net/improving-optionals
public protocol EmptyValueRepresentable {
    /// Provide the empty value representation of the conforming type.
    static var emptyValue: Self { get }
    
    /// - returns: `true` if `self` is the empty value.
    var isEmpty: Bool { get }
    
    /// `nil` if `self` is the empty value, `self` otherwise.
    /// An appropriate default implementation is provided automatically.
    func nilIfEmpty() -> Self?
}


extension EmptyValueRepresentable {
    public func nilIfEmpty() -> Self? {
        return self.isEmpty ? nil : self
    }
}


extension Array: EmptyValueRepresentable {
    public static var emptyValue: [Element] { return [] }
}


extension Set: EmptyValueRepresentable {
    public static var emptyValue: Set<Element> { return Set() }
}


extension Dictionary: EmptyValueRepresentable {
    public static var emptyValue: Dictionary<Key, Value> { return [:] }
}


extension String: EmptyValueRepresentable {
    public static var emptyValue: String { return "" }
}


public extension Optional where Wrapped: EmptyValueRepresentable {
    /// If `self == nil` returns the empty value, otherwise returns the value.
    public var valueOrEmpty: Wrapped {
        switch self {
        case .some(let value):
            return value
        case .none:
            return Wrapped.emptyValue
        }
    }
}

