//
//  UIDevice+Extensions.swift
//  Pods
//
//  Created by Sam Gerardi on 12/15/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import UIKit
import LocalAuthentication


extension UIDevice {
    
    /// Returns true if Touch ID is available on this device.
    var isTouchIDAvailable: Bool {
        return LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
}

