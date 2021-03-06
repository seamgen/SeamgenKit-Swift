//
//  UIApplication+Extensions.swift
//  SeamgenKit
//
//  Created by Sam Gerardi on 12/12/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import UIKit
import Foundation


extension UIApplication {
    
    /// The display name of the application.
    public var displayName: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as! String
    }
    
    /// The version of the application from the info.plist (CFBundleShortVersionString)
    public var version: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    /// The build number from the info.plist (CFBundleVersionKey)
    public var buildNumber: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
    
    /// The bundle identifier from the info.plist (CFBundleIdentifierKey)
    public var bundleIdentifier: String {
        return Bundle.main.bundleIdentifier!
    }
    
    /// True if App Transport Security is enabled.
    public var isATSEnabled: Bool {
        guard let atsDict = Bundle.main.infoDictionary!["NSAppTransportSecurity"] as? [String: Any] else { return true }
        guard let allowArbitraryLoads = atsDict["NSAllowsArbitraryLoads"] as? Bool else { return true }
        return !allowArbitraryLoads
    }
}


public extension UIApplication {
    
    /// Launches the Settings app.
    @discardableResult
    public func launchSettingsApp() -> Bool {
        guard let url = URL(string: UIApplicationOpenSettingsURLString) else { return false }
        
        if #available(iOS 10.0, tvOS 9.0, *) {
            let result = canOpenURL(url)
            open(url, options: [:], completionHandler: nil)
            return result
        } else {
            return openURL(url)
        }
    }
    
    /// Dials a phone number immediately.
    ///
    /// - Parameter phoneNumber: The phone number to dial
    ///
    /// - Returns: True if the phone number was dialed.
    @discardableResult
    public func dial(_ phoneNumber: String) -> Bool {
        guard let url = URL(phoneCallTo: phoneNumber) else { return false }
        
        if #available(iOS 10.0, tvOS 9.0, *) {
            let result = canOpenURL(url)
            open(url, options: [:], completionHandler: nil)
            return result
        } else {
            return openURL(url)
        }
    }
    
    
    /// Navigates to the system messaging app (iMessage) to compose an SMS or iMessage.
    ///
    /// - Parameter phoneNumber: The recipient of the message.
    ///
    /// - Returns: True if the compose view was presented.
    @discardableResult
    public func composeSMS(to phoneNumber: String? = nil) -> Bool {
        guard let url = URL(smsTo: phoneNumber) else { return false }
        
        if #available(iOS 10.0, tvOS 9.0, *) {
            let result = canOpenURL(url)
            open(url, options: [:], completionHandler: nil)
            return result
        } else {
            return openURL(url)
        }
    }
    
    /// Navigates to the system mail app (Mail) to compose an email.
    ///
    /// - Parameters:
    ///   - recipient:  The recipient of the email.
    ///   - subject:    The subject.
    ///   - body:       The message body.
    ///   - cc:         CC of the email.
    ///
    /// - Returns: True if the compose view was presented.
    @discardableResult
    public func composeEmail(to recipient: String, subject: String? = nil, body: String? = nil, cc: String? = nil) -> Bool {
        guard let url = URL(emailTo: recipient, subject: subject, body: body, cc: cc) else { return false }
        
        if #available(iOS 10.0, tvOS 9.0, *) {
            let result = canOpenURL(url)
            open(url, options: [:], completionHandler: nil)
            return result
        } else {
            return openURL(url)
        }
    }
    
    /// Navigates to the system maps app (Maps) to compose an email.
    ///
    /// - Parameters:
    ///   - builder:  The configured map url builder.
    ///
    /// - Returns: True if the url was opened.
    @discardableResult
    public func openMaps(_ builder: MapURLBuilder) -> Bool {
        guard let url = builder.url else { return false }
        
        if #available(iOS 10.0, tvOS 9.0, *) {
            let result = canOpenURL(url)
            open(url, options: [:], completionHandler: nil)
            return result
        } else {
            return openURL(url)
        }
    }
}

