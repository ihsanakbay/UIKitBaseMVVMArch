//
//  DependencyContainer.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import Foundation

/// A container for managing dependencies
final class DependencyContainer {
    
    // MARK: - Singleton
    
    static let shared = DependencyContainer()
    
    // MARK: - Properties
    
    private var dependencies: [String: Any] = [:]
    
    // MARK: - Initialization
    
    private init() {}
    
    // MARK: - Public Methods
    
    /// Registers a dependency
    /// - Parameters:
    ///   - dependency: The dependency to register
    ///   - type: The type of the dependency
    func register<T>(_ dependency: T, for type: T.Type) {
        let key = String(describing: type)
        dependencies[key] = dependency
        Logger.debug("Registered dependency for type: \(key)")
    }
    
    /// Resolves a dependency
    /// - Parameter type: The type of the dependency to resolve
    /// - Returns: The resolved dependency
    func resolve<T>(_ type: T.Type) -> T? {
        let key = String(describing: type)
        let dependency = dependencies[key] as? T
        
        if dependency == nil {
            Logger.warning("Failed to resolve dependency for type: \(key)")
        }
        
        return dependency
    }
    
    /// Removes a dependency
    /// - Parameter type: The type of the dependency to remove
    func remove<T>(_ type: T.Type) {
        let key = String(describing: type)
        dependencies.removeValue(forKey: key)
        Logger.debug("Removed dependency for type: \(key)")
    }
}
