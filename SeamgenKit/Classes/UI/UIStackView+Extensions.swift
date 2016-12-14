//
//  UIStackView+Extensions.swift
//  SeamgenKit
//
//  Created by Sam Gerardi on 12/12/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import UIKit


extension UIStackView {
 
    /// Adds multiple arranged subviews to the stack view.
    ///
    /// - Parameter views: The subviews to add to the view.
    public func addArrangedSubviews(_ views: UIView ...) {
        views.forEach { addArrangedSubview($0) }
    }
    
    /// Adds multiple arranged subviews to the stack view.
    ///
    /// - Parameter views: The subviews to add to the view.
    public func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
}

