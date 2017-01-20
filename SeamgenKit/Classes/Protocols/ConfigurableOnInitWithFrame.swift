//
//  ConfigurableOnInitWithFrame.swift
//  Pods
//
//  Created by Sam Gerardi on 1/20/17.
//  Copyright © 2017 Seamgen. All rights reserved.
//

import UIKit


/// Enables conforming classes to support a block based initializer syntax.
/// This protocol exists to mark classes as having the basic requirements for the protocol.
public protocol ConfigurableOnInitWithFrame: class {
    
    init(frame: CGRect)
}


extension UIView: ConfigurableOnInitWithFrame { }


extension ConfigurableOnInitWithFrame {
    
    /// Initializes the class using `init()` and then calls the configuration block.
    ///
    /// - Parameter configuration: Called after the object has been initialized to perform customizations.
    public init(frame: CGRect, _ configuration: (Self) -> Void) {
        self.init(frame: frame)
        configuration(self)
    }
}

