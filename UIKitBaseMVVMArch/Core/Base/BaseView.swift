//
//  BaseView.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import UIKit

/// Protocol that all views must conform to
protocol ViewSetupable {
    /// Sets up the view hierarchy
    func setupHierarchy()
    
    /// Sets up the view constraints
    func setupConstraints()
    
    /// Configures the view's appearance
    func setupProperties()
}

/// Base class for all custom views
class BaseView: UIView, ViewSetupable {
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup
    
    /// Sets up the view
    private func setupView() {
        setupHierarchy()
        setupConstraints()
        setupProperties()
    }
    
    /// Sets up the view hierarchy
    func setupHierarchy() {
        // Override in subclasses
    }
    
    /// Sets up the view constraints
    func setupConstraints() {
        // Override in subclasses
    }
    
    /// Configures the view's appearance
    func setupProperties() {
        backgroundColor = .systemBackground
    }
}
