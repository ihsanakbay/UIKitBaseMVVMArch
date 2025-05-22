//
//  NetworkService.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import Foundation
import Combine

/// Protocol defining network service capabilities
protocol NetworkServiceType {
    /// Performs a network request and returns a publisher with the decoded result
    /// - Parameters:
    ///   - request: The request to perform
    ///   - type: The type to decode the response to
    /// - Returns: A publisher with the decoded result
    func request<T: Decodable>(_ request: URLRequest, type: T.Type) -> AnyPublisher<T, NetworkError>
    
    /// Creates a URLRequest from the given endpoint
    /// - Parameter endpoint: The endpoint to create the request from
    /// - Returns: A URLRequest
    func createRequest(from endpoint: Endpoint) -> URLRequest?
}

/// Service for performing network requests
final class NetworkService: NetworkServiceType {
    
    /// URLSession to use for network requests
    private let session: URLSession
    
    /// Initializes a new network service
    /// - Parameter session: The URLSession to use for network requests
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    /// Performs a network request and returns a publisher with the decoded result
    /// - Parameters:
    ///   - request: The request to perform
    ///   - type: The type to decode the response to
    /// - Returns: A publisher with the decoded result
    func request<T: Decodable>(_ request: URLRequest, type: T.Type) -> AnyPublisher<T, NetworkError> {
        Logger.info("Performing request: \(request.url?.absoluteString ?? "unknown")")
        
        return session.dataTaskPublisher(for: request)
            .tryMap { [weak self] data, response -> Data in
                self?.logResponse(data: data, response: response)
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.httpError(statusCode: httpResponse.statusCode, data: data)
                }
                
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                if let networkError = error as? NetworkError {
                    return networkError
                } else if let decodingError = error as? DecodingError {
                    return NetworkError.decodingError(decodingError)
                } else {
                    return NetworkError.underlying(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    /// Creates a URLRequest from the given endpoint
    /// - Parameter endpoint: The endpoint to create the request from
    /// - Returns: A URLRequest
    func createRequest(from endpoint: Endpoint) -> URLRequest? {
        guard let url = endpoint.url else {
            Logger.error("Failed to create URL from endpoint: \(endpoint.path)")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        if let body = endpoint.body {
            request.httpBody = body
        }
        
        return request
    }
    
    /// Logs the response from a network request
    /// - Parameters:
    ///   - data: The data received
    ///   - response: The response received
    private func logResponse(data: Data, response: URLResponse) {
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        Logger.debug("Response status code: \(httpResponse.statusCode)")
        
        if let url = httpResponse.url {
            Logger.debug("Response URL: \(url.absoluteString)")
        }
        
        if let dataString = String(data: data, encoding: .utf8) {
            if dataString.count > 500 {
                Logger.debug("Response data (truncated): \(String(dataString.prefix(500)))...")
            } else {
                Logger.debug("Response data: \(dataString)")
            }
        }
    }
}
