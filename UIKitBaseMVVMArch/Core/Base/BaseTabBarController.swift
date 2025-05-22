//
//  BaseTabBarController.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import UIKit
import Combine

/// Base class for tab bar controllers in the application
class BaseTabBarController: UITabBarController {
    
    /// Set of cancellables for managing Combine subscriptions
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        Logger.debug("TabBarController loaded: \(type(of: self))")
    }
    
    deinit {
        Logger.debug("TabBarController deinitialized: \(type(of: self))")
        cancellables.removeAll()
    }
    
    // MARK: - Setup
    
    /// Sets up the tab bar appearance
    func setupTabBar() {
        // Default appearance
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .systemBackground
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithDefaultBackground()
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    
    /// Adds a view controller to the tab bar
    /// - Parameters:
    ///   - viewController: The view controller to add
    ///   - title: The title of the tab
    ///   - image: The image of the tab
    ///   - selectedImage: The selected image of the tab
    func addTabItem(
        viewController: UIViewController,
        title: String,
        image: UIImage?,
        selectedImage: UIImage? = nil
    ) {
        viewController.tabBarItem = UITabBarItem(
            title: title,
            image: image,
            selectedImage: selectedImage
        )
        
        if viewControllers == nil {
            viewControllers = [viewController]
        } else {
            viewControllers?.append(viewController)
        }
    }
}
