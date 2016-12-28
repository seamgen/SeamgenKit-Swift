//
//  LinearGradientView.swift
//  Pods
//
//  Created by Sam Gerardi on 12/28/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import UIKit


struct LinearGradient {
    
    var colors: [UIColor] = [.black, .white]
    
    var locations: [CGFloat] = [0, 1]
    
    var startPoint: CGPoint = .zero
    
    var endPoint: CGPoint = CGPoint(x: 0, y: 1)
}


class LinearGradientView: UIView {
    
    var gradient: LinearGradient = LinearGradient() {
        didSet { updateGradient() }
    }
    
    private var gradientLayer: CAGradientLayer {
        return self.layer as! CAGradientLayer
    }
    
    override class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateGradient()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateGradient()
    }
    
    private func updateGradient() {
        gradientLayer.colors = gradient.colors.map { $0.cgColor }
        gradientLayer.locations = gradient.locations.map { NSNumber(value: Float($0)) }
        gradientLayer.startPoint = gradient.startPoint
        gradientLayer.endPoint = gradient.endPoint
    }
}

