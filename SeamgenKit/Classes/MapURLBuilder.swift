//
//  MapURLBuilder.swift
//  SeamgenKit
//
//  Created by Sam Gerardi on 12/12/16.
//  Copyright © 2016 Seamgen. All rights reserved.
//

import Foundation
import MapKit


/// Defines the style of map to be displayed.
public enum MapType {
    case standard
    case satellite
    case hybrid
    case transit
    
    fileprivate var queryString: String {
        switch self {
        case .standard:     return "m"
        case .satellite:    return "k"
        case .hybrid:       return "h"
        case .transit:      return "r"
        }
    }
}


/// Defines the type of transportation used when getting directions.
public enum TransportType {
    case drive
    case walk
    case publicTransit
    
    fileprivate var queryString: String {
        switch self {
        case .drive:            return "d"
        case .walk:             return "w"
        case .publicTransit:    return "r"
        }
    }
}


/// Generartes URLs for use in launching the native maps applications.
/// See https://developer.apple.com/library/content/featuredarticles/iPhoneURLScheme_Reference/MapLinks/MapLinks.html#//apple_ref/doc/uid/TP40007899-CH5-SW1
public struct MapURLBuilder {
    
    /// Initializes an empty URL builder.
    public init() { }
    
    /// Initializes the URL builder with a query and optional search location.
    ///
    /// - Parameters:
    ///   - query:      The query string. This parameter is treated as if its value had been typed into the Maps search field by the user.
    ///   - location:   The search location.
    ///   - mapType:    The map type.
    public init(searchFor query: String, near location: CLLocationCoordinate2D? = nil, mapType: MapType? = nil) {
        self.query = query
        self.nearLocation = location
        self.mapType = mapType
    }
    
    /// Initializes the URL builder with an address to display on the map.
    ///
    /// - Parameters:
    ///   - address: The address to be displayed.
    ///   - mapType: The map type.
    public init(address: String, mapType: MapType? = nil) {
        self.address = address
        self.mapType = mapType
    }
    
    /// Initializes the URL builder with the pin coordinate and an optional label.
    ///
    /// - Parameters:
    ///   - coordinate: The coordinate of the pin on the map.
    ///   - label:      The label for the pin.
    ///   - mapType:    The map type.
    public init(pinAt coordinate: CLLocationCoordinate2D, label: String? = nil, mapType: MapType? = nil) {
        self.coordinate = coordinate
        self.query = label
        self.mapType = mapType
    }
    
    /// Initializes the URL builder configured for a directions to a given address.
    ///
    /// - Parameters:
    ///   - destination:    The destination address.
    ///   - source:         The starting address.
    ///   - transportType:  The transport type.
    ///   - mapType:        The map type.
    public init(directionsTo destination: String, from source: String? = nil, transportType: TransportType? = nil, mapType: MapType? = nil) {
        self.destinationAddress = destination
        self.sourceAddress = source
        self.transportType = transportType
        self.mapType = mapType
    }
    
    /// The map type. If you don’t specify one of the documented values, the current map type is used.
    public var mapType: MapType?
    
    /// The query. This property is treated as if its value had been typed into the Maps search field by the user. Note that `*` is not supported
    /// The query parameter can also be used as a label if the location is explicitly defined in the `coordinate` or `address` properties.
    ///
    /// A URL-encoded string that describes the search object, such as “pizza,” or an address to be geocoded
    public var query: String?
    
    /// The address. Using the address property simply displays the specified location, it does not perform a search for the location.
    /// An address string that geolocation can understand.
    public var address: String?
    
    /// A hint used during search. If the `searchLocation` property is missing or its value is incomplete, the value of `nearLocation` is used instead.
    public var nearLocation: CLLocationCoordinate2D?
    
    /// The location around which the map should be centered.
    /// The 'coordinate' property can also represent a pin location when you use the `query` parameter to specify a name.
    public var coordinate: CLLocationCoordinate2D?
    
    /// A floating point value between 2 and 21 that defines the area around the center point that should be displayed.
    /// You can use the `zoom` property only when you also use the `searchLocation` property;
    /// in particular, you can’t use `zoom` in combination with the `span` or `screenSpan` properties.
    public var zoom: Float?
    
    /// The area around the center point, or span. The center point is specified by the `coordinate` property.
    /// You can’t use the `span` property in combination with the `zoom` property.
    public var span: CLLocationCoordinate2D?
    
    /// The screen span. Use the `screenSpan` property to specify a span around the search location specified by the `searchLocation` property.
    public var screenSpan: CLLocationCoordinate2D?
    
    /// The source address to be used as the starting point for directions.
    /// A complete directions request includes the `sourceAddress`, `destinationAddress`, and `transportType` properties,
    /// but only the `destinationAddress` parameter is required.
    /// If you don’t specify a value for `sourceAddress`, the starting point is “here.”
    public var sourceAddress: String?
    
    /// The destination address to be used as the destination point for directions.
    /// A complete directions request includes the `sourceAddress`, `destinationAddress`, and `transportType`,
    /// but only the `destinationAddress` property is required.
    public var destinationAddress: String?
    
    /// The transport type.
    /// if you don’t specify any value, Maps uses the user’s preferred transport type or the previous setting.
    /// A complete directions request includes the `sourceAddress`, `destinationAddress`, and `transportType`,
    /// but only the `destinationAddress` property is required.
    public var transportType: TransportType?
    
    /// The search location. You can specify the `searchLocation` property by itself or in combination with the `query` property.
    /// For example, http://maps.apple.com/?sll=50.894967,4.341626&z=10&t=s is a valid query.
    public var searchLocation: CLLocationCoordinate2D?
    
    /// The output url for the combined parameters.
    public var url: URL? {
        var components = URLComponents(string: "http://maps.apple.com")!
        var queryItems: [URLQueryItem] = []
        
        // Map Type
        if let value = mapType?.queryString {
            queryItems.append(URLQueryItem(name: "t", value: value))
        }
        
        // Query
        if let value = query?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            queryItems.append(URLQueryItem(name: "q", value: value))
        }
        
        // Address
        if let value = address?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            queryItems.append(URLQueryItem(name: "address", value: value))
        }
        
        // Near
        if let value = nearLocation?.queryString {
            queryItems.append(URLQueryItem(name: "near", value: value))
        }
        
        // Coordinate
        if let value = coordinate?.queryString {
            queryItems.append(URLQueryItem(name: "ll", value: value))
        }
        
        // Zoom / Span
        let hasZoomParam = zoom != nil
        let hasSpanParam = span != nil
        let hasScreenScanParam = screenSpan != nil
        let hasCoordinateParam = coordinate != nil
        let hasSearchLocationParam = searchLocation != nil
        
        // Zoom
        if let zoom = zoom, hasSearchLocationParam, !hasSpanParam, !hasScreenScanParam {
            let zoomValue = max(min(zoom, 21), 2).description
            queryItems.append(URLQueryItem(name: "z", value: zoomValue))
        }
        
        // Span
        if let value = span?.queryString, !hasZoomParam, hasCoordinateParam {
            queryItems.append(URLQueryItem(name: "spn", value: value))
        }
        
        // Screen Span
        if let value = screenSpan?.queryString, hasSearchLocationParam {
            queryItems.append(URLQueryItem(name: "sspn", value: value))
        }
        
        // Search Location
        if let searchLocation = searchLocation?.queryString {
            queryItems.append(URLQueryItem(name: "sll", value: searchLocation))
        }
        
        // Destination Address
        if let destinationAddress = destinationAddress?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), !destinationAddress.isEmpty {
            queryItems.append(URLQueryItem(name: "daddr", value: destinationAddress))
            
            // Source Address
            if let sourceAddress = sourceAddress?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), !sourceAddress.isEmpty {
                queryItems.append(URLQueryItem(name: "saddr", value: sourceAddress))
            }
            
            // Transport Type
            if let transportType = transportType?.queryString {
                queryItems.append(URLQueryItem(name: "dirflag", value: transportType))
            }
        }
        
        // Ensure that some data has been entered.
        guard !queryItems.isEmpty else { return nil }
        
        components.queryItems = queryItems
        return components.url
    }
}


extension CLLocationCoordinate2D {
    
    fileprivate var queryString: String {
        return "\(latitude),\(longitude)"
    }
}

