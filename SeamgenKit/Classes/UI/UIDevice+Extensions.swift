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
    
    /**
     Presents the TouchID prompt to the user.
     
     See `LAError.h` for more information.
     
     - parameters:
         - localizedReason: The reason the prompt is being presented.
         - completion: Called when the user takes action.
         - success: True if the authentication succeeded.
         - error: The error that ocurred. (see LAError)
     
     ```
     UIDevice.current.authenticateWithTouchID("Log In") { success, error in
         if let error = error as? LAError {
             switch error.code {
             case .userCancel:
                 // Handle user cancellation.
                 break
             case .appCancel:
                 // Handle app cancellation.
                 break
             case .authenticationFailed:
                 // Handle authentication failure.
                 break
             default:
                 // Handle other errors.
                 break
             }
         }
     
         if success {
             // Handle success.
         } else {
             // Handle failure.
         }
     }
     
     ```
     */
    public func authenticateWithTouchID(_ localizedReason: String, completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        DispatchQueue.global(qos: .default).async {
            let context = LAContext()
            let policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
            
            do {
                try context.canEvaluatePolicy(policy, error: nil)
                context.evaluatePolicy(policy, localizedReason: localizedReason) { success, error in
                    DispatchQueue.main.async {
                        completion(success, error)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(false, error)
                }
                return
            }
        }
    }
}

