//
//  BaseViewModel.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import Foundation
import Combine

/// Protocol that all ViewModels must conform to
protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    /// Transforms inputs to outputs
    func transform(input: Input) -> Output
}

/// Base class for all ViewModels
class BaseViewModel {
    /// Cancellable storage for Combine subscriptions
    var cancellables = Set<AnyCancellable>()
    
    /// Loading state publisher
    let isLoading = CurrentValueSubject<Bool, Never>(false)
    
    /// Error state publisher
    let error = PassthroughSubject<Error, Never>()
    
    init() {
        Logger.debug("ViewModel initialized: \(type(of: self))")
    }
    
    deinit {
        Logger.debug("ViewModel deinitialized: \(type(of: self))")
        cancellables.removeAll()
    }
}

/// Custom error type for ViewModels
enum ViewModelError: LocalizedError {
    case general(String)
    case network(String)
    case parsing(String)
    case custom(Error)
    
    var errorDescription: String? {
        switch self {
        case .general(let message):
            return message
        case .network(let message):
            return "Network error: \(message)"
        case .parsing(let message):
            return "Parsing error: \(message)"
        case .custom(let error):
            return error.localizedDescription
        }
    }
}
