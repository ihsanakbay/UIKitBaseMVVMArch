//
//  UIView+Extensions.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import UIKit

extension UIView {
    
    /// Adds multiple subviews at once
    /// - Parameter views: The views to add
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    /// Pins the view to the edges of its superview
    /// - Parameter padding: The padding to apply to all edges
    func pinToSuperview(with padding: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            Logger.error("Cannot pin to superview: superview is nil")
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: padding.top),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding.right),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding.bottom)
        ])
    }
    
    /// Pins the view to the safe area of its superview
    /// - Parameter padding: The padding to apply to all edges
    func pinToSuperviewSafeArea(with padding: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            Logger.error("Cannot pin to superview safe area: superview is nil")
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: padding.top),
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: padding.left),
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -padding.right),
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -padding.bottom)
        ])
    }
    
    /// Centers the view in its superview
    func centerInSuperview() {
        guard let superview = superview else {
            Logger.error("Cannot center in superview: superview is nil")
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
    }
    
    /// Sets the width and height of the view
    /// - Parameters:
    ///   - width: The width to set
    ///   - height: The height to set
    func setSize(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    /// Adds a shadow to the view
    /// - Parameters:
    ///   - color: The shadow color
    ///   - opacity: The shadow opacity
    ///   - offset: The shadow offset
    ///   - radius: The shadow radius
    func addShadow(
        color: UIColor = .black,
        opacity: Float = 0.2,
        offset: CGSize = CGSize(width: 0, height: 2),
        radius: CGFloat = 4
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
    
    /// Rounds the corners of the view
    /// - Parameter radius: The corner radius
    func roundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    /// Adds a border to the view
    /// - Parameters:
    ///   - color: The border color
    ///   - width: The border width
    func addBorder(color: UIColor, width: CGFloat = 1.0) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
}
