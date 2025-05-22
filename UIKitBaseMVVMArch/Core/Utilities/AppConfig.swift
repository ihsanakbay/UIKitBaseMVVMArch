//
//  AppConfig.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import Foundation

/// A struct for managing app configuration
struct AppConfig {
    
    // MARK: - Environment
    
    /// The current environment
    static let environment: Environment = {
        #if DEBUG
        return .development
        #else
        return .production
        #endif
    }()
    
    /// Whether the app is running in debug mode
    static let isDebug: Bool = {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }()
    
    // MARK: - API Configuration
    
    /// The base URL for the API
    static var apiBaseURL: URL {
        switch environment {
        case .development:
            return URL(string: "https://api-dev.example.com")!
        case .staging:
            return URL(string: "https://api-staging.example.com")!
        case .production:
            return URL(string: "https://api.example.com")!
        }
    }
    
    /// The API version
    static let apiVersion = "v1"
    
    /// The API timeout interval
    static let apiTimeoutInterval: TimeInterval = 30.0
    
    // MARK: - App Information
    
    /// The app's version
    static let appVersion: String = {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return "Unknown"
        }
        return version
    }()
    
    /// The app's build number
    static let buildNumber: String = {
        guard let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else {
            return "Unknown"
        }
        return build
    }()
    
    /// The app's bundle identifier
    static let bundleIdentifier = Bundle.main.bundleIdentifier ?? "Unknown"
    
    // MARK: - Logging
    
    /// Whether logging is enabled
    static var isLoggingEnabled: Bool {
        switch environment {
        case .development, .staging:
            return true
        case .production:
            return false
        }
    }
}

/// The environment the app is running in
enum Environment {
    case development
    case staging
    case production
    
    var name: String {
        switch self {
        case .development:
            return "Development"
        case .staging:
            return "Staging"
        case .production:
            return "Production"
        }
    }
}
