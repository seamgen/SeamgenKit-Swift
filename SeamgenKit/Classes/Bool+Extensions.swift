//
//  Bool+Extensions.swift
//  SeamgenKit
//
//  Created by Sam Gerardi on 12/12/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import Foundation


public extension Bool {
    
    /// Returns 1 for true, 0 for false.
    public var intValue: Int {
        return self ? 1 : 0
    }
}

