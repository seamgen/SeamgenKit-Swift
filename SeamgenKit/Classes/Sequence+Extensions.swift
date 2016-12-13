//
//  Sequence+Extensions.swift
//  SeamgenKit
//
//  Created by Sam Gerardi on 12/13/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import Foundation


extension Sequence {
    
    /// Groups a sequence of elements by for a given key.
    ///
    /// - parameter predicate: Return the key that should be used to group the elements.
    ///
    /// - throws: Allows the preficate to throw if needed.
    ///
    /// - returns: A dictionary of elements grouped by the key returned in the predicate.
    public func grouped<Key: Hashable>(by predicate: (Self.Iterator.Element) throws -> Key) rethrows -> [Key : [Self.Iterator.Element]] {
        var groups: [Key : [Self.Iterator.Element]] = [:]
        
        for element in self {
            let key = try! predicate(element)
            
            if case nil = groups[key]?.append(element) {
                groups[key] = [element]
            }
        }
        
        return groups
    }
}

