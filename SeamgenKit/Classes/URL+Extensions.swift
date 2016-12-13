//
//  URL+Extensions.swift
//  SeamgenKit
//
//  Created by Sam Gerardi on 12/12/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import Foundation


public extension URL {

    /*
     For more information, see:
     https://developer.apple.com/library/content/featuredarticles/iPhoneURLScheme_Reference/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007899-CH1-SW1
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
}

