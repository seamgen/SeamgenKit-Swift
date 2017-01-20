//
//  ConfigurableOnInit.swift
//  Pods
//
//  Created by Sam Gerardi on 1/20/17.
//  Copyright © 2017 Seamgen. All rights reserved.
//

import Foundation


/// Enables conforming classes to support a block based initializer syntax.
/// This protocol exists to mark classes as having the basic requirements for the protocol.
protocol ConfigurableOnInit: class {
    
    init()
}


extension NSObject: ConfigurableOnInit { }


extension ConfigurableOnInit {
    
    /// Initializes the class using `init(frame: CGRect)` and then calls the configuration block.
    ///
    /// - Parameter configuration: Called after the object has been initialized to perform customizations.
    init(_ configuration: (Self) -> Void) {
        self.init()
        configuration(self)
    }
}

