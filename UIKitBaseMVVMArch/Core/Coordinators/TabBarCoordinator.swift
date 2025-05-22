//
//  TabBarCoordinator.swift
//  UIKitBaseMVVMArch
//
//  Created by İhsan Akbay on 22.05.2025.
//

import UIKit

/// Coordinator for managing the tab bar
final class TabBarCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    
    private let tabBarController: BaseTabBarController
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController, tabBarController: BaseTabBarController = BaseTabBarController()) {
        self.tabBarController = tabBarController
        super.init(navigationController: navigationController)
    }
    
    // MARK: - Coordinator
    
    override func start() {
        Logger.info("Starting TabBarCoordinator")
        setupTabs()
        navigationController.setViewControllers([tabBarController], animated: false)
    }
    
    // MARK: - Setup
    
    /// Sets up the tabs for the tab bar
    private func setupTabs() {
        setupHomeTab()
        setupProfileTab()
        setupSettingsTab()
    }
    
    /// Sets up the home tab
    private func setupHomeTab() {
        let homeNavController = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: homeNavController)
        
        addChildCoordinator(homeCoordinator)
        homeCoordinator.start()
        
        tabBarController.addTabItem(
            viewController: homeNavController,
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
    }
    
    /// Sets up the profile tab
    private func setupProfileTab() {
        let profileNavController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavController)
        
        addChildCoordinator(profileCoordinator)
        profileCoordinator.start()
        
        tabBarController.addTabItem(
            viewController: profileNavController,
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
    }
    
    /// Sets up the settings tab
    private func setupSettingsTab() {
        let settingsNavController = UINavigationController()
        let settingsCoordinator = SettingsCoordinator(navigationController: settingsNavController)
        
        addChildCoordinator(settingsCoordinator)
        settingsCoordinator.start()
        
        tabBarController.addTabItem(
            viewController: settingsNavController,
            title: "Settings",
            image: UIImage(systemName: "gear"),
            selectedImage: UIImage(systemName: "gear")
        )
    }
}
