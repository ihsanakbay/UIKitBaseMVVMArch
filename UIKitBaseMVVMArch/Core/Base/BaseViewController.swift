//
//  BaseViewController.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import UIKit
import Combine

/// Base class for all view controllers in the application
class BaseViewController: UIViewController {
    
    /// Set of cancellables for managing Combine subscriptions
    var cancellables = Set<AnyCancellable>()
    
    /// Activity indicator for loading states
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        Logger.debug("ViewController loaded: \(type(of: self))")
    }
    
    deinit {
        Logger.debug("ViewController deinitialized: \(type(of: self))")
        cancellables.removeAll()
    }
    
    /// Sets up the view's appearance and constraints
    func setupView() {
        view.backgroundColor = .systemBackground
        setupActivityIndicator()
    }
    
    /// Sets up the activity indicator
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    /// Shows the loading indicator
    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
    
    /// Hides the loading indicator
    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
    
    /// Shows an alert with the given title and message
    /// - Parameters:
    ///   - title: The title of the alert
    ///   - message: The message of the alert
    ///   - buttonTitle: The title of the button
    ///   - completion: The completion handler
    func showAlert(title: String, message: String, buttonTitle: String = "OK", completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completion?()
        }
        alert.addAction(action)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
    
    /// Shows an error alert
    /// - Parameter error: The error to display
    @objc func showError(_ error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
        Logger.error("Error shown: \(error.localizedDescription)")
    }
}
