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
        return Bundle.main.localizedInfoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    /// The build number from the info.plist (CFBundleVersionKey)
    public var buildNumber: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
    
    /// The bundle identifier from the info.plist (CFBundleIdentifierKey)
    public var bundleIdentifier: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleIdentifierKey as String) as! String
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
        
        if #available(iOS 10.0, *) {
            let result = canOpenURL(url)
            open(url, options: [:], completionHandler: nil)
            return result
        } else {
            return openURL(url)
        }
    }
    
    @discardableResult
    public func dial(_ phoneNumber: String) -> Bool {
        guard let url = URL(phoneCallTo: phoneNumber) else { return false }
        
        if #available(iOS 10.0, *) {
            let result = canOpenURL(url)
            open(url, options: [:], completionHandler: nil)
            return result
        } else {
            return openURL(url)
        }
    }
    
    @discardableResult
    public func composeSMS(to phoneNumber: String? = nil) -> Bool {
        guard let url = URL(smsTo: phoneNumber) else { return false }
        
        if #available(iOS 10.0, *) {
            let result = canOpenURL(url)
            open(url, options: [:], completionHandler: nil)
            return result
        } else {
            return openURL(url)
        }
    }
    
    @discardableResult
    public func composeEmail(to recipient: String, subject: String? = nil, body: String? = nil, cc: String? = nil) -> Bool {
        guard let url = URL(emailTo: recipient, subject: subject, body: body, cc: cc) else { return false }
        
        if #available(iOS 10.0, *) {
            let result = canOpenURL(url)
            open(url, options: [:], completionHandler: nil)
            return result
        } else {
            return openURL(url)
        }
    }
}

