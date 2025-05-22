//
//  UIViewController+Extensions.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import UIKit
import Combine

extension UIViewController {
    
    /// Adds a child view controller to the parent
    /// - Parameters:
    ///   - child: The child view controller to add
    ///   - containerView: The container view to add the child's view to
    func addChild(_ child: UIViewController, to containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.view.pinToSuperview()
        child.didMove(toParent: self)
    }
    
    /// Removes a child view controller from its parent
    func removeFromParentViewController() {
        guard parent != nil else { return }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    /// Dismisses the keyboard when tapping outside of a text field
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Combine extensions

extension UIViewController {
    
    /// Binds a loading publisher to show/hide loading indicator
    /// - Parameter publisher: The loading publisher to bind
    /// - Returns: A cancellable to store
    func bindLoading<T: BaseViewModel>(_ viewModel: T) -> AnyCancellable {
        return viewModel.isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                
                if isLoading {
                    if let baseVC = self as? BaseViewController {
                        baseVC.showLoading()
                    } else {
                        // For regular UIViewControllers, show a simple activity indicator
                        let activityIndicator = UIActivityIndicatorView(style: .large)
                        activityIndicator.center = self.view.center
                        activityIndicator.tag = 999
                        activityIndicator.startAnimating()
                        self.view.addSubview(activityIndicator)
                    }
                } else {
                    if let baseVC = self as? BaseViewController {
                        baseVC.hideLoading()
                    } else {
                        // For regular UIViewControllers, remove the activity indicator
                        if let activityIndicator = self.view.viewWithTag(999) as? UIActivityIndicatorView {
                            activityIndicator.stopAnimating()
                            activityIndicator.removeFromSuperview()
                        }
                    }
                }
            }
    }
    
    /// Binds an error publisher to show error alerts
    /// - Parameter publisher: The error publisher to bind
    /// - Returns: A cancellable to store
    func bindError<T: BaseViewModel>(_ viewModel: T) -> AnyCancellable {
        return viewModel.error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self else { return }
                
                if let baseVC = self as? BaseViewController {
                    baseVC.showError(error)
                } else {
                    self.presentErrorAlert(error)
                }
            }
    }
    
    // Note: showError method is implemented in BaseViewController
    // For non-BaseViewController classes, use this helper method
    func presentErrorAlert(_ error: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
