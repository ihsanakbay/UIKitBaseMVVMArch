//
//  Endpoint.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import Foundation

/// HTTP methods for network requests
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

/// Protocol for defining API endpoints
protocol EndpointType {
    /// Base URL of the API
    var baseURL: URL { get }
    
    /// Path of the endpoint
    var path: String { get }
    
    /// HTTP method to use
    var method: HTTPMethod { get }
    
    /// HTTP headers to include
    var headers: [String: String]? { get }
    
    /// Query parameters to include
    var queryParameters: [String: String]? { get }
    
    /// HTTP body to include
    var body: Data? { get }
    
    /// Full URL of the endpoint
    var url: URL? { get }
}

/// Struct for defining API endpoints
struct Endpoint: EndpointType {
    /// Base URL of the API
    let baseURL: URL
    
    /// Path of the endpoint
    let path: String
    
    /// HTTP method to use
    let method: HTTPMethod
    
    /// HTTP headers to include
    let headers: [String: String]?
    
    /// Query parameters to include
    let queryParameters: [String: String]?
    
    /// HTTP body to include
    let body: Data?
    
    /// Initializes a new endpoint
    /// - Parameters:
    ///   - baseURL: Base URL of the API
    ///   - path: Path of the endpoint
    ///   - method: HTTP method to use
    ///   - headers: HTTP headers to include
    ///   - queryParameters: Query parameters to include
    ///   - body: HTTP body to include
    init(
        baseURL: URL,
        path: String,
        method: HTTPMethod = .get,
        headers: [String: String]? = nil,
        queryParameters: [String: String]? = nil,
        body: Data? = nil
    ) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.headers = headers
        self.queryParameters = queryParameters
        self.body = body
    }
    
    /// Full URL of the endpoint
    var url: URL? {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        if let queryParameters = queryParameters, !queryParameters.isEmpty {
            components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        return components.url
    }
}
