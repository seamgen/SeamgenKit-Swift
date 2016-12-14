//
//  UIViewController+Extensions.swift
//  SeamgenKit
//
//  Created by Sam Gerardi on 12/13/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import UIKit


extension UIViewController {
    
    /// Presents an alert configured with an error message and a single dismiss button.
    /// The body of the alert will contain the localized description of the error.
    ///
    /// - Parameters:
    ///   - error: The error.   The localized description will be displayed as the alert message.
    ///   - title:              The title of the alert.
    ///   - defaultButtonTitle: The title of the dismiss button. Defaults to "OK"
    public func presentAlert(withError error: Swift.Error, title: String = "Error", defaultButtonTitle: String = "OK") {
        presentAlert(withTitle: title,
                     message: error.localizedDescription,
                     defaultButtonTitle: defaultButtonTitle,
                     completion: nil)
    }
    
    /// Presents an alert with a title, message, and dismiss button.
    ///
    /// - Parameters:
    ///   - title:              The title of the alert.
    ///   - message:            The message of the alert.
    ///   - defaultButtonTitle: The title of the dismiss button. Defaults to "OK"
    ///   - completion:         Called when the alert has been dismissed by tapping the dismiss button.
    public func presentAlert(withTitle title: String?, message: String?, defaultButtonTitle: String = "OK", completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: defaultButtonTitle,
                                                style: .default,
                                                handler: { _ in completion?() }))
        
        present(alertController, animated: true, completion: nil)
    }
    
    /// Presents an alert notifying the user that the feature they are trying
    /// to access is not available in this build.
    ///
    /// - Parameter message: An optional message.  A default message will be used if this is nil.
    public func presentNotImplementedAlert(_ message: String? = nil) {
        presentAlert(withTitle: "Not Implemented", message: message ?? "This feature will be implemented in a future build.")
    }
}

