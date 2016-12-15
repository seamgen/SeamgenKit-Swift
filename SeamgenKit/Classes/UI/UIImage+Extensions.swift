//
//  UIImage+Extensions.swift
//  SeamgenKit
//
//  Created by Sam Gerardi on 12/12/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import UIKit
import AVFoundation


extension UIImage {
    
    /// Initializes the image with a given fill color.
    ///
    /// - Parameters:
    ///   - color:  The fill color of the image.
    ///   - size:   The size of the image.
    public convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.init(cgImage: image.cgImage!)
    }
}


extension UIImage {
    
    /// Scales the image to a given size.
    ///
    /// - Parameters:
    ///   - size:       The new size of the image.
    ///   - hasAlpha:   Include an alpha channel.
    /// - Returns: The scaled image.
    func scaledTo(size: CGSize, hasAlpha: Bool = false) -> UIImage {
        let image = self
        let scale: CGFloat = image.scale
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.draw(in: CGRect(origin: .zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    /// Scales the image to fit within a given size while maintaining the aspect ratio.
    ///
    /// - Parameters:
    ///   - size: The maximum size of the scaled image.
    ///   - hasAlpha: Include an alpha channel.
    /// - Returns: The scaled image.
    func scaledTo(fitSize size: CGSize, hasAlpha: Bool = false) -> UIImage {
        let newSize = self.size.aspectFit(to: size)
        return self.scaledTo(size: newSize)
    }
    
    /// Scales the image to fill a given size whil maintaining the aspect ratio.
    ///
    /// - Parameters:
    ///   - size: The minimum size of the scaled image.
    ///   - hasAlpha: Include an alpha channel.
    /// - Returns: The scaled image.
    func scaledTo(fillSize size: CGSize, hasAlpha: Bool = false) -> UIImage {
        let newSize = self.size.aspectFill(to: size)
        return self.scaledTo(size: newSize)
    }
}

