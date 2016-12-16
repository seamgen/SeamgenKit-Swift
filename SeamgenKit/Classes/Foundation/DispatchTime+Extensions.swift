//
//  DispatchTime+Extensions.swift
//  Pods
//
//  Created by Sam Gerardi on 12/16/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import Foundation

/*:
 These extension methods allow DispatchTime to be initialized with a time interval.
  
 To dispatch after 5 seconds:
 DispatchQueue.main.asyncAfter(deadline: 5) { /* ... */ }
*/


extension DispatchTime: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Int) {
        self = DispatchTime.now() + .seconds(value)
    }
    
}

extension DispatchTime: ExpressibleByFloatLiteral {
    
    public init(floatLiteral value: Double) {
        self = DispatchTime.now() + .milliseconds(Int(value * 1000))
    }
    
}

