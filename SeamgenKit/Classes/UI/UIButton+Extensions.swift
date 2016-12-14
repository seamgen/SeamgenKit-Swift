//
//  UIButton+Extensions.swift
//  SeamgenKit
//
//  Created by Sam Gerardi on 12/12/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import UIKit


extension UIButton {
    
    /// The title for the normal state.
    public var title: String? {
        get { return title(for: .normal) }
        set { setTitle(newValue, for: .normal) }
    }
    
    /// The attributed title for the normal state.
    public var attributedTitle: NSAttributedString? {
        get { return attributedTitle(for: .normal) }
        set { setAttributedTitle(newValue, for: .normal) }
    }
    
    /// The title color for the normal state.
    public var titleColor: UIColor? {
        get { return titleColor(for: .normal) }
        set { setTitleColor(newValue, for: .normal) }
    }
    
    /// The image for the normal state.
    public var image: UIImage? {
        get { return image(for: .normal) }
        set { setImage(newValue, for: .normal) }
    }
}

