//
//  UserPreferences.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import Foundation
import Combine

/// A class for managing user preferences
final class UserPreferences {
    
    // MARK: - Keys
    
    private enum Keys {
        static let isFirstLaunch = "isFirstLaunch"
        static let userTheme = "userTheme"
        static let userId = "userId"
    }
    
    // MARK: - Properties
    
    /// Shared instance
    static let shared = UserPreferences()
    
    /// UserDefaults instance
    private let defaults = UserDefaults.standard
    
    /// Publishers for preference changes
    private(set) var isFirstLaunchPublisher = CurrentValueSubject<Bool, Never>(true)
    private(set) var themePublisher = CurrentValueSubject<Theme, Never>(.system)
    
    // MARK: - Initialization
    
    private init() {
        // Initialize publishers with stored values
        isFirstLaunchPublisher = CurrentValueSubject<Bool, Never>(isFirstLaunch)
        themePublisher = CurrentValueSubject<Theme, Never>(theme)
    }
    
    // MARK: - Preferences
    
    /// Whether this is the first launch of the app
    var isFirstLaunch: Bool {
        get {
            return defaults.bool(forKey: Keys.isFirstLaunch)
        }
        set {
            defaults.set(newValue, forKey: Keys.isFirstLaunch)
            isFirstLaunchPublisher.send(newValue)
        }
    }
    
    /// The user's preferred theme
    var theme: Theme {
        get {
            if let storedTheme = defaults.string(forKey: Keys.userTheme),
               let theme = Theme(rawValue: storedTheme) {
                return theme
            }
            return .system
        }
        set {
            defaults.set(newValue.rawValue, forKey: Keys.userTheme)
            themePublisher.send(newValue)
        }
    }
    
    /// The user's ID
    var userId: String? {
        get {
            return defaults.string(forKey: Keys.userId)
        }
        set {
            defaults.set(newValue, forKey: Keys.userId)
        }
    }
    
    // MARK: - Methods
    
    /// Resets all user preferences
    func resetAll() {
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
        
        // Reset publishers
        isFirstLaunchPublisher.send(true)
        themePublisher.send(.system)
        
        Logger.info("All user preferences have been reset")
    }
}

/// Theme options for the app
enum Theme: String {
    case light
    case dark
    case system
}
