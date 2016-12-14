//
//  MKMapSnapshot+Extensions.swift
//  SeamgenKit
//
//  Created by Sam Gerardi on 12/13/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import UIKit
import MapKit


extension MKMapSnapshot {
    
    /// Draws a standard pin annotation at a given coordinate.
    ///
    /// - Parameter coordinate: The location of the pin in the image.
    /// - Returns: The snapshot image with the pin annotation.
    public func imageWithAnnotation(atCoordinate coordinate: CLLocationCoordinate2D) -> UIImage? {
        
        let pin = MKPinAnnotationView(annotation: nil, reuseIdentifier: "")
        guard let pinImage = pin.image else { return image }
        
        UIGraphicsBeginImageContextWithOptions(image.size, true, image.scale)
        image.draw(at: CGPoint.zero)
        
        var annotationPoint = point(for: coordinate)
        
        annotationPoint.x -= pin.bounds.width / 2.0
        annotationPoint.y -= pin.bounds.height / 2.0
        annotationPoint.x += pin.centerOffset.x
        annotationPoint.y += pin.centerOffset.y
        
        pinImage.draw(at: annotationPoint)
        let annotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return annotatedImage
    }
}

