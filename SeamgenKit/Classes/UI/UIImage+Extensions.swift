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

    /// Creates an image from a color.
    ///
    /// - Parameters:
    ///   - color:          The fill color.
    ///   - borderColor:    The border color (only applied if borderWidth > 0)
    ///   - borderWidth:    The width of the border (must be > 0).
    ///   - cornerRadius:   The corner radius (must be > 0)
    ///   - corners:        The corners that will be rounded (pass nil to round all of the corners)
    ///   - size:           The size of the output image.
    public convenience init(color: UIColor,
                            borderColor: UIColor? = nil,
                            borderWidth: CGFloat = 0,
                            cornerRadius: CGFloat = 0,
                            corners: UIRectCorner? = nil,
                            size: CGSize = CGSize(width: 1, height: 1))
    {
        let inset = max(0, borderWidth / 2)
        let rect = CGRect(origin: .zero, size: size).insetBy(dx: inset, dy: inset)
        
        let path: CGPath = {
            let radius = max(0, cornerRadius)
            
            if radius > 0 {
                if let corners = corners {
                    return UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
                } else {
                    return UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath
                }
            }
            
            return UIBezierPath(rect: rect).cgPath
        }()
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        
        let fillMode: CGPathDrawingMode
        
        if let borderColor = borderColor?.cgColor, borderWidth > 0 {
            context.setStrokeColor(borderColor)
            context.setLineWidth(borderWidth)
            context.setLineCap(.square)
            fillMode = .fillStroke
        } else {
            fillMode = .fill
        }
        
        context.addPath(path)
        context.drawPath(using: fillMode)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        
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
        
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
    
    /// Scales the image to fit within a given size while maintaining the aspect ratio.
    ///
    /// - Parameters:
    ///   - size: The maximum size of the scaled image.
    ///   - hasAlpha: Include an alpha channel.
    /// - Returns: The scaled image.
    public func scaledTo(fitSize size: CGSize, hasAlpha: Bool = false) -> UIImage {
        let newSize = self.size.scaledTo(fit: size)
        return self.scaledTo(size: newSize)
    }
    
    /// Scales the image to fill a given size whil maintaining the aspect ratio.
    ///
    /// - Parameters:
    ///   - size: The minimum size of the scaled image.
    ///   - hasAlpha: Include an alpha channel.
    /// - Returns: The scaled image.
    public func scaledTo(fillSize size: CGSize, hasAlpha: Bool = false) -> UIImage {
        let newSize = self.size.scaledTo(fill: size)
        return self.scaledTo(size: newSize)
    }
}


// MARK: - Rotation

/// Defines an image rotation transform.
///
/// - none:         Don't rotate the image.
/// - left:         Rotate the image left (-90 degrees)
/// - right:        Rotate the image right (90 degrees)
/// - byDegrees:    Rotate the image a given number of degrees.
/// - byRadians:    Rotate the image a given number of radians.
public enum UIImageRotation {
    case none
    case left
    case right
    case byDegrees(Double)
    case byRadians(Double)
    
    /// Returns the rotation in radians.
    internal var radians: Double {
        switch self {
        case .none:                     return (0.0).degreesToRadians
        case .left:                     return (-90.0).degreesToRadians
        case .right:                    return (90.0).degreesToRadians
        case .byDegrees(let degrees):   return degrees.degreesToRadians
        case .byRadians(let radians):   return radians
        }
    }
}


extension UIImage {
    
    /// Returns the image rotated to a given degree.
    ///
    /// - Parameters:
    ///   - rotation:   The rotation to apply.
    ///   - flipped:    If the image should be flipped.
    /// - Returns: The rotated image.
    public func rotated(_ rotation: UIImageRotation, flipped: Bool = false) -> UIImage {
        if #available(iOS 10.0, *) {
            return iOS10_rotated(rotation, flipped: flipped)
        } else {
            return iOS9_rotated(rotation, flipped: flipped)
        }
    }
    
    @available(*, deprecated: 10.0)
    private func iOS9_rotated(_ rotation: UIImageRotation, flipped: Bool = false) -> UIImage {
        let radians = CGFloat(rotation.radians)
        let transform = CGAffineTransform(rotationAngle: radians)
        var rect = CGRect(origin: .zero, size: self.size).applying(transform)
        rect.origin = .zero
        
        UIGraphicsBeginImageContext(rect.size)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        guard let cgImage = cgImage else { return self }
        
        context.translateBy(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        context.rotate(by: radians)
        context.scaleBy(x: flipped ? -1 : 1, y: -1.0)
        context.draw(cgImage, in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
        
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
    
    @available(iOS 10.0, *)
    private func iOS10_rotated(_ rotation: UIImageRotation, flipped: Bool = false) -> UIImage {
        guard let cgImage = self.cgImage else { return self }
        
        let radians = CGFloat(rotation.radians)
        let transform = CGAffineTransform(rotationAngle: radians)
        var rect = CGRect(origin: .zero, size: self.size).applying(transform)
        rect.origin = .zero
        
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        return renderer.image { renderContext in
            renderContext.cgContext.translateBy(x: rect.midX, y: rect.midY)
            renderContext.cgContext.rotate(by: radians)
            renderContext.cgContext.scaleBy(x: flipped ? -1.0 : 1.0, y: -1.0)
            
            let drawRect = CGRect(origin: CGPoint(x: -self.size.width/2, y: -self.size.height/2), size: self.size)
            renderContext.cgContext.draw(cgImage, in: drawRect)
        }
    }
}


// MARK: - Colorization

extension UIImage {
    
    /// Returns the image filled with a given color while maintaining the alpha channel.
    ///
    /// - Parameter color: The color that will fill the image.
    /// - Returns: The colorized image.
    public func filled(with color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        defer { UIGraphicsEndImageContext() }
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        context.setFillColor(color.cgColor)
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)
        
        guard let mask = self.cgImage else { return self }
        context.clip(to: rect, mask: mask)
        context.fill(rect)
        
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}

