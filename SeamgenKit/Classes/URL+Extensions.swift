//
//  URL+Extensions.swift
//  SeamgenKit
//
//  Created by Sam Gerardi on 12/12/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import Foundation


public extension URL {
    
    /**
     Creates a URL that can be used to dial a phone number when passed to UIApplication.shared.openURL(url).
 
     See [Apple URL Scheme Reference](https://developer.apple.com/library/content/featuredarticles/iPhoneURLScheme_Reference/PhoneLinks/PhoneLinks.html#//apple_ref/doc/uid/TP40007899-CH6-SW1)
     
     - Parameters:
        - phoneNumber: The number to dial.
     
     - Example: Dial a number
     
     ```
     if let url = URL(phoneCallTo: "1-760-555-1212") {
        UIApplication.shared.openURL(url)
     }
     ```
     */
    public init?(phoneCallTo phoneNumber: String) {
        guard let phoneNumber = phoneNumber.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else { return nil }
        guard !phoneNumber.isEmpty else { return nil }
        
        var components = URLComponents()
        components.scheme = "tel"
        components.path = phoneNumber
        
        guard let url = components.url else { return nil }
        
        self = url
    }

    /**
     Creates a URL that can be used to compose an email when passed to UIApplication.shared.openURL(url).
     
     See [Apple URL Scheme Reference](https://developer.apple.com/library/content/featuredarticles/iPhoneURLScheme_Reference/MailLinks/MailLinks.html#//apple_ref/doc/uid/TP40007899-CH4-SW1)
     
     - Parameters:
        - recipient:    The recipient of the email.
        - subject:      The subject line.
        - body:         The message body.
        - cc:           A CC email address.
     
     - Example: Compose an email
     
     ```
     if let url = URL(emailTo: "dev@seamgen.com") {
        UIApplication.shared.openURL(url)
     }
     ```
     */
    public init?(emailTo recipient: String, subject: String? = nil, body: String? = nil, cc: String? = nil) {
        guard !recipient.isEmpty else { return nil }
        var components = URLComponents()
        components.scheme = "mailto"
        components.path = recipient
        components.queryItems = {
            var queryItems: [URLQueryItem] = []
            
            if let subject = subject {
                queryItems.append(URLQueryItem(name: "subject", value: subject))
            }
            if let body = body {
                queryItems.append(URLQueryItem(name: "body", value: body))
            }
            if let cc = cc {
                queryItems.append(URLQueryItem(name: "cc", value: cc))
            }
            
            return queryItems.isEmpty ? nil : queryItems
        }()
        
        guard let url = components.url else { return nil }

        self = url
    }
    
    /**
     Creates a URL that can be used to compose an SMS when passed to UIApplication.shared.openURL(url).
     The phone number can only contain digits 0-9, "+", "-", and ".".  All other characters will be stripped before creating the URL.
     
     See [Apple URL Scheme Reference](https://developer.apple.com/library/content/featuredarticles/iPhoneURLScheme_Reference/SMSLinks/SMSLinks.html#//apple_ref/doc/uid/TP40007899-CH7-SW1)
     
     - Parameters:
         - phoneNumber: The recipient of the SMS message (optional).
     
     - Example: Compose an SMS
     
     ```
     if let url = URL(smsTo: "1-760-555-1212") {
        UIApplication.shared.openURL(url)
     }
     ```
     */
    public init?(smsTo phoneNumber: String?) {
        var components = URLComponents()
        components.scheme = "sms"
        
        if let phoneNumber = phoneNumber, !phoneNumber.isEmpty {
            let validCharacterSet = CharacterSet(charactersIn: "0123456789+-.")
            if let phoneNumberString = phoneNumber.includingCharactersIn(validCharacterSet), !phoneNumber.isEmpty {
                components.path = phoneNumberString
            }
        }
        
        guard let url = components.url else { return nil }
        self = url
    }
    
    static func test() {
        let _ = URL(smsTo: "")
    }
}

