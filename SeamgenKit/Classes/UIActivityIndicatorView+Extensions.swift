//
//  UIActivityIndicatorView+Extensions.swift
//  SeamgenKit
//
//  Created by Sam Gerardi on 12/12/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import UIKit


extension UIActivityIndicatorView {
    
    /// Starts/stops animating the view.
    public var animate: Bool {
        get { return isAnimating }
        set { newValue ? startAnimating() : stopAnimating() }
    }
}

