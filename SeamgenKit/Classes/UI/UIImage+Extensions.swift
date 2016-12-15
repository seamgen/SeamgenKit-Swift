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
    
    /// Writes the image as a JPEG file to disk.
    ///
    /// - Parameters:
    ///   - url: The location to save the image.
    ///   - compressionQuality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality).
    ///
    ///   - options: Data writing options.
    /// - Throws: See UIImageJPEGRepresentation
    public func writeJPEG(to url: URL, compressionQuality: CGFloat = 1.0, options: Data.WritingOptions = []) throws {
        let data = UIImageJPEGRepresentation(self, compressionQuality)!
        try data.write(to: url, options: options)
    }
}


// MARK: - Scaling

extension UIImage {
    
    /// Scales the image to a given size.
    ///
    /// - Parameters:
    ///   - size:       The new size of the image.
    ///   - hasAlpha:   Include an alpha channel.
    /// - Returns: The scaled image.
    public func scaledTo(size: CGSize, hasAlpha: Bool = false) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        defer { UIGraphicsEndImageContext() }
        
        draw(in: CGRect(origin: .zero, size: size))
        
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
    /// Scales the image to fit within a given size while maintaining the aspect ratio.
    ///
    /// - Parameters:
    ///   - size: The maximum size of the scaled image.
    ///   - hasAlpha: Include an alpha channel.
    /// - Returns: The scaled image.
    public func scaledTo(fitSize size: CGSize, hasAlpha: Bool = false) -> UIImage {
        let newSize = self.size.aspectFit(to: size)
        return self.scaledTo(size: newSize)
    }
    
    /// Scales the image to fill a given size whil maintaining the aspect ratio.
    ///
    /// - Parameters:
    ///   - size: The minimum size of the scaled image.
    ///   - hasAlpha: Include an alpha channel.
    /// - Returns: The scaled image.
    public func scaledTo(fillSize size: CGSize, hasAlpha: Bool = false) -> UIImage {
        let newSize = self.size.aspectFill(to: size)
        return self.scaledTo(size: newSize)
    }
}

