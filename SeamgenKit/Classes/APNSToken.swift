//
//  APNSToken.swift
//  Pods
//
//  Created by Sam Gerardi on 12/20/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import Foundation


/** 
 Wraps the data object for an APNS token returned by the remote notifications methods
 in UIApplicationDelegate.
 
 For Example:

 ```
 func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let token = APNSToken(deviceToken)
    // Use token.
 }
 ```
*/
public struct APNSToken {
    
    /// The token data provided in init(_:)
    public let data: Data
    
    /// A string representation of the token.
    /// Example: 790bc691 eea10194 d80cea25 49d2d8ec 0fb439d1 54242532 db4edecf 97f9e092
    public let string: String
    
    /// Initializes the object with a device token.
    ///
    /// - Parameter token: The device token.
    init(_ token: Data) {
        data = token
        
        let nsData: NSData = NSData(data: token)
        
        string = NSString(format: "%@", nsData)
            .replacingOccurrences(of: "<", with: "")
            .replacingOccurrences(of: ">", with: "")
    }
    
}


extension APNSToken: CustomStringConvertible {
    
    public var description: String { return string }
}
