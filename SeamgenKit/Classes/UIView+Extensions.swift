//
//  UIView+Extensions.swift
//  SeamgenKit
//
//  Created by Sam Gerardi on 12/12/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import UIKit


extension UIView {
    
    /// Adds multiple subviews to the view.
    ///
    /// - Parameter views: The subviews to add to the view.
    public func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    /// Adds multiple subviews to the view.
    ///
    /// - Parameter views: The subviews to add to the view.
    public func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}

