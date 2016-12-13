//
//  UIStackView+Extensions.swift
//  SeamgenKit
//
//  Created by Sam Gerardi on 12/12/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import UIKit


extension UIStackView {
 
    public func addArrangedSubviews(_ views: UIView ...) {
        views.forEach { addArrangedSubview($0) }
    }
    
    public func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
}

