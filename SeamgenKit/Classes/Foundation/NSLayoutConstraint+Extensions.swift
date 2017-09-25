//
//  NSLayoutConstraint+Extensions.swift
//  SeamgenKit
//
//  Created by Sam Gerardi on 12/12/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import Foundation


extension NSLayoutConstraint {
    
    /// Activates the constraint.
    public func activated() -> NSLayoutConstraint {
        self.isActive = true
        return self
    }
}

#if swift(>=4)
#else
    
extension NSLayoutConstraint {

    /// Sets the layout priority of the constraint.
    ///
    /// - Parameter priority: The layout priority.
    /// - Returns: The constraint.
    public func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
    
extension UILayoutPriority {
    public static let low = UILayoutPriorityDefaultLow
    public static let high = UILayoutPriorityDefaultHigh
    public static let required = UILayoutPriorityRequired
    public static let fittingSize = UILayoutPriorityFittingSizeLevel
}
#endif
