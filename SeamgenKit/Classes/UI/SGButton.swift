//
//  SGButton.swift
//  Pods
//
//  Created by Sam Gerardi on 12/28/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import UIKit


enum ImagePlacement {
    case top
    case left
    case right
    case bottom
}


/// A subclass of UIButton that allows the image view to be positioned relative to the title label.
class SGButton: UIButton {
    
    /// The placement of the image view relative to the title label.
    var imagePlacement: ImagePlacement = .left {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }
    
    /// The amount space between the title label and the image view.
    var spacing: CGFloat = 6 {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }
    
    private func calculateSpacing() -> CGFloat {
        if let _ = currentImage, let _ = currentTitle {
            return spacing
        }
        return 0
    }
    
    override var intrinsicContentSize: CGSize {
        var returnValue = super.intrinsicContentSize
        
        switch imagePlacement {
        case .top, .bottom:
            if let imageSize = currentImage?.size,
                let textSize = titleLabel?.sizeThatFits(bounds.size)
            {
                returnValue.height = imageSize.height + textSize.height
                returnValue.width = max(imageSize.width, textSize.width)
            }
            returnValue.height += calculateSpacing()
        default:
            returnValue.width += calculateSpacing()
            
        }
        
        return returnValue
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        var returnValue: CGRect = super.titleRect(forContentRect: contentRect)
        
        switch imagePlacement {
        case .top:
            returnValue.size.width = contentRect.size.width
            returnValue.origin.x = (contentRect.size.width - returnValue.size.width) / 2
            returnValue.origin.y = contentRect.size.height - returnValue.size.height
        case .left:
            break
        case .right:
            returnValue.origin.x = 0
        case .bottom:
            returnValue.size.width = contentRect.size.width
            returnValue.origin.x = (contentRect.size.width - returnValue.size.width) / 2
            returnValue.origin.y = 0
        }
        
        return returnValue
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        var returnValue: CGRect = super.imageRect(forContentRect: contentRect)
        
        switch imagePlacement {
        case .top:
            returnValue.origin.x = (contentRect.size.width - returnValue.size.width) / 2
            returnValue.origin.y = 0
        case .left:
            break
        case .right:
            returnValue.origin.x = contentRect.size.width - returnValue.size.width
        case .bottom:
            returnValue.origin.x = (contentRect.size.width - returnValue.size.width) / 2
            returnValue.origin.y = contentRect.size.height - returnValue.size.height
        }
        
        return returnValue
    }
}

