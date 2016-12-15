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
    @available(iOS 9.3, *)
    public var isTouchIDAvailable: Bool {
        return LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    /// Presents the Touch ID prompt to the user.
    ///
    /// - Parameters:
    ///   - localizedReason: The reason the prompt is being presented.
    ///   - completion: `success` true if authentication succeeded.  `error` has a value if validation failed or was cancelled.
    @available(iOS 9.3, *)
    public func authenticateWithTouchID(_ localizedReason: String, completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        DispatchQueue.global(qos: .default).async {
            let context = LAContext()
            let policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
            
            do {
                if try context.canEvaluatePolicy(policy, error: nil) {
                    // Evaluate the policy...
                    context.evaluatePolicy(policy, localizedReason: localizedReason) { success, error in
                        // Policy has been evaluated.
                        DispatchQueue.main.async {
                            completion(success, error)
                        }
                        return
                    }
                } else {
                    // Did not pass evaluation.
                    DispatchQueue.main.async {
                        completion(false, nil)
                    }
                    return
                }
            } catch {
                // An error ocurred.
                DispatchQueue.main.async {
                    completion(false, error)
                }
                return
            }
        }
    }
}

