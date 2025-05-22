//
//  NetworkError.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import Foundation

/// Errors that can occur during network operations
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData
    case httpError(statusCode: Int, data: Data?)
    case decodingError(Error)
    case underlying(Error)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from the server"
        case .invalidData:
            return "Invalid data received from the server"
        case .httpError(let statusCode, _):
            return "HTTP error with status code: \(statusCode)"
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .underlying(let error):
            return "Underlying error: \(error.localizedDescription)"
        case .unknown:
            return "An unknown error occurred"
        }
    }
}
