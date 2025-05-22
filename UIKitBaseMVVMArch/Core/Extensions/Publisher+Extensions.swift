//
//  Publisher+Extensions.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import Foundation
import Combine

extension Publisher {
    
    /// Transforms the publisher to handle loading state
    /// - Parameter isLoading: The loading state subject
    /// - Returns: A publisher with the same output and failure type
    func trackLoading(_ isLoading: CurrentValueSubject<Bool, Never>) -> AnyPublisher<Output, Failure> {
        return handleEvents(
            receiveSubscription: { _ in isLoading.send(true) },
            receiveCompletion: { _ in isLoading.send(false) },
            receiveCancel: { isLoading.send(false) }
        )
        .eraseToAnyPublisher()
    }
    
    /// Transforms the publisher to handle errors
    /// - Parameter errorSubject: The error subject
    /// - Returns: A publisher with the same output type and Never as failure type
    func handleErrors(_ errorSubject: PassthroughSubject<Failure, Never>) -> AnyPublisher<Output, Never> {
        return self.catch { error -> AnyPublisher<Output, Never> in
            errorSubject.send(error)
            return Empty().eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
    
    /// Transforms the publisher to handle both loading state and errors
    /// - Parameters:
    ///   - isLoading: The loading state subject
    ///   - errorSubject: The error subject
    /// - Returns: A publisher with the same output type and Never as failure type
    func trackLoadingAndHandleErrors(
        _ isLoading: CurrentValueSubject<Bool, Never>,
        _ errorSubject: PassthroughSubject<Failure, Never>
    ) -> AnyPublisher<Output, Never> {
        return self
            .trackLoading(isLoading)
            .handleErrors(errorSubject)
    }
    
    /// Transforms the publisher to handle both loading state and errors for a view model
    /// - Parameter viewModel: The view model
    /// - Returns: A publisher with the same output type and Never as failure type
    func bindToViewModel<T: BaseViewModel>(_ viewModel: T) -> AnyPublisher<Output, Never> where Failure == Error {
        return self
            .trackLoading(viewModel.isLoading)
            .handleErrors(viewModel.error)
    }
}
