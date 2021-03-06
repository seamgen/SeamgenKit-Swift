//
//  CGSize+Extensions.swift
//  SeamgenKit
//
//  Created by Sam Gerardi on 12/12/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import UIKit


extension CGSize {
    
    /// Aspect fit CGSize.
    ///
    /// - Parameter boundingSize: bounding size to fit self to.
    /// - Returns: self fitted into given bounding size
    public func scaledTo(fit boundingSize: CGSize) -> CGSize {
        let minRatio = min(boundingSize.width / width, boundingSize.height / height)
        return CGSize(width: width * minRatio, height: height * minRatio)
    }
    
    /// Aspect fill CGSize.
    ///
    /// - Parameter boundingSize: bounding size to fill self to.
    /// - Returns: self filled into given bounding size
    public func scaledTo(fill boundingSize: CGSize) -> CGSize {
        let minRatio = max(boundingSize.width / width, boundingSize.height / height)
        return CGSize(width: width * minRatio, height: height * minRatio)
    }
}

